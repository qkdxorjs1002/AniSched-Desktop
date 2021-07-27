import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentItem extends StatelessWidget {

    final RecentCaption caption;

    final Function onItemClick;
    final Function onItemLongClick;

    RecentItem({ @required this.caption, this.onItemClick, this.onItemLongClick });

    @override
    Widget build(BuildContext context) {
        return Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            width: Sizes.SIZE_280,
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
                        padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_010, horizontal: Sizes.SIZE_020),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        caption.subject,
                                        style: TextStyle(
                                            fontSize: Sizes.SIZE_014,
                                            fontWeight: FontWeight.w500,
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
                                                    "${caption.getEpisodeString} ᐧ ${caption.author}",
                                                    style: TextStyle(
                                                        fontSize: Sizes.SIZE_010,
                                                        fontWeight: FontWeight.w300,
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
                                                        fontSize: Sizes.SIZE_010,
                                                        fontWeight: FontWeight.w300,
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