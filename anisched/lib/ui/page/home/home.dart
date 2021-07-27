import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/helper.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/page/search/search.dart';
import 'package:anisched/ui/widget/board.dart';
import 'package:anisched/ui/widget/ranking/ranking.dart';
import 'package:anisched/ui/widget/recent/recent.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/timetable/timetable.dart';
import 'package:anisched/ui/widget/tools/item/item.dart';
import 'package:anisched/ui/widget/tools/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HomePage extends StatelessWidget {
    
    final int week;
    
    const HomePage({ Key key, this.week }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        Sizes.initialize(context);
        
        return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: ListView(
                physics: const ClampingScrollPhysics(),
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
                                        Icons.hide_image_outlined,
                                        size: Sizes.SIZE_024,
                                    ), 
                                    text: "",
                                    onItemClick: () => ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Theme.of(context).backgroundColor,
                                            content: Text(
                                                "이미지 캐시를 삭제합니다. 이미지 캐시를 제거할 경우, 일시적으로 데이터 사용량이 증가할 수 있습니다.",
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.w300,
                                                ),
                                            ),
                                            action: SnackBarAction(
                                                textColor: Theme.of(context).primaryColor,
                                                disabledTextColor: Theme.of(context).primaryColor.withOpacity(0.5),
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
                                    ),
                                ),
                            ],
                        ),
                    ),
                    Board(
                        title: "최근 자막",
                        description: "길게 누르면 작품 정보",
                        child: Recent(
                            onItemClick: (RecentCaption caption) async => Helper.openURL(caption.website),
                            onItemLongClick: (RecentCaption caption) => Helper.navigateRoute(context, DetailPage(animeId: caption.id)),
                        ),
                    ),
                ] + List<Widget>.generate(9, (index) {
                    int idx = (index < 7) ? (index + week) % 7 : index;
                    return Board(
                        title: FACTOR.WEEKDAY[idx],
                        description: (idx == week) ? "오늘" : "",
                        child: TimeTable(
                            week: idx,
                            onItemClick: (anime, tmdb) => Helper.navigateRoute(context, DetailPage(animeId: anime.id)),
                        ),
                    );
                }) + [
                    Container(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_030),
                            child: Text(
                                "©paragonnov (github.com/qkdxorjs1002) - DB from 'Anissia' and 'TMDB'",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor.withOpacity(0.65),
                                    fontSize: Sizes.SIZE_010,
                                    fontWeight: FontWeight.w300,
                                ),
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}