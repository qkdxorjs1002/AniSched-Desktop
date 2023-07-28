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
                textTheme: ThemeData.light().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.black,
                ), colorScheme: ColorScheme.light(background: Colors.white),
            ),
            darkTheme: ThemeData.dark().copyWith(
                primaryColor: Colors.white,
                textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: "Noto Sans CJK KR",
                    bodyColor: Colors.white,
                ), colorScheme: ColorScheme.dark(background: Colors.black),
            ),
            home: HomePage(week: DateTime.now().weekday % 7),
        );
    }
}
