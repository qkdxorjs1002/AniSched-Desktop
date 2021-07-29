import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToolsItem extends StatelessWidget {

    final Widget icon;
    final String text;
    final Function? onItemClick;

    ToolsItem({ required this.icon, required this.text, this.onItemClick });

    @override
    Widget build(BuildContext context) {
        return Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                        if (onItemClick != null) {
                            onItemClick!();
                        }
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_010, horizontal: Sizes.SIZE_020),
                        child: Row(
                            children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: icon,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        text,
                                        style: TextStyle(
                                            fontSize: Sizes.SIZE_014,
                                            fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }

}