import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/tool.dart';
import 'package:anisched/ui/page/detail/provider.dart';
import 'package:anisched/ui/widget/appbar.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

    final Anime anime;
    
    const DetailPage({ Key key, this.anime }) : super(key: key);

    @override
    _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

    final DetailDataProvider dataProvider = DetailDataProvider();
    
    bool appBarCollapsed = true;
    
    Result tmdbResult;
    List<Caption> captionList;

    OnItemClickListener onCaptionListItemClickListener;

    @override
    void initState() {
        super.initState();
        initObservers();
        initEvents();

        dataProvider.requestCaption(widget.anime.id);
        dataProvider.requestTMDB(widget.anime);
    }

    void initObservers() {
        dataProvider.getCaptionList.addObserver(Observer((List<Caption> data) {
            setState(() {
                captionList = data;
            });
        }));

        dataProvider.getTMDBResult.addObserver(Observer((Result data) {
            setState(() {
                tmdbResult = data;
                appBarCollapsed = false;
            });
        }));
    }

    void initEvents() {
        onCaptionListItemClickListener = OnItemClickListener(
            onItemClick: (Caption caption) async => Tool.openURL(caption.website)
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Row(
                children: [
                    Expanded(
                        child: CustomAppBar(
                            collapsed: appBarCollapsed,
                            leading: false,
                            title: Text(
                                widget.anime.subject,
                                style: TextStyle(
                                    fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                            ),
                            backdrop: tmdbResult == null ? null : tmdbResult.getBackdropPath(Result.W1280),
                            body: SliverList(
                                delegate: SliverChildListDelegate(
                                    [
                                        Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Expanded(
                                                        child: Padding(
                                                        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                    Padding(
                                                                        padding: EdgeInsets.only(),
                                                                        child: Text(
                                                                            "시간",
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(bottom: 16),
                                                                        child: Text(
                                                                            widget.anime.getTimeString,
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(),
                                                                        child: Text(
                                                                            "방영 시작",
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(bottom: 16),
                                                                        child: Text(
                                                                            widget.anime.getStartDateString,
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(),
                                                                        child: Text(
                                                                            "종영",
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(bottom: 16),
                                                                        child: Text(
                                                                            widget.anime.getEndDateString,
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(),
                                                                        child: Text(
                                                                            "장르",
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.only(bottom: 16),
                                                                        child: Wrap(
                                                                            children: widget.anime.getGenreList.map((e) {
                                                                                return Padding(
                                                                                    padding: EdgeInsets.only(top: 8,right: 5),
                                                                                    child: Chip(
                                                                                        elevation: 0,
                                                                                        label: Text(e),
                                                                                    ),
                                                                                );
                                                                            }).toList(),
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                                                        child: tmdbResult == null ? null : ImageNetwork(
                                                            tmdbResult.getPosterPath(Result.W300),
                                                            height: MediaQuery.of(context).size.height * 0.3,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.all(16),
                                        ),
                                    ],
                                ),
                            )
                        ),
                    ),
                    SizedBox(
                        width: 1,
                        height: double.infinity,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: double.infinity,
                        child: Container(
                            color: Color.fromRGBO(15, 15, 15, 1),
                            child: CustomAppBar(
                                title: Text("자막"),
                                body: CaptionSliverList(
                                    list: captionList,
                                    onItemClickListener: onCaptionListItemClickListener,
                                ),
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}