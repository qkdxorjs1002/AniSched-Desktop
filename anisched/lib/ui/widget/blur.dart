import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackBlur extends StatelessWidget {

    final double width;
    final double height;
    final Widget child;
    final Alignment childAlignment;

    const BackBlur({ this.width, this.height, this.child, this.childAlignment = Alignment.centerLeft });

    @override
    Widget build(BuildContext context) {
        return ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 20.0,
                    sigmaY: 20.0,
                ),
                child: Container(
                    color: Colors.black.withOpacity(0.35),
                    height: height,
                    width: width,
                    alignment: childAlignment,
                    child: child,
                ),
            ),
        );
    }

}