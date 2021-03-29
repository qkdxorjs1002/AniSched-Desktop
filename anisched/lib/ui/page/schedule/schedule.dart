import 'dart:async';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/page/schedule/provider.dart';
import 'package:anisched/ui/widget/appbar.dart';
import 'package:anisched/ui/widget/listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {

    final ScheduleDataProvider dataProvider = ScheduleDataProvider();
    final int week;
    
    Schedule({ Key key, this.week }) : super(key: key);

    @override
    _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {

    TabController _tabController;
    Timer _timer;
    bool _appBarCollapsed = true;

    int _backdropIdx = -1;
    List<String> _backdropList = [];

    List<Anime> _animeList;

    OnItemClickListener _onAnimeListItemClickListener;

    @override
    void initState() {
        super.initState();
        _tabController = TabController(initialIndex: widget.week, length: FACTOR.WEEKDAY.length, vsync: this);

        initObservers();
        initEvents();

        widget.dataProvider.requestSchedule(widget.week);
    }

    void initObservers() {
        widget.dataProvider.getScheduleList.addObserver(Observer((List<Anime> data) {
            setState(() {
                _animeList = data;
                _backdropIdx = -1;
                _backdropList = [];
                if (_timer != null) {
                    _timer.cancel();
                    _timer = null;
                }
            });

            Iterator<Anime> iterator = data.iterator;
            while (iterator.moveNext()) {
                widget.dataProvider.requestTMDB(iterator.current);
            }
        }));

        widget.dataProvider.getTMDBResult.addObserver(Observer((Result data) {
            setState(() {
                _backdropList.add(data.getBackdropPath);
                _appBarCollapsed = false;
            });
            
            if (_backdropIdx == -1) {
                setState(() {
                    _backdropIdx = 0;
                });

                if (_timer == null) {
                    _timer = Timer.periodic(Duration(seconds: 7), (timer) {
                        setState(() {
                            _backdropIdx = timer.tick % _backdropList.length;
                        });
                    });
                }
            }
        }));
        
    }

    void initEvents() {
        _onAnimeListItemClickListener = OnItemClickListener(
            onItemClick: (Anime anime) {
                Navigator.push(context, CupertinoPageRoute(
                    builder: (context) => DetailPage(
                        anime: anime,
                    )
                ));
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return CustomAppBar(
            collapsed: _appBarCollapsed,
            title: Text(
                "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
            ),
            backdrop: _backdropIdx >= 0 ? _backdropList[_backdropIdx] : null,
            bottom: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.zero,
                indicatorColor: Colors.grey,
                tabs: getTabList(),
                onTap: (idx) => widget.dataProvider.requestSchedule(idx),
            ),
            body: AnimeSliverList(
                list: _animeList,
                onItemClickListener: _onAnimeListItemClickListener,
            ),
        );
    }

    List<Widget> getTabList() {
        List<Widget> tabList = [];

        for (String item in FACTOR.WEEKDAY.values) {
            tabList.add(Tab(
                text: item,
            ));
        }

        return tabList;
    }
}