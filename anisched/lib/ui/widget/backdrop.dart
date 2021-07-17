import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Backdrop extends StatelessWidget {

    final String imageUrl;
    final String title;
    final String description;
    final String time;
    final String extra;
    final double panelHeight;
    
    const Backdrop({ @required this.imageUrl, this.title = "", this.description, this.time = "", this.extra, @required this.panelHeight });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);

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
                            padding: EdgeInsets.fromLTRB(scale.restrictedByTarget(size: scale.width, ratio: 0.04), 0, scale.restrictedByTarget(size: scale.width, ratio: 0.04), 0),
                            child: Row(
                                children: [
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                                    title,
                                                    style: TextStyle(
                                                        fontSize: scale.restrictedByTarget(size: scale.width, ratio: 0.03),
                                                        height: 1.0,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                ),
                                            ] + ((description != null) ? [
                                                Text(
                                                    description,
                                                    style: TextStyle(
                                                        fontSize: scale.restrictedByTarget(size: scale.width, ratio: 0.02),
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
                                                time,
                                                style: TextStyle(
                                                    fontSize: scale.restrictedByTarget(size: scale.width, ratio: 0.02),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                            ),
                                        ] + ((extra != null && extra != "") ? [
                                            Text(
                                                extra,
                                                style: TextStyle(
                                                    fontSize: scale.restrictedByTarget(size: scale.width, ratio: 0.02),
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