import 'dart:io';

import 'package:flutter/material.dart';
import 'ui/page/home/home.dart';

void main() {
    HttpOverrides.global = CustomHttpOverrides();
    runApp(App());
}

class CustomHttpOverrides extends HttpOverrides{

    @override
    HttpClient createHttpClient(SecurityContext? context){
        return super.createHttpClient(context)
            ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
    }
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
            ),
            darkTheme: ThemeData.dark().copyWith(
                primaryColor: Colors.white,
                backgroundColor: Colors.black,
                textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.white,
                ),
            ),
            home: HomePage(week: DateTime.now().weekday % 7),
        );
    }
}
