import 'dart:async';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/pagenav.dart';
import 'package:anisched/ui/widget/ranking/item/item.dart';
import 'package:anisched/ui/widget/ranking/provider.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {

    final Function? onItemClick;

    const Ranking({ this.onItemClick, key }) : super(key: key);

    @override
    _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> with AutomaticKeepAliveClientMixin {

    final RankingDataProvider dataProvider = RankingDataProvider();
    final PageController pageController = PageController(initialPage: 0);

    late Timer transitionTimer;

    double? page = 0;

    List<Rank>? rankList;

    @override
    void initState() {
        super.initState();
        initObservers();
        initEvents();

        dataProvider.requestRanking();
    }

    void initObservers() {
        dataProvider.getRankList!.addObserver(Observer((data) {
            setState(() {
                rankList = data;
            });
            transitionTimer = _initTransition();
        }));
    }

    void initEvents() {
        pageController.addListener(() {
            setState(() {
                page = pageController.page;
            });
            transitionTimer.cancel();
            transitionTimer = _initTransition();
        });
    }

    @override
    void dispose() {
        pageController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);

        return rankList != null ? Container(
            height: Sizes.SIZE_560,
            child: Stack(
                children: [
                    PageView.builder(
                        allowImplicitScrolling: true,
                        physics: const ClampingScrollPhysics(),
                        controller: pageController,
                        itemCount: rankList!.length,
                        itemBuilder: (context, index) => RankingItem(
                            rank: rankList![index], 
                            onItemClick: (anime, tmdb) => widget.onItemClick!(anime, tmdb),
                        ),
                    ),
                    PageNavigator(
                        onLeftTap: () {
                            pageController.previousPage(
                                duration: const Duration(
                                    milliseconds: 350,
                                ), 
                                curve: Curves.easeInOut
                            );
                        },
                        enableLeft: (page! > 0),
                        onRightTap: () {
                            pageController.nextPage(
                                duration: const Duration(
                                    milliseconds: 350,
                                ), 
                                curve: Curves.easeInOut
                            );
                        },
                        enableRight: (page! < rankList!.length - 1),
                    ),
                ],
            ),
        ) : LoadingIndicator();
    }

    Timer _initTransition() {
        return Timer(
            const Duration(seconds: 6), 
            () {
                if (page! < rankList!.length - 1) {
                    pageController.nextPage(
                        duration: const Duration(
                            milliseconds: 350,
                        ), 
                        curve: Curves.easeInOut
                    );
                } else {
                    pageController.jumpTo(0);
                }
            }
        );
    }

    @override
    bool get wantKeepAlive => true;
}
