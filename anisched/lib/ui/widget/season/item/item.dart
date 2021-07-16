import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class SeasonTableItem extends StatelessWidget {

    final Season season;

    const SeasonTableItem({ @required this.season });

    @override
    Widget build(BuildContext context) {
        
        Scale scale = Scale(context);

        return (season != null) ? Container(
            color: Colors.white10,
            width: scale.longestSide * 0.17,
            child: Stack(
                children: [
                    Stack(
                        fit: StackFit.expand,
                        children: [
                            (season.posterPath != null)
                            ? ImageNetwork(source: season.getPosterPath(TMDBImageSizes.W500))
                            : Center(
                                child: Text(
                                    "NO IMAGE",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: scale.longestSide * 0.012,
                                    ),
                                ),
                            ),
                        ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: BackBlur(
                            width: double.infinity,
                            height: scale.longestSide * 0.08,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(scale.longestSide * 0.016, 0, scale.longestSide * 0.016, 0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            season.name,
                                            style: TextStyle(
                                                fontSize: scale.longestSide * 0.016,
                                                height: 1.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                        ),
                                        Text(
                                            "${(season.airDate != null) ? season.airDate : "방영일 정보 없음"} | ${season.episodeCount}화",
                                            style: TextStyle(
                                                fontSize: scale.longestSide* 0.012,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    )
                ],
            ),
        ) : LoadingIndicator();
    }
}
