import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class Board extends StatelessWidget {

    final Widget? child;
    final String? title;
    final String description;

    Board({ required this.title, this.description = "" ,this.child });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(top: Sizes.SIZE_020),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                        padding: EdgeInsets.only(left: Sizes.SIZE_020, bottom: Sizes.SIZE_020),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                Text(
                                    title!,
                                    style: TextStyle(
                                        height: 1.0,
                                        fontSize: Sizes.SIZE_020,
                                        fontWeight: FontWeight.w500,
                                    ),  
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: Sizes.SIZE_004),
                                    child: Text(
                                        description,
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor.withOpacity(0.7),
                                            fontSize: Sizes.SIZE_010,
                                            fontWeight: FontWeight.w300,
                                        ),  
                                    ),
                                ),
                            ],
                        ),
                    ),
                    child!,
                ],
            ),
        );
    }

}