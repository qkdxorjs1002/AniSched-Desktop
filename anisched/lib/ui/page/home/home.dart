import 'dart:io';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/helper.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/page/favorite/favorite.dart';
import 'package:anisched/ui/page/home/provider.dart';
import 'package:anisched/ui/page/search/search.dart';
import 'package:anisched/ui/widget/board.dart';
import 'package:anisched/ui/widget/ranking/ranking.dart';
import 'package:anisched/ui/widget/recent/recent.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/smoothscroll.dart';
import 'package:anisched/ui/widget/timetable/timetable.dart';
import 'package:anisched/ui/widget/tools/item/item.dart';
import 'package:anisched/ui/widget/tools/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'model.dart';

class HomePage extends StatefulWidget {
    
    final int? week;

    HomePage({ Key? key, this.week }) : super(key: key);

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    final HomeDataProvider _dataProvider = HomeDataProvider();

    final ScrollController _scrollController = ScrollController();

    String _version = "";

    @override
    void initState() {
        super.initState();
        initObservers();

        PackageInfo.fromPlatform().then(
            (value) { 
                setState(() {
                    _version = "${value.version}+${value.buildNumber}";
                });
                if (Platform.operatingSystem == "macos") {
                    _dataProvider.requestRelease("qkdxorjs1002", "AniSched-Desktop", Platform.operatingSystem, value.version);
                }
            }
        );
    }

    void initObservers() {
        _dataProvider.getNewRelease!.addObserver(Observer((NewRelease data) {
            Helper.snack(
                context, 
                text: "업데이트 (${data.tagName})\n${data.body!}", 
                label: "바로가기",
                duration: const Duration(seconds: 10),
                onPressed: () {
                    Helper.openURL(data.url!);
                },
            );
        }));
    }

    @override
    Widget build(BuildContext context) {
        Sizes.calculate(context);
        
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SmoothScroll(
                child: ListView(
                    controller: _scrollController,
                    physics: const SmoothScrollPhysics(),
                    children: [
                        Ranking(
                            onItemClick: (Anime anime, Result tmdb) => Helper.navigateRoute(context, DetailPage(animeId: anime.id)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: Sizes.SIZE_020),
                            child: Tools(
                                children: [
                                    ToolsItem(
                                        icon: Icon(
                                            Icons.search,
                                            size: Sizes.SIZE_024,
                                        ), 
                                        text: "",
                                        onItemClick: () => Helper.navigateRoute(context, SearchPage()),
                                    ),
                                    ToolsItem(
                                        icon: Icon(
                                            Icons.favorite_outline_rounded,
                                            size: Sizes.SIZE_024,
                                        ), 
                                        text: "",
                                        onItemClick: () => Helper.navigateRoute(context, FavoritePage()),
                                    ),
                                    ToolsItem(
                                        icon: Icon(
                                            Icons.hide_image_outlined,
                                            size: Sizes.SIZE_024,
                                        ), 
                                        text: "",
                                        onItemClick: () => Helper.snack(
                                            context, 
                                            text: "이미지 캐시를 삭제합니다. 이미지 캐시를 제거할 경우, 일시적으로 데이터 사용량이 증가할 수 있습니다.", 
                                            label: "캐시 삭제",
                                            onPressed: () {
                                                DefaultCacheManager().emptyCache();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        backgroundColor: Theme.of(context).backgroundColor,
                                                        content: Text(
                                                            "캐시를 제거했습니다.",
                                                            style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                                fontWeight: FontWeight.w300,
                                                            ),
                                                        ),
                                                    ),
                                                );
                                            },
                                        ),
                                    ),
                                    ToolsItem(
                                        icon: Icon(
                                            Icons.subtitles_off_outlined,
                                            size: Sizes.SIZE_024,
                                        ), 
                                        text: "",
                                        onItemClick: () => Helper.snack(
                                            context, 
                                            text: "모든 설정을 초기화합니다. 설정에는 즐겨찾기 및 여러 선택 사항이 포함됩니다. 이 작업은 되돌릴 수 없습니다.", 
                                            label: "설정 초기화",
                                            onPressed: () {
                                                _dataProvider.requestClearPreference();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        backgroundColor: Theme.of(context).backgroundColor,
                                                        content: Text(
                                                            "설정을 초기화했습니다.",
                                                            style: TextStyle(
                                                                color: Theme.of(context).primaryColor,
                                                                fontWeight: FontWeight.w300,
                                                            ),
                                                        ),
                                                    ),
                                                );
                                            },
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Board(
                            title: "최근 자막",
                            description: "길게 누르면 작품 정보",
                            child: Recent(
                                onItemClick: (RecentCaption caption) async => Helper.openURL(caption.website!),
                                onItemLongClick: (RecentCaption caption) => Helper.navigateRoute(context, DetailPage(animeId: caption.id)),
                            ),
                        ),
                    ] + List<Widget>.generate(9, (index) {
                        int idx = (index < 7) ? (index + widget.week!) % 7 : index;
                        return Board(
                            title: AnissiaFactor.WEEKDAY[idx],
                            description: (idx == widget.week) ? "오늘" : "",
                            child: TimeTable.week(
                                week: idx,
                                height: Sizes.SIZE_300,
                                onItemClick: (anime, tmdb) => Helper.navigateRoute(context, DetailPage(animeId: anime.id)),
                            ),
                        );
                    }) + [
                        Container(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_030),
                                child: Text(
                                    "©paragonnov (github.com/qkdxorjs1002) - DB from 'Anissia' and 'TMDB'\n${_version}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor.withOpacity(0.35),
                                        fontSize: Sizes.SIZE_010,
                                        fontWeight: FontWeight.w300,
                                    ),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}