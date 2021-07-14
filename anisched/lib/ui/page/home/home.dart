import 'package:anisched/ui/widget/board.dart';
import 'package:anisched/ui/widget/ranking/ranking.dart';
import 'package:anisched/ui/widget/recent/recent.dart';
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
                children: [
                    Ranking(),
                    Board(
                        title: "최근 자막",
                        child: Recent(),
                    ),
                ],
            ),
        );
    }
}