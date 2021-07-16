import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentItem extends StatelessWidget {

    final RecentCaption caption;

    final Function onItemClick;
    final Function onItemLongClick;

    RecentItem({ @required this.caption, this.onItemClick, this.onItemLongClick });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);

        return Container(
            color: Colors.white10,
            width: scale.actualLongestSide * 0.14,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: () {
                        if (onItemClick != null) {
                            onItemClick(this.caption);
                        }
                    },
                    onLongPress: () {
                        if (onItemLongClick != null) {
                            onItemLongClick(this.caption);
                        }
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(scale.actualLongestSide * 0.01, scale.actualLongestSide * 0.005, scale.actualLongestSide * 0.01, scale.actualLongestSide * 0.005),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        caption.subject,
                                        style: TextStyle(
                                            fontSize: scale.actualLongestSide * 0.007,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                ),
                                Row(
                                    children: [
                                        Expanded(
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    "${caption.getEpisodeString} • ${caption.author}",
                                                    style: TextStyle(
                                                        fontSize: scale.actualLongestSide * 0.005,
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
                                                        fontSize: scale.actualLongestSide * 0.005,
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
            ),
        );
    }

}