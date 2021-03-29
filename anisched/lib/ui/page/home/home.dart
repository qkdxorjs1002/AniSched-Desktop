import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/page/ranking/ranking.dart';
import 'package:anisched/ui/page/schedule/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
    final int week;
    
    const HomePage({ Key key, this.week }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: Row(
                children: [
                    Expanded(
                        child: Schedule(
                            week: week,
                        ),
                    ),
                    SizedBox(
                        width: 1,
                        height: double.infinity,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: double.infinity,
                        child: Container(
                            color: Color.fromRGBO(15, 15, 15, 1),
                            child: Ranking(
                                factor: FACTOR.WEEK,
                            ),
                        ),
                    ),
                ],
            ),
        );
    }
}