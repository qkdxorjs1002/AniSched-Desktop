import 'package:flutter/material.dart';

import 'ui/page/home.dart';

void main() {
    runApp(App());
}

class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            color: Colors.black,
            theme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.indigo,
            ),
            home: HomePage(week: DateTime.now().weekday),
        );
    }
}
