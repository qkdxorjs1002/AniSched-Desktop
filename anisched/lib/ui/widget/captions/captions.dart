import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/captions/item/item.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Captions extends StatelessWidget{
    
    final List<Caption> captionList;

    final Function onItemClick;

    const Captions({ @required this.captionList, this.onItemClick });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);
        
        return (captionList != null) ? ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: captionList.length,
            itemBuilder: (context, index) {
                return CaptionsItem(
                    caption: captionList[index],
                    onItemClick: (Caption caption) => onItemClick(caption),
                );
            }, 
            separatorBuilder: (context, index) => Container(
                height: scale.longestSide * 0.01,
                child: Divider(
                    indent: scale.longestSide * 0.02,
                    endIndent: scale.longestSide * 0.02,
                ),
            ), 
        ) : LoadingIndicator();
    }

}
