import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {

    final Anime anime;
    final Result tmdbResult;

    const Description({ this.anime, this.tmdbResult });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);

        return (anime != null) ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                    "시간",
                                    style: TextStyle(
                                        fontSize: scale.actualLongestSide * 0.007,
                                        fontWeight: FontWeight.w600,
                                    ),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: scale.actualLongestSide * 0.007),
                                child: Text(
                                    anime.getTimeString,
                                    style: TextStyle(
                                        fontSize: scale.actualLongestSide * 0.007,
                                    ),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                    "방영 시작",
                                    style: TextStyle(
                                        fontSize: scale.actualLongestSide * 0.007,
                                        fontWeight: FontWeight.w600,
                                    ),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: scale.actualLongestSide * 0.007),
                                child: Text(
                                    anime.getStartDateString,
                                    style: TextStyle(
                                        fontSize: scale.actualLongestSide * 0.007,
                                    ),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                    "종영",
                                    style: TextStyle(
                                        fontSize: scale.actualLongestSide * 0.007,
                                        fontWeight: FontWeight.w600,
                                    ),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: scale.actualLongestSide * 0.007),
                                child: Text(
                                    anime.getEndDateString,
                                    style: TextStyle(
                                        fontSize: scale.actualLongestSide * 0.007,
                                    ),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                    "장르",
                                    style: TextStyle(
                                        fontSize: scale.actualLongestSide * 0.007,
                                        fontWeight: FontWeight.w600,
                                    ),
                                ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: scale.actualLongestSide * 0.007),
                                child: Wrap(
                                    children: anime.getGenreList.map((e) {
                                        return Padding(
                                            padding: EdgeInsets.only(top: scale.actualLongestSide * 0.005, right: scale.actualLongestSide * 0.004),
                                            child: Chip(
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                label: Text(
                                                    e,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: scale.actualLongestSide * 0.006,
                                                    ),
                                                ),
                                            ),
                                        );
                                    }).toList(),
                                ),
                            ),
                        ],
                    ),
                ),
                Container(
                    width: scale.actualLongestSide * 0.07,
                    height: scale.actualLongestSide * 0.1,
                    child: Stack(
                        fit: StackFit.expand,
                        children: [
                            ImageNetwork(
                                source: (tmdbResult != null) ? tmdbResult.getPosterPath(Result.W500) : null,
                            ),
                        ],
                    ),
                )
                
            ],
        ) : LoadingIndicator();
    }
}
