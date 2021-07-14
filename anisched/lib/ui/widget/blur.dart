import 'dart:ui';

import 'package:flutter/cupertino.dart';

class BackBlur extends StatelessWidget {

    final double width;
    final double height;
    final Widget child;

    const BackBlur({ this.width, this.height, this.child });

    @override
    Widget build(BuildContext context) {
        return ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 14.0,
                    sigmaY: 14.0,
                ),
                child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    height: height,
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: child,
                ),
            ),
        );
    }

}