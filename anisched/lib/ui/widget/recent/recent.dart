import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/widget/recent/listview.dart';
import 'package:anisched/ui/widget/recent/provider.dart';
import 'package:flutter/material.dart';

class Recent extends StatefulWidget {

    const Recent({ Key key }) : super(key: key);

    @override
    _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {

    final RecentDataProvider dataProvider = RecentDataProvider();
    List<RecentCaption> recentCaptionList;

    @override
    void initState() {
        super.initState();
        initObservers();

        dataProvider.requestRecentCaption();
    }

    void initObservers() {
        dataProvider.getRecentCaptionList.addObserver(Observer((data) {
            setState(() {
                recentCaptionList = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        return RecentListView(
            list: recentCaptionList,
            onItemClick: (recentCaption) {

            },
            onItemLongClick: (recentCaption) {
                
            },
        );
    }
}
