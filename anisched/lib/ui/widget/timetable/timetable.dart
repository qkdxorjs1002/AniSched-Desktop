import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/timetable/item/item.dart';
import 'package:anisched/ui/widget/timetable/provider.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {

    final int week;
    
    final Function? onItemClick;

    const TimeTable( { required this.week, this.onItemClick, key }) : super(key: key);

    @override
    _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with AutomaticKeepAliveClientMixin {

    final TimeTableDataProvider _dataProvider = TimeTableDataProvider();

    List<Anime>? _animeList;

    @override
    void initState() {
        super.initState();
        initObservers();

        _dataProvider.requestSchedule(widget.week);
    }

    void initObservers() {
        _dataProvider.getScheduleList!.addObserver(Observer((data) {
            setState(() {
                _animeList = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        
        return (_animeList != null) ? Container(
            height: Sizes.SIZE_300,
            child: ListView.separated(
                shrinkWrap: true,
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
                            _animeList![index],
                            onItemClick: (anime, tmdb) => widget.onItemClick!(anime, tmdb),
                        ),
                    );
                }, 
                separatorBuilder: (context, index) => Container(width: Sizes.SIZE_010), 
            ),
        ) : LoadingIndicator();
    }

    @override
    bool get wantKeepAlive => true;
}
