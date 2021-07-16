import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Board extends StatelessWidget {

    final Widget child;
    final String title;
    final String description;

    Board({ @required this.title, this.description = "" ,this.child });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);

        return Padding(
            padding: EdgeInsets.fromLTRB(0, scale.longestSide * 0.02, 0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                        padding: EdgeInsets.only(left: scale.longestSide * 0.02, bottom: scale.longestSide * 0.01),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                Text(
                                    title,
                                    style: TextStyle(
                                        height: 1.0,
                                        fontSize: scale.longestSide * 0.02,
                                    ),  
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: scale.longestSide * 0.004),
                                    child: Text(
                                        description,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: scale.longestSide * 0.01,
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