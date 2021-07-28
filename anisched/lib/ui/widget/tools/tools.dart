import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class Tools extends StatelessWidget {

    final List<Widget> children;

    const Tools({ required this.children });

    @override
    Widget build(BuildContext context) {
        return Container(
            height: Sizes.SIZE_060,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: children.length,
                itemBuilder: (context, index) {
                    EdgeInsets padding = EdgeInsets.zero;
                    if (index == 0) {
                        padding = EdgeInsets.only(left: Sizes.SIZE_020!);
                    } else if (index == children.length - 1) {
                        padding = EdgeInsets.only(right: Sizes.SIZE_020!);
                    }
                    return Padding(
                        padding: padding,
                        child: children[index],
                    );
                }, 
                separatorBuilder: (context, index) => Container(width: Sizes.SIZE_010), 
            ),
        );
    }
    
}
