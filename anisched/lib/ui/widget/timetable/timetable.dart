import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/smoothscroll.dart';
import 'package:anisched/ui/widget/timetable/item/item.dart';
import 'package:anisched/ui/widget/timetable/provider.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {

    final int? week;
    final List<Anime>? animeList;

    final double height;
    final Function? onItemClick;
    final bool wantKeepAlive;
    final Axis? scrollAxis;

    const TimeTable.week({ required this.week, required this.height, this.onItemClick, this.wantKeepAlive = true, this.scrollAxis, key }) : animeList = null, super(key: key);
    const TimeTable.list({ required this.animeList, required this.height, this.onItemClick, this.wantKeepAlive = true, this.scrollAxis, key }) : week = null, super(key: key);

    @override
    _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with AutomaticKeepAliveClientMixin {

    final TimeTableDataProvider _dataProvider = TimeTableDataProvider();

    final ScrollController _scrollController = ScrollController();

    List<Anime>? _animeList;

    @override
    void initState() {
        super.initState();
        _initObservers();

        _animeList = widget.animeList;
        
        if (widget.animeList == null) {
            _dataProvider.requestSchedule(widget.week!);
        }
    }

    void _initObservers() {
        _dataProvider.getScheduleList!.addObserver(Observer((data) {
            setState(() {
                _animeList = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);

        if (widget.week == null) {
            _animeList = widget.animeList;
        }

        return (_animeList != null) ? Container(
            height: widget.height,
            child: SmoothScroll(
                scrollAxis: widget.scrollAxis,
                child: ListView.separated(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _animeList!.length,
                    itemBuilder: (context, index) {
                        EdgeInsets padding = EdgeInsets.zero;
                        if (index == 0) {
                            padding = EdgeInsets.only(left: Sizes.SIZE_020);
                        } else if (index == _animeList!.length - 1) {
                            padding = EdgeInsets.only(right: Sizes.SIZE_020);
                        }
                        return Padding(
                            padding: padding,
                            child: TimeTableItem(
                                anime: _animeList![index],
                                width: widget.height * 0.7,
                                onItemClick: widget.onItemClick,
                                wantKeepAlive: widget.wantKeepAlive,
                            ),
                        );
                    }, 
                    separatorBuilder: (context, index) => Container(width: Sizes.SIZE_010), 
                ),
            ),
        ) : LoadingIndicator();
    }

    @override
    bool get wantKeepAlive => widget.wantKeepAlive;
}
