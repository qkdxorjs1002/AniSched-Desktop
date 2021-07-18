import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/timetable/item/provider.dart';
import 'package:flutter/material.dart';

class TimeTableItem extends StatefulWidget {

    final Anime anime;
    final Function onItemClick;

    const TimeTableItem(this.anime, { this.onItemClick, Key key }) : super(key: key);

    @override
    _TimeTableItemState createState() => _TimeTableItemState();
}

class _TimeTableItemState extends State<TimeTableItem> with AutomaticKeepAliveClientMixin {

    final TimeTableItemDataProvider dataProvider = TimeTableItemDataProvider();

    Result tmdbResult;

    @override
    void initState() {
        super.initState();
        initObservers();

        dataProvider.requestTMDB(widget.anime);
    }

    void initObservers() {
        dataProvider.getTMDBResult.addObserver(Observer((Result data) {
            setState(() {
                tmdbResult = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        
        return (widget.anime != null) ? Container(
            color: Colors.white10,
            width: Sizes.SIZE_210,
            child: Stack(
                children: [
                    Stack(
                        fit: StackFit.expand,
                        children: [
                            (tmdbResult != null)
                            ? ImageNetwork(source: tmdbResult.getPosterPath(TMDBImageSizes.W500))
                            : Center(
                                child: Text(
                                    "NO IMAGE",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: Sizes.SIZE_012,
                                    ),
                                ),
                            ),
                            Container(
                                color: (widget.anime.isEnd || !widget.anime.isStatus)
                                    ? Colors.black.withOpacity(0.5)
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
                                            color: Colors.white,
                                            fontSize: Sizes.SIZE_014,
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
                                            widget.anime.subject,
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_016,
                                                height: 1.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                        ),
                                        Text(
                                            "${widget.anime.getTimeString} • ${widget.anime.getGenreString}",
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_012,
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
                                    widget.onItemClick(widget.anime, tmdbResult);
                                }
                            }
                        ),
                    ),
                ],
            ),
        ) : LoadingIndicator();
    }

    @override
    bool get wantKeepAlive => true;
}
