import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/repository.dart';

class FavoriteDataProvider extends DataProvider {

    ObservableData<List<Anime>>? _favList;
    ObservableData<int>? _sortMode;

    void requestFavoriteList(int sortMode) {
        Repositories.preferenceService.getFavoriteList().then((value) {
            List<Anime> sorted = value;
            switch(sortMode) {
                case 1:
                case 4:
                    sorted.sort((a, b) => a.subject!.codeUnitAt(0).compareTo(b.subject!.codeUnitAt(0)));
                    break;
                case 5:
                case 2:
                    sorted.sort((a, b) => a.startDate!.compareTo(b.startDate!));
                    break;
            }
            if (sortMode >= 3) {
                sorted = sorted.reversed.toList();
            }
            _favList!.setData(sorted);
        });
    }

    void requestRemoveFavoriteList() {
        Repositories.preferenceService.removeFavoriteList().then((value) {
            _favList!.setData([]);
        });
    }

    void requestFavoriteSortMode() {
        Repositories.preferenceService.getFavoriteSortMode().then((value) {
            _sortMode!.setData(value);
        });
    }

    void requestSetFavoriteSortMode(int mode) {
        Repositories.preferenceService.setFavoriteSortMode(mode).then((value) {
            if (value) {
                requestFavoriteSortMode();
            }
        });
    }

    ObservableData<List<Anime>>? get getFavList {
        if (_favList == null) {
            _favList = ObservableData();
        }
        return _favList;
    }

    ObservableData<int>? get getSortMode {
        if (_sortMode == null) {
            _sortMode = ObservableData();
        }
        return _sortMode;
    }
}
