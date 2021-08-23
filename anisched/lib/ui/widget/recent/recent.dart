import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/recent/item/item.dart';
import 'package:anisched/ui/widget/recent/provider.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/smoothscroll.dart';
import 'package:flutter/material.dart';

class Recent extends StatefulWidget {

    final Function? onItemClick;
    final Function? onItemLongClick;

    const Recent({ this.onItemClick, this.onItemLongClick, key }) : super(key: key);

    @override
    _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> with AutomaticKeepAliveClientMixin {

    final RecentDataProvider _dataProvider = RecentDataProvider();

    final ScrollController _scrollController = ScrollController();
    
    List<RecentCaption>? _recentCaptionList;

    @override
    void initState() {
        super.initState();
        initObservers();

        _dataProvider.requestRecentCaption();
    }

    void initObservers() {
        _dataProvider.getRecentCaptionList!.addObserver(Observer((data) {
            setState(() {
                _recentCaptionList = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        
        return (_recentCaptionList != null) ? Container(
            height: Sizes.SIZE_060,
            child: SmoothScroll(
                child: ListView.separated(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _recentCaptionList!.length,
                    itemBuilder: (context, index) {
                        EdgeInsets padding = EdgeInsets.zero;
                        if (index == 0) {
                            padding = EdgeInsets.only(left: Sizes.SIZE_020);
                        } else if (index == _recentCaptionList!.length - 1) {
                            padding = EdgeInsets.only(right: Sizes.SIZE_020);
                        }
                        return Padding(
                            padding: padding,
                            child: RecentItem(
                                caption: _recentCaptionList![index],
                                onItemClick: (RecentCaption caption) => widget.onItemClick!(caption),
                                onItemLongClick: (RecentCaption caption) => widget.onItemLongClick!(caption),
                            ),
                        );
                    }, 
                    separatorBuilder: (context, index) => Container(width: Sizes.SIZE_010), 
                ),
            ),
        ) : LoadingIndicator();
    }

  @override
  bool get wantKeepAlive => true;
}
