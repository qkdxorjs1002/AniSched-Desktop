import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class SeasonTableItem extends StatelessWidget {

    final Season season;

    const SeasonTableItem({ @required this.season });

    @override
    Widget build(BuildContext context) {
        return (season != null) ? Container(
            color: Colors.white10,
            width: Sizes.SIZE_170,
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
                                        fontSize: Sizes.SIZE_012,
                                    ),
                                ),
                            ),
                        ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: BackBlur(
                            width: double.infinity,
                            height: Sizes.SIZE_080,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(Sizes.SIZE_016, 0, Sizes.SIZE_016, 0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            season.name,
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_016,
                                                height: 1.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                        ),
                                        Text(
                                            "${(season.airDate != null) ? season.airDate : "방영일 정보 없음"} | ${season.episodeCount}화",
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_012,
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
