import 'package:flutter/material.dart';
import 'ui/page/home/home.dart';

void main() {
    runApp(App());
}

class App extends StatelessWidget {

    Widget build(BuildContext context) {
        return MaterialApp(
            theme: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            backgroundColor: Colors.white,
                textTheme: ThemeData.light().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.black,
                ),
                accentTextTheme: ThemeData.light().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.black,
                ),
                primaryTextTheme: ThemeData.light().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.black,
                ),
            ),
            darkTheme: ThemeData.dark().copyWith(
                primaryColor: Colors.white,
                backgroundColor: Colors.black,
                textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.white,
                ),
                accentTextTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.white,
                ),
                primaryTextTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.white,
                ),
            ),
            home: HomePage(week: DateTime.now().weekday % 7),
        );
    }
}
