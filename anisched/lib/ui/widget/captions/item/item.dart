import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class CaptionsItem extends StatelessWidget {

    final Caption caption;

    final Function? onItemClick;

    CaptionsItem({ required this.caption, this.onItemClick });

    @override
    Widget build(BuildContext context) {
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                    if (onItemClick != null) {
                        onItemClick!(this.caption);
                    }
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_010, horizontal: Sizes.SIZE_020),
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
                                                    fontSize: Sizes.SIZE_016,
                                                    fontWeight: FontWeight.w500,
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
                                                caption.author!,
                                                style: TextStyle(
                                                    fontSize: Sizes.SIZE_016,
                                                    fontWeight: FontWeight.w500,
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
                                                    fontSize: Sizes.SIZE_012,
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
                                                    fontSize: Sizes.SIZE_012,
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
        );
    }

}