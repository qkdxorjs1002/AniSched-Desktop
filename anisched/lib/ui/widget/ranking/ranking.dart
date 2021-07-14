import 'dart:ui';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/ranking/item/item.dart';
import 'package:anisched/ui/widget/ranking/provider.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {

    const Ranking({ Key key }) : super(key: key);

    @override
    _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {

    final RankingDataProvider dataProvider = RankingDataProvider();

    double page = 0;

    List<Rank> rankList;

    @override
    void initState() {
        super.initState();
        initObservers();

        dataProvider.requestRanking();
    }

    void initObservers() {
        dataProvider.getRankList.addObserver(Observer((data) {
            setState(() {
                rankList = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);
        final PageController pageController = PageController(initialPage: 0);

        pageController.addListener(() {
            setState(() {
                page = pageController.page;
            });
        });

        return rankList != null ? Container(
            height: scale.actualLongestSide * 0.28,
            child: Stack(
                children: [
                    PageView.builder(
                        allowImplicitScrolling: true,
                        physics: BouncingScrollPhysics(),
                        controller: pageController,
                        itemCount: rankList.length,
                        itemBuilder: (context, index) => RankingItem(rankList[index]),
                    ),
                    Row(
                        children: [
                            _navigator(
                                text: "◀", 
                                onTap: () {
                                    pageController.previousPage(
                                        duration: Duration(
                                            milliseconds: 350
                                        ), 
                                        curve: Curves.easeInOut
                                    );
                                },
                                enabled: (page > 0),
                            ),
                            Expanded(
                                child: Container(),
                            ),
                            _navigator(
                                text: "▶", 
                                onTap: () {
                                    pageController.nextPage(
                                        duration: Duration(
                                            milliseconds: 350
                                        ), 
                                        curve: Curves.easeInOut
                                    );
                                },
                                enabled: (page < rankList.length - 1),
                            ),
                        ],
                    ),
                ],
            ),
        ) : LoadingIndicator();
    }

    Widget _navigator({ String text, Function onTap, bool enabled }) {
        final Scale scale = Scale(context);

        return Material(
            color: Colors.transparent,
            child: !enabled ? null : InkWell(
                onTap: onTap,
                child: Container(
                    width: scale.actualLongestSide * 0.03,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                        text,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            fontSize: scale.actualLongestSide * 0.01,
                            shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 10.0,
                                    offset: Offset.fromDirection(0, 0),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
