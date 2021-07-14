import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Board extends StatelessWidget {

    final Widget child;
    final String title;

    Board({ @required this.title, this.child });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);

        return Padding(
            padding: EdgeInsets.all(scale.actualLongestSide * 0.01),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                        padding: EdgeInsets.only(left: scale.actualLongestSide * 0.01, bottom: scale.actualLongestSide * 0.005),
                        child: Text(
                            title,
                            style: TextStyle(
                                fontSize: scale.actualLongestSide * 0.01,
                            ),
                        ),
                    ),
                    child,
                ],
            ),
        );
    }

}