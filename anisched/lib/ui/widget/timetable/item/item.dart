import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/timetable/item/provider.dart';
import 'package:flutter/material.dart';

class TimeTableItem extends StatefulWidget {

    final Anime anime;

    final double width;

    final Function? onItemClick;

    final bool wantKeepAlive;

    const TimeTableItem({ required this.anime, required this.width, this.onItemClick, this.wantKeepAlive = true, Key? key }) : super(key: key);

    @override
    _TimeTableItemState createState() => _TimeTableItemState();
}

class _TimeTableItemState extends State<TimeTableItem> with AutomaticKeepAliveClientMixin {

    final TimeTableItemDataProvider _dataProvider = TimeTableItemDataProvider();

    Result? _tmdbResult;

    @override
    void initState() {
        super.initState();
        initObservers();

        _dataProvider.requestTMDB(widget.anime);
    }

    void initObservers() {
        _dataProvider.getTMDBResult!.addObserver(Observer((Result data) {
            setState(() {
                _tmdbResult = data;
            });
        }));
    }

    @override
    void didUpdateWidget(covariant TimeTableItem oldWidget) {
        super.didUpdateWidget(oldWidget);
        _dataProvider.requestTMDB(widget.anime);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        
        return Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            width: widget.width,
            child: Stack(
                children: [
                    Stack(
                        fit: StackFit.expand,
                        children: [
                            (_tmdbResult != null)
                            ? ImageNetwork(source: _tmdbResult!.getPosterPath(TMDBImageSizes.W500))
                            : Center(
                                child: Text(
                                    "NO IMAGE",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor.withOpacity(0.54),
                                        fontSize: Sizes.SIZE_012,
                                        fontWeight: FontWeight.w300,
                                    ),
                                ),
                            ),
                            Container(
                                color: (widget.anime.getExtraInfo.isNotEmpty)
                                    ? Theme.of(context).colorScheme.background.withOpacity(0.5)
                                    : Colors.transparent,
                            ),
                            Align(
                                alignment: Alignment.topCenter,
                                child: (widget.anime.getExtraInfo.isNotEmpty) ? BackBlur(
                                    height: Sizes.SIZE_024,
                                    childAlignment: Alignment.center,
                                    child: Text(
                                        widget.anime.getExtraInfo,
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: Sizes.SIZE_014,
                                            fontWeight: FontWeight.w300,
                                        ),
                                    ),
                                ) : null,
                            ),
                        ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: BackBlur(
                            width: double.infinity,
                            height: Sizes.SIZE_080,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Sizes.SIZE_016),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            widget.anime.subject!,
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_016,
                                                fontWeight: FontWeight.w500,
                                                height: 1.2,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                        ),
                                        Text(
                                            "${widget.anime.getTimeString} ᐧ ${widget.anime.getGenreString}",
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_012,
                                                fontWeight: FontWeight.w300,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    ),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                                if (widget.onItemClick != null) {
                                    widget.onItemClick!(widget.anime, _tmdbResult);
                                }
                            }
                        ),
                    ),
                ],
            ),
        );
    }

    @override
    bool get wantKeepAlive => widget.wantKeepAlive;
}
