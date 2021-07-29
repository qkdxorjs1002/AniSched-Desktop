import 'package:anisched/helper.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class AutoCorrectItem extends StatelessWidget {

    final AutoCorrect? autoCorrect;

    const AutoCorrectItem({ this.autoCorrect });

    @override
    Widget build(BuildContext context) {
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () => Helper.navigateRoute(context, DetailPage(animeId: autoCorrect!.id,)),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_010, horizontal: Sizes.SIZE_020),
                    child: Text(
                        autoCorrect!.subject!,
                        style: TextStyle(
                            fontSize: Sizes.SIZE_016,
                            fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    ),
                ),
            ),
        );
    }
    
}

class SearchItem extends StatelessWidget {

    final Anime? anime;

    const SearchItem({ this.anime });

    @override
    Widget build(BuildContext context) {
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () => Helper.navigateRoute(context, DetailPage(animeId: anime!.id,)),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_010, horizontal: Sizes.SIZE_020),
                    child: Column(
                        children: [
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                                anime!.subject!,
                                                style: TextStyle(
                                                    fontSize: Sizes.SIZE_016,
                                                    fontWeight: FontWeight.w300,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                            AnissiaFactor.WEEKDAY[anime!.week!]!,
                                            style: TextStyle(
                                                fontSize: Sizes.SIZE_012,
                                                fontWeight: FontWeight.w300,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                    ),
                                ],
                            ),
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                "${anime!.getGenreString} ᐧ 𝒞${anime!.captionCount}",
                                                style: TextStyle(
                                                    fontSize: Sizes.SIZE_012,
                                                    fontWeight: FontWeight.w300,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                                anime!.getStartDateString,
                                                style: TextStyle(
                                                    fontSize: Sizes.SIZE_012,
                                                    fontWeight: FontWeight.w300,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
    
}
