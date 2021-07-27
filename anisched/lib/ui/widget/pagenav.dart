import 'package:anisched/ui/widget/sizes.dart';
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
        return Material(
            color: Colors.transparent,
            child: !enabled ? null : InkWell(
                onTap: onTap,
                hoverColor: Theme.of(context).primaryColor.withOpacity(0.35),
                child: Container(
                    width: Sizes.SIZE_060,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                        text,
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: Sizes.SIZE_020,
                            fontWeight: FontWeight.w300,
                            shadows: [
                                Shadow(
                                    color: Theme.of(context).primaryColor.withOpacity(0.24),
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