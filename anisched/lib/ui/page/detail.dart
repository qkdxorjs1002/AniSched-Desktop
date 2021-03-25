import 'dart:ui';

import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
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
    final api = AnissiaService();

    List<Caption> captionList;

    @override
    void initState() {
        super.initState();
        api.requestCaption(widget.anime.id).then((value) {
            setState(() {
                captionList = value;
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: CustomAppBar(
                title: Text(
                    widget.anime.subject,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                ),
                backdrop: Image.network(
                    "https://image.tmdb.org/t/p/original/aOQL8UYduNxDePbynZROLZ1nfsf.jpg",
                    fit: BoxFit.cover,
                ),
                body: CaptionSliverList(
                    list: captionList,
                    onItemClickListener: OnItemClickListener(
                        onItemClick: (Caption caption) async => Tool.openURL(caption.website)
                    ),
                ),
            ),
        );
    }
}