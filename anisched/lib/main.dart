import 'package:flutter/material.dart';
import 'ui/page/home/home.dart';

void main() {
    runApp(App());
}

class App extends StatelessWidget {

    Widget build(BuildContext context) {
        return MaterialApp(
            color: Colors.black,
            theme: ThemeData.dark(),
            home: HomePage(week: DateTime.now().weekday % 7),
        );
    }
}
