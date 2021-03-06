import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class SeasonTableItem extends StatelessWidget {

    final Season season;

    final double width;

    const SeasonTableItem({ required this.season, required this.width });

    @override
    Widget build(BuildContext context) {
        return Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            width: width,
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
                                        color: Theme.of(context).primaryColor.withOpacity(0.54),
                                        fontSize: Sizes.SIZE_012,
                                        fontWeight: FontWeight.w300,
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
                                padding: EdgeInsets.symmetric(horizontal: Sizes.SIZE_016),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            season.name!,
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_016,
                                                fontWeight: FontWeight.w500,
                                                height: 1.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                        ),
                                        Text(
                                            "${(season.airDate != null) ? season.airDate : "????????? ?????? ??????"} | ${season.episodeCount}???",
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_012,
                                                fontWeight: FontWeight.w300,
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
        );
    }
}
