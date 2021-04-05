import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/tool.dart';
import 'package:anisched/ui/page/detail/provider.dart';
import 'package:anisched/ui/widget/appbar.dart';
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
    String backdropPath;

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
                backdropPath = data.getBackdropPath;
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
                            backdrop: backdropPath,
                            body: CaptionSliverList(
                                list: captionList,
                                onItemClickListener: onCaptionListItemClickListener,
                            ),
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