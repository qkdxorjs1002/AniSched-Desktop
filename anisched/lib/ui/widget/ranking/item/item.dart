import 'dart:ui';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/ranking/item/provider.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class RankingItem extends StatefulWidget {

    final Rank rank;

    const RankingItem(this.rank, { Key key }) : super(key: key);

    @override
    _RankingItemState createState() => _RankingItemState();
}

class _RankingItemState extends State<RankingItem> {

    final RankingItemDataProvider dataProvider = RankingItemDataProvider();
    
    Anime anime;
    Result tmdbResult;

    @override
    void initState() {
        super.initState();
        initObservers();

        dataProvider.requestAnime(widget.rank.id);
    }

    void initObservers() {
        dataProvider.getAnimeInfo.addObserver(Observer((Anime data) {
            setState(() {
                anime = data;
                dataProvider.requestTMDB(data);
            });
        }));

        dataProvider.getTMDBResult.addObserver(Observer((Result data) {
            setState(() {
                tmdbResult = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        Scale scale = Scale(context);

        return Stack(
            children: [
                Stack(
                    fit: StackFit.expand,
                    children: [
                        tmdbResult != null 
                        ? ImageNetwork(tmdbResult.getBackdropPath(scale.actualLongestSide > 1280 ? Result.ORIGINAL : Result.W1280))
                        : Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 1,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
                                backgroundColor: Colors.white70,
                            ),
                        ),
                    ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: BackBlur(
                        width: double.infinity,
                        height: scale.actualLongestSide * 0.06,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(scale.actualLongestSide * 0.02, 0, scale.actualLongestSide * 0.02, 0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        widget.rank.subject,
                                        style: TextStyle(
                                            fontSize: scale.actualLongestSide * 0.015,
                                            height: 1.0,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                    ),
                                    Text(
                                        widget.rank.rankString + " • " + widget.rank.diffString,
                                        style: TextStyle(
                                            fontSize: scale.actualLongestSide* 0.01,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                    ),
                                ],
                            ),
                        ),
                    ),
                ),
            ],
        );
    }
}
