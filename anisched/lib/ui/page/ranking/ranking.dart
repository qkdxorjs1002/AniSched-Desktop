import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/page/ranking/provider.dart';
import 'package:anisched/ui/widget/appbar.dart';
import 'package:anisched/ui/widget/listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {

    final RankingDataProvider dataProvider = RankingDataProvider();
    final String factor;
    
    Ranking({ Key key, this.factor }) : super(key: key);

    @override
    _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {

    List<Rank> rankList;

    @override
    void initState() {
        super.initState();
        initObservers();

        widget.dataProvider.requestRanking(widget.factor);
    }

    void initObservers() {
        widget.dataProvider.getAnime.addObserver(Observer((Anime data) {
            Navigator.push(context, CupertinoPageRoute(
                builder: (context) => DetailPage(
                    anime: data,
                )
            ));
        }));

        widget.dataProvider.getRankList.addObserver(Observer((List<Rank> data) {
            setState(() {
                rankList = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        return CustomAppBar(
            title: Text("주간 순위"),
            body: RankSliverList(
                list: rankList,
                onItemClickListener: OnItemClickListener(
                    onItemClick: (Rank rank) {
                        widget.dataProvider.requestAnime(rank.id);
                    }
                ),
            )
        );
    }
}