import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/ui/page/detail.dart';
import 'package:anisched/ui/widget/listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar.dart';

class Schedule extends StatefulWidget {
    final int week;
    
    const Schedule({ Key key, this.week }) : super(key: key);

    @override
    _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
    final api = AnissiaService();

    List<Anime> animeList;

    @override
    void initState() {
        super.initState();
        api.requestSchedule(widget.week).then((value) {
            setState(() {
                animeList = value;
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return CustomAppBar(
            title: Text(
                "title",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
            ),
            backdrop: Image.network(
                "https://image.tmdb.org/t/p/original/aOQL8UYduNxDePbynZROLZ1nfsf.jpg",
                fit: BoxFit.cover,
            ),
            body: AnimeSliverList(
                list: animeList,
                onItemClickListener: OnItemClickListener(
                    onItemClick: (anime) {
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (context) => DetailPage(
                                anime: anime,
                            )
                        ));
                    }
                ),
            ),
        );
    }
}