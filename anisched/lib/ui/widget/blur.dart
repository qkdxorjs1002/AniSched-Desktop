import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackBlur extends StatelessWidget {

    final double sigma;
    final double width;
    final double height;
    final Widget child;
    final Alignment childAlignment;

    const BackBlur({ this.sigma = 30.0, this.width, this.height, this.child, this.childAlignment = Alignment.centerLeft });

    @override
    Widget build(BuildContext context) {
        return ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: sigma,
                    sigmaY: sigma,
                ),
                child: Container(
                    color: Theme.of(context).backgroundColor.withOpacity(0.45),
                    height: height,
                    width: width,
                    alignment: childAlignment,
                    child: child,
                ),
            ),
        );
    }

}

class BlurTransition extends AnimatedWidget {

    final Animation<double> animation;
    final Widget child;

    const BlurTransition({@required this.animation, this.child }) : super(listenable: animation);

    @override
    Widget build(BuildContext context) {
        return Stack(
            children: [
                child,
                ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: animation.value,
                            sigmaY: animation.value,
                        ),
                        child: Container(),
                    ),
                ),
            ],
        );
    }
}
