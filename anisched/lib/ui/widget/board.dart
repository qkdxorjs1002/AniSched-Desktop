import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class Board extends StatelessWidget {

    final Widget child;
    final String title;
    final String description;

    Board({ @required this.title, this.description = "" ,this.child });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.fromLTRB(0, Sizes.SIZE_020, 0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                        padding: EdgeInsets.only(left: Sizes.SIZE_020, bottom: Sizes.SIZE_020),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                Text(
                                    title,
                                    style: TextStyle(
                                        height: 1.0,
                                        fontSize: Sizes.SIZE_020,
                                    ),  
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: Sizes.SIZE_004),
                                    child: Text(
                                        description,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: Sizes.SIZE_010,
                                        ),  
                                    ),
                                ),
                            ],
                        ),
                    ),
                    child,
                ],
            ),
        );
    }

}