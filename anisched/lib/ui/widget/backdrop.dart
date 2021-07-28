import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class Backdrop extends StatelessWidget {

    final String? imageUrl;
    final String? title;
    final String? description;
    final String? time;
    final String? extra;
    final double? panelHeight;
    
    const Backdrop({ required this.imageUrl, this.title = "", this.description, this.time = "", this.extra, required this.panelHeight });

    @override
    Widget build(BuildContext context) {
        return Stack(
            children: [
                Stack(
                    fit: StackFit.expand,
                    children: [
                        ImageNetwork(source: imageUrl),
                    ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: BackBlur(
                        height: panelHeight,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(Sizes.SIZE_040, 0, Sizes.SIZE_040, 0),
                            child: Row(
                                children: [
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                                    title!,
                                                    style: TextStyle(
                                                        fontSize: Sizes.SIZE_030,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.0,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                ),
                                            ] + ((description != null) ? [
                                                Text(
                                                    description!,
                                                    style: TextStyle(
                                                        fontSize: Sizes.SIZE_020,
                                                        fontWeight: FontWeight.w300,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                ),
                                            ] : []),
                                        ),
                                    ),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                            Text(
                                                time!,
                                                style: TextStyle(
                                                    fontSize: Sizes.SIZE_020,
                                                    fontWeight: FontWeight.w300,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                            ),
                                        ] + ((extra != null && extra != "") ? [
                                            Text(
                                                extra!,
                                                style: TextStyle(
                                                    fontSize: Sizes.SIZE_020,
                                                    fontWeight: FontWeight.w300,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                            ),
                                        ] : []),
                                    ),
                                ],
                            )
                        ),
                    ),
                ),
            ],
        );
    }
}