import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

typedef ScrollEventFunction(PointerScrollEvent event);

class ScrollEvent extends Listener {
    
    ScrollEvent({ ScrollEventFunction? onVerticalScroll, ScrollEventFunction? onHorizontalScroll, double verticalCritical = 0.0, double horizontalCritical = 0.0, required Widget child }) : super(
        onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
                Offset _delta = event.scrollDelta;
                debugPrint("ScrollEvent: x${_delta.dx} / y${_delta.dy}");
                
                if (_delta.dy.abs() > verticalCritical && onVerticalScroll != null) {
                    onVerticalScroll(event);
                }

                if (_delta.dx.abs() > horizontalCritical && onHorizontalScroll != null) {
                    onHorizontalScroll(event);
                }
            }
        },
        child: child,
    );

}

class SmoothScrollPhysics extends ClampingScrollPhysics {

    final String os;

    const SmoothScrollPhysics({ ScrollPhysics? parent, this.os = "platform" }) : super(parent: parent);

    @override
    SmoothScrollPhysics applyTo(ScrollPhysics? ancestor) {
        String _os = (os == "platform") ? Platform.operatingSystem : os;

        if (_os == "macos") {
            return SmoothScrollPhysics(parent: buildParent(ancestor));
        }
        return SmoothScrollPhysics(parent: buildParent(NeverScrollableScrollPhysics(parent: ancestor)));
    }

}

class SmoothScroll extends StatefulWidget {

    final ScrollView child;
    final String os;
    final Axis? scrollAxis;

    SmoothScroll({ Key? key, required this.child, this.os = "platform", this.scrollAxis }) : super(key: key);

    @override
    _SmoothScrollState createState() => _SmoothScrollState();

}

class _SmoothScrollState extends State<SmoothScroll> {
        
    double _offset = 0.0;

    @override
    Widget build(BuildContext context) {
        String os = (widget.os == "platform") ? Platform.operatingSystem : widget.os;

        if (os == "macos") {
            return widget.child;
        }

        ScrollController controller = widget.child.controller!;

        controller.addListener(() {
            _offset = controller.offset;
        });

        return ScrollEvent(
            onVerticalScroll: (event) {
                Offset delta = event.scrollDelta;
                double distance = delta.dy;
                if (widget.scrollAxis == null) {
                    distance = (widget.child.scrollDirection == Axis.vertical) ? delta.dy : delta.dx;
                } else if (widget.scrollAxis == Axis.horizontal) {
                    distance = delta.dx;
                }
                _smoothScrolling(controller, distance);
            },
            onHorizontalScroll: (event) {
                Offset delta = event.scrollDelta;
                double distance = delta.dx;
                if (widget.scrollAxis == null) {
                    distance = (widget.child.scrollDirection == Axis.vertical) ? delta.dx : delta.dy;
                } else if (widget.scrollAxis == Axis.horizontal) {
                    distance = delta.dy;
                }
                _smoothScrolling(controller, distance);
            },
            child: widget.child,
        );
    }

    void _smoothScrolling(ScrollController controller, double distance) {
        final double _max = controller.position.maxScrollExtent;
        final double _min = controller.position.minScrollExtent;

        _offset += (distance * 5);

        if (_offset > _max) {
            _offset = _max;
        } else if (_offset < _min) {
            _offset = _min;
        } else if (_offset == _max || _offset == _min) {
            return ;
        }
        
        controller.animateTo(
            _offset,
            duration: const Duration(
                milliseconds: 350,
            ), 
            curve: Curves.easeOutCirc,
        );
    }

}