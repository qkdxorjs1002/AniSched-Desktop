import 'dart:convert';

import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/repository.dart';

class SearchDataProvider extends DataProvider {

    ObservableData<List<AutoCorrect>>? _autoCorrectList;
    ObservableData<AllAnime>? _allAnime;
    String? _query;

    void requestAutoCorrect(String query) {
        Repositories.anissiaService.requestAutoCorrect(query).then((value) {
            _autoCorrectList!.setData((jsonDecode(value) as List).map((e) => AutoCorrect.fromString(e)).toList());
        });
    }

    void requestAllSchedule(int page, String query) {
        _query = query;
        Repositories.anissiaService.requestAllSchedule(page, query).then((value) {
            _allAnime!.setData(value);
        });
    }
    
    void requestAllScheduleNext() {
        final AllAnime _pre = _allAnime!.getData!;

        if (_pre.isLast!) {
            return;
        }

        Repositories.anissiaService.requestAllSchedule(_pre.number! + 1, _query).then((value) {
            AllAnime temp = AllAnime()..update(_pre)..update(value);
            _allAnime!.setData(temp);
        });
    }

    ObservableData<List<AutoCorrect>>? get getAutoCorrectList {
        if (_autoCorrectList == null) {
            _autoCorrectList = ObservableData();
        }
        return _autoCorrectList;
    }

    ObservableData<AllAnime>? get getAnimeList {
        if (_allAnime == null) {
            _allAnime = ObservableData();
        }
        return _allAnime;
    }
}
