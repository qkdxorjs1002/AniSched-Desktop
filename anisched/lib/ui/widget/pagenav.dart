import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {

    final Function onLeftTap;
    final Function onRightTap;

    final bool enableLeft;
    final bool enableRight;

    const PageNavigator({ this.onLeftTap, this.onRightTap, this.enableLeft, this.enableRight });
    
    @override
    Widget build(BuildContext context) {

        return Row(
            children: [
                _navigator(
                    context,
                    text: "◀", 
                    onTap: onLeftTap,
                    enabled: enableLeft,
                ),
                Expanded(
                    child: Container(),
                ),
                _navigator(
                    context,
                    text: "▶", 
                    onTap: onRightTap,
                    enabled: enableRight,
                ),
            ],
        );
    }

    Widget _navigator(BuildContext context, { String text, Function onTap, bool enabled }) {
        
        final Scale scale = Scale(context);

        return Material(
            color: Colors.transparent,
            child: !enabled ? null : InkWell(
                onTap: onTap,
                child: Container(
                    width: scale.longestSide * 0.06,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                        text,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            fontSize: scale.longestSide * 0.02,
                            shadows: [
                                Shadow(
                                    color: Colors.black54,
                                    blurRadius: 5.0,
                                    offset: Offset.fromDirection(0, 0),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}