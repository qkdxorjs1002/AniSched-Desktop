import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/ui/page/detail.dart';
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
        return Container(
            color: Color.fromRGBO(15, 15, 15, 1),
            child: Column(
                children: [
                    SizedBox(
                        width: double.infinity,
                        child: Container(
                            color: Color.fromRGBO(30, 30, 30, 1),
                            child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                                child: Center(
                                    child: Text(
                                        "주간 순위",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ),
                    Expanded(
                        child: RankListView(
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
                        ),
                    ),
                ],
            ),
        );
    }
}