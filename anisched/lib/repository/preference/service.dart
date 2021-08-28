import 'dart:convert';

import 'package:anisched/repository/anissia/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {

    /** 
     * Perference Keys
     * - "PREFERENCE_SCHEME_VERSION" Integer : scheme version for future preference conversion
     * - "PREFERENCE_FAVORITES" String : favorite list
     * - "PREFERENCE_FAVORITES_SORT_MODE" String : favorite list sorting method
    */
    static const String PREFERENCE_SCHEME_VERSION = "scheme_version";
    static const String PREFERENCE_FAVORITES = "favorites";
    static const String PREFERENCE_FAVORITES_SORT_MODE = "favorites_sort_mode";

    late final SharedPreferences _instance;

    PreferenceService() {
        SharedPreferences.getInstance().then((value) {
            _instance = value;
        });
    }

    Future<bool> clear() {
        return _instance.clear();
    }

    bool _convertScheme() {
        int? version = _instance.getInt(PREFERENCE_SCHEME_VERSION);
    }

    Future<List<Anime>> getFavoriteList() {
        return Future<List<Anime>>(() {
            String? string = _instance.getString(PREFERENCE_FAVORITES);
            if (string == null) {
                return [];
            }
            List<dynamic> list = jsonDecode(string);

            return list.map((e) => Anime.fromJson(e)).toList();
        });
    }

    Future<bool> setFavoriteList(List<Anime> list) {
        return _instance.setString(PREFERENCE_FAVORITES, jsonEncode(list));
    }

    Future<bool> removeFavoriteList() {
        return _instance.remove(PREFERENCE_FAVORITES);
    }

    Future<bool> addFavorite(Anime anime) {
        return Future<bool>(() async {
            List<Anime> favList = await getFavoriteList();
            favList.add(anime);

            return setFavoriteList(favList);
        });
    }

    Future<int> findFavorite(int id) {
        return Future<int>(() async {
            List<Anime> favList = await getFavoriteList();

            return favList.indexWhere((element) => (element.id == id));
        });
    }

    Future<bool> existFavorite(int id) {
        return Future<bool>(() async {
            return (await findFavorite(id) >= 0);
        });
    }

    Future<bool> delFavorite(int id) {
        return Future<bool>(() async {
            List<Anime> favList = await getFavoriteList();
            favList.removeAt(await findFavorite(id));

            return setFavoriteList(favList);
        });
    }

    Future<int> getFavoriteSortMode() {
        return Future<int>(() {
            int? mode = _instance.getInt(PREFERENCE_FAVORITES_SORT_MODE);
            if (mode == null) {
                return 0;
            }

            return mode;
        });
    }

    Future<bool> setFavoriteSortMode(int mode) {
        return _instance.setInt(PREFERENCE_FAVORITES_SORT_MODE, mode);
    }

    Future<bool> removeFavoriteSortMode() {
        return _instance.remove(PREFERENCE_FAVORITES_SORT_MODE);
    }
}