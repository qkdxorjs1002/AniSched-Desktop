import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/helper.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/board.dart';
import 'package:anisched/ui/widget/ranking/ranking.dart';
import 'package:anisched/ui/widget/recent/recent.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/timetable/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                }),
            ),
        );
    }

    void _navigateRoute(BuildContext context, int id) {
        Navigator.of(context).push(
            PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) => BlurTransition(
                    animation: Tween<double>(begin: 30.0, end: 0.0).animate(animation),
                    child: DetailPage(
                        animeId: id,
                    ),
                ),
            ),
        );
    }
}