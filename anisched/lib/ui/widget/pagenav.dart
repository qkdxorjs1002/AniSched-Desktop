import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {

    final Widget child;

    final Function? onLeftTap;
    final Function? onRightTap;

    final bool? enableLeft;
    final bool? enableRight;

    const PageNavigator({ required this.child, this.onLeftTap, this.onRightTap, this.enableLeft, this.enableRight });
    
    @override
    Widget build(BuildContext context) {
        return Stack(
            children: [
                child,
                Row(
                    children: [
                        _navigator(
                            context,
                            text: "◀", 
                            onTap: onLeftTap,
                            enabled: enableLeft!,
                        ),
                        Expanded(
                            child: Container(),
                        ),
                        _navigator(
                            context,
                            text: "▶", 
                            onTap: onRightTap,
                            enabled: enableRight!,
                        ),
                    ],
                ),
            ],
        );
    }

    Widget _navigator(BuildContext context, { String? text, Function? onTap, required bool enabled }) {
        return Material(
            color: Colors.transparent,
            child: !enabled ? null : InkWell(
                onTap: onTap as void Function()?,
                hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.35),
                child: Container(
                    width: Sizes.SIZE_060,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                        text!,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: Sizes.SIZE_020,
                            shadows: [
                                Shadow(
                                    color: Theme.of(context).colorScheme.background.withOpacity(0.25),
                                    blurRadius: 10.0,
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