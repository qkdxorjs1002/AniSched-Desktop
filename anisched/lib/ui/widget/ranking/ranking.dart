import 'dart:async';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/pagenav.dart';
import 'package:anisched/ui/widget/ranking/item/item.dart';
import 'package:anisched/ui/widget/ranking/provider.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/smoothscroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {

    final Function? onItemClick;

    const Ranking({ this.onItemClick, key }) : super(key: key);

    @override
    _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> with AutomaticKeepAliveClientMixin {

    final RankingDataProvider _dataProvider = RankingDataProvider();
    final PageController _pageController = PageController(initialPage: 0);

    late Timer _transitionTimer;

    double? _page = 0;
    bool isOnScroll = false;

    List<Rank>? _rankList;

    @override
    void initState() {
        super.initState();
        initObservers();
        initEvents();

        _dataProvider.requestRanking();
    }

    void initObservers() {
        _dataProvider.getRankList!.addObserver(Observer((data) {
            setState(() {
                _rankList = data;
            });
            _transitionTimer = _initTransition();
        }));
    }

    void initEvents() {
        _pageController.addListener(() {
            setState(() {
                _page = _pageController.page;
            });
            _transitionTimer.cancel();
            _transitionTimer = _initTransition();
        });
    }

    @override
    void dispose() {
        _pageController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);

        return _rankList != null ? Container(
            height: Sizes.SIZE_560,
            child: PageNavigator(
                onLeftTap: () {
                    _pageController.previousPage(
                        duration: const Duration(
                            milliseconds: 350,
                        ), 
                        curve: Curves.easeInOut
                    );
                },
                enableLeft: (_page! > 0),
                onRightTap: () {
                    _pageController.nextPage(
                        duration: const Duration(
                            milliseconds: 350,
                        ), 
                        curve: Curves.easeInOut
                    );
                },
                enableRight: (_page! < _rankList!.length - 1),
                child: ScrollEvent(
                    onVerticalScroll: (event) {
                        Offset delta = event.scrollDelta;
                        if (delta.dx.abs() > delta.dy.abs()) {
                            GestureBinding.instance!.pointerSignalResolver.register(event, (event) => null);
                        }
                    },
                    onHorizontalScroll: (event) {
                        if (isOnScroll) {
                            return ;
                        }
                        isOnScroll = true;

                        Offset delta = event.scrollDelta;
                        if (delta.dx > 0) {
                            _pageController.nextPage(
                                duration: const Duration(
                                    milliseconds: 350,
                                ), 
                                curve: Curves.easeInOut
                            ).then((value) {
                                isOnScroll = false;
                            });
                        } else {
                            _pageController.previousPage(
                                duration: const Duration(
                                    milliseconds: 350,
                                ), 
                                curve: Curves.easeInOut
                            ).then((value) {
                                isOnScroll = false;
                            });
                        }
                    },
                    horizontalCritical: 30.0,
                    child: PageView.builder(
                        allowImplicitScrolling: true,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        itemCount: _rankList!.length,
                        itemBuilder: (context, index) => RankingItem(
                            rank: _rankList![index], 
                            onItemClick: (anime, tmdb) => widget.onItemClick!(anime, tmdb),
                        ),
                    ),
                ),
            ),
        ) : LoadingIndicator();
    }

    Timer _initTransition() {
        return Timer(
            const Duration(seconds: 6), 
            () {
                if (_page! < _rankList!.length - 1) {
                    _pageController.nextPage(
                        duration: const Duration(
                            milliseconds: 350,
                        ), 
                        curve: Curves.easeInOut
                    );
                } else {
                    _pageController.jumpTo(0);
                }
            }
        );
    }

    @override
    bool get wantKeepAlive => true;
}
