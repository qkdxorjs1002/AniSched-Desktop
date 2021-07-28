import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/captions/item/item.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class Captions extends StatelessWidget{
    
    final List<Caption>? captionList;

    final Function? onItemClick;

    const Captions({ required this.captionList, this.onItemClick });

    @override
    Widget build(BuildContext context) {
        return (captionList != null) ? ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: captionList!.length,
            itemBuilder: (context, index) {
                return CaptionsItem(
                    caption: captionList![index],
                    onItemClick: (Caption caption) => onItemClick!(caption),
                );
            }, 
            separatorBuilder: (context, index) => Container(
                height: Sizes.SIZE_010,
                child: Divider(
                    indent: Sizes.SIZE_020,
                    endIndent: Sizes.SIZE_020,
                ),
            ), 
        ) : LoadingIndicator();
    }

}
