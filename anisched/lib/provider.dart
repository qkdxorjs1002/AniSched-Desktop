import 'dart:ui';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/preference/service.dart';
import 'package:anisched/repository/repository.dart';
import 'package:desktop_window/desktop_window.dart';

class AppDataProvider extends DataProvider {

    final PreferenceService _preferenceService = Repositories.preferenceService;

    ObservableData<Size>? _prefWindowSize;
    ObservableData<Size>? _windowSize;

    void requestSetPrefWindowSize(Size size) {
        _preferenceService.setWindowSize(size);
    }

    void requestGetPrefWindowSize() {
        _preferenceService.getWindowSize().then((value) => _prefWindowSize!.setData(value));
    }

    void requestSetWindowSize(Size size) {
        DesktopWindow.setWindowSize(size);
    }

    void requestGetWindowSize() {
        DesktopWindow.getWindowSize().then((value) => _windowSize!.setData(value));
    }

    ObservableData<Size>? get getPrefWindowSize {
        if (_prefWindowSize == null) {
            _prefWindowSize = ObservableData();
        }
        return _prefWindowSize;
    }

    ObservableData<Size>? get getWindowSize {
        if (_windowSize == null) {
            _windowSize = ObservableData();
        }
        return _windowSize;
    }
}
