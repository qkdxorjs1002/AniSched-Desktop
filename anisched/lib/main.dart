import 'package:anisched/arch/observable.dart';
import 'package:anisched/provider.dart';
import 'package:flutter/material.dart';
import 'ui/page/home/home.dart';

void main() {
    runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {

    final AppDataProvider _dataProvider = AppDataProvider();

    @override
    void initState() {
        super.initState();
        _initObservers();
    }

    @override
    void dispose() {
        WidgetsBinding.instance!.removeObserver(this);
        super.dispose();
    }

    @override
    void didChangeMetrics() {
        _dataProvider.requestGetWindowSize();
    }

    void _initObservers() {
        WidgetsBinding.instance!.addObserver(this);

        _dataProvider.getPrefWindowSize!.addObserver(Observer((value) {
            if (!value.isEmpty) {
                _dataProvider.requestSetWindowSize(value);
            }
        }));

        _dataProvider.getWindowSize!.addObserver(Observer((value) {
            _dataProvider.requestSetPrefWindowSize(value);
        }));
    }

    Widget build(BuildContext context) {
        if (mounted) {
            _dataProvider.requestGetPrefWindowSize();
        }
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
