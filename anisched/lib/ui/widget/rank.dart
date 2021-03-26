import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/ui/page/detail.dart';
import 'package:anisched/ui/widget/appbar.dart';
import 'package:anisched/ui/widget/listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
    final String factor;
    
    const Ranking({ Key key, this.factor }) : super(key: key);

    @override
    _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
    final api = AnissiaService();

    List<Rank> rankList;

    @override
    void initState() {
        super.initState();
        api.requestRanking(widget.factor).then((value) {
            setState(() {
                rankList = value;
            });
        });
    }

    @override
    Widget build(BuildContext context) {
        return CustomAppBar(
            title: Text("주간 순위"),
            body: RankSliverList(
                list: rankList,
                onItemClickListener: OnItemClickListener(
                    onItemClick: (rank) {
                        api.requestAnime(rank.id).then((value) {
                            Navigator.push(context, CupertinoPageRoute(
                                builder: (context) => DetailPage(
                                    anime: value,
                                )
                            ));
                        });
                    }
                ),
            )
        );
    }
}