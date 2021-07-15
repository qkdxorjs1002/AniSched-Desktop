import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/tool.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/widget/board.dart';
import 'package:anisched/ui/widget/ranking/ranking.dart';
import 'package:anisched/ui/widget/recent/recent.dart';
import 'package:anisched/ui/widget/timetable/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

    final int week;
    
    const HomePage({ Key key, this.week }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: ListView(
                physics: ClampingScrollPhysics(),
                children: [
                    Ranking(
                        onItemClick: (Anime anime, Result tmdb) => _navigateRoute(context, anime.id),
                    ),
                    Board(
                        title: "최근 자막",
                        description: "길게 누르면 작품 정보",
                        child: Recent(
                            onItemClick: (RecentCaption caption) async => Tool.openURL(caption.website),
                            onItemLongClick: (RecentCaption caption) => _navigateRoute(context, caption.id),
                        ),
                    ),
                ] + List<Widget>.generate(9, (index) {
                    int idx = (index < 7) ? (index + week) % 7 : index;
                    return Board(
                        title: FACTOR.WEEKDAY[idx],
                        description: (idx == week) ? "오늘" : "",
                        child: TimeTable(
                            week: idx,
                            onItemClick: (anime, tmdb) => _navigateRoute(context, anime.id),
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
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                    child: child,
                ),
                pageBuilder: (context, animation, secondaryAnimation) => DetailPage(
                    animeId: id,
                ),
            ),
        );
    }
}