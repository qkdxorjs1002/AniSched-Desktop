import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class CaptionsItem extends StatelessWidget {

    final Caption caption;

    final Function onItemClick;

    CaptionsItem({ @required this.caption, this.onItemClick });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);
        
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                    if (onItemClick != null) {
                        onItemClick(this.caption);
                    }
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(scale.actualLongestSide * 0.01, scale.actualLongestSide * 0.005, scale.actualLongestSide * 0.01, scale.actualLongestSide * 0.005),
                    child: Column(
                        children: [
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                                "자막",
                                                style: TextStyle(
                                                    fontSize: scale.actualLongestSide * 0.008,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                                caption.author,
                                                style: TextStyle(
                                                    fontSize: scale.actualLongestSide * 0.008,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                caption.getEpisodeString,
                                                style: TextStyle(
                                                    fontSize: scale.actualLongestSide * 0.006,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                                caption.getUploadDateString,
                                                style: TextStyle(
                                                    fontSize: scale.actualLongestSide * 0.006,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

}