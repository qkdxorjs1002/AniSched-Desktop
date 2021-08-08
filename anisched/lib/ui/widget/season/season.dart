import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/season/item/item.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class SeasonTable extends StatelessWidget {

    final List<Season> seasonList;
    
    final double height;

    const SeasonTable({ required this.seasonList, required this.height });

    @override
    Widget build(BuildContext context) {
        return Container(
            alignment: Alignment.topLeft,
            height: height,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: seasonList.length,
                itemBuilder: (context, index) {
                    EdgeInsets padding = EdgeInsets.zero;
                    if (index == 0) {
                        padding = EdgeInsets.only(left: Sizes.SIZE_020);
                    } else if (index == seasonList.length - 1) {
                        padding = EdgeInsets.only(right: Sizes.SIZE_020);
                    }
                    return Padding(
                        padding: padding,
                        child: SeasonTableItem(
                            season: seasonList[index],
                            width: height * 0.7,
                        ),
                    );
                }, 
                separatorBuilder: (context, index) => Container(width: Sizes.SIZE_010), 
            ),
        );
    }
}
