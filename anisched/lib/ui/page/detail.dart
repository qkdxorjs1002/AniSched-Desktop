import 'dart:ui';

import 'package:anisched/_API_KEY.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/tmdb/service.dart';
import 'package:anisched/tool.dart';
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
    final anissia = AnissiaService();
    final tmdb = TMDBService();

    List<Caption> captionList;
    String backdrop = "";
    bool collapsed = true;

    @override
    void initState() {
        super.initState();
        anissia.requestCaption(widget.anime.id).then((value) {
            setState(() {
                captionList = value;
            });

            tmdb.requestSearch(APIKey.TMDB_API_KEY,"ko-KR", widget.anime.subject).then((value) {
                setState(() {
                    if (value.resultList != null && value.resultList.isNotEmpty) {
                        backdrop = value.resultList[0].getBackdropPath;
                        collapsed = false;
                    }
                });
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Row(
                children: [
                    Expanded(
                        child: CustomAppBar(
                            collapsed: collapsed,
                            title: Text(
                                widget.anime.subject,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                            ),
                            backdrop: backdrop.isNotEmpty ? Image.network(
                                backdrop,
                                fit: BoxFit.cover,
                            ) : null,
                            body: CaptionSliverList(
                                list: captionList,
                                onItemClickListener: OnItemClickListener(
                                    onItemClick: (Caption caption) async => Tool.openURL(caption.website)
                                ),
                            ),
                        ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: double.infinity,
                    ),
                ],
            ),
        );
    }
}