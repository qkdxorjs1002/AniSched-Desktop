import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:anisched/ui/widget/season/item/item.dart';
import 'package:flutter/material.dart';

class SeasonTable extends StatelessWidget {

    final List<Season> seasonList;

    const SeasonTable({ @required this.seasonList });

    @override
    Widget build(BuildContext context) {
        
        final Scale scale = Scale(context);
        
        return (seasonList != null) ? Container(
            height: scale.restrictedByTarget(size: scale.width, ratio: 0.24),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: seasonList.length,
                itemBuilder: (context, index) {
                    EdgeInsets padding = EdgeInsets.zero;
                    if (index == 0) {
                        padding = EdgeInsets.only(left: scale.restrictedByTarget(size: scale.width, ratio: 0.02));
                    } else if (index == seasonList.length - 1) {
                        padding = EdgeInsets.only(right: scale.restrictedByTarget(size: scale.width, ratio: 0.02));
                    }
                    return Padding(
                        padding: padding,
                        child: SeasonTableItem(
                            season: seasonList[index],
                        ),
                    );
                }, 
                separatorBuilder: (context, index) => Container(width: scale.restrictedByTarget(size: scale.width, ratio: 0.01)), 
            ),
        ) : LoadingIndicator();
    }
}
