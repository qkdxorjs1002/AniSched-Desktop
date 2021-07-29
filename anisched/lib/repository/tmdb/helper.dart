import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/service.dart';
import 'package:anisched/helper.dart';

import 'model.dart';

typedef ResultListener<T> = void Function(T data);

class OnResultListener {

    final ResultListener<Result>? onFind;
    final Function? onFailed;

    OnResultListener({ this.onFind, this.onFailed });
}

class TMDBHelper {

    final OnResultListener? onResultListener;

    final TMDBService? tmdbService;

    final List<String> _regexList = [
        r"", r"(\s\d기)|(\s(OVA|OAD))|(\s(IX|IV|V?I{0,3})$)|(\s\d[snrt][tdh])|(((\sthe)(\s\w+|)|)\s(시즌|season)(\d|\s\d|))"
    ];

    TMDBHelper({ this.tmdbService, this.onResultListener });

    void searchWithFilter(String apiKey, Anime anime) {
        search(apiKey, anime.subject, anime, _regexList.iterator);
    }

    void search(String apiKey, String? keyword, Anime anime, Iterator<String> iterator) {
        tmdbService!.requestSearch(apiKey, "ko-KR", keyword).then((searches) {
            List<Result>? result = searches.resultList;

            if (result != null || result!.isNotEmpty) {
                int idx = selectBestResult(result, keyword, anime);
                if (idx != -1) {
                    onResultListener!.onFind!(result[idx]);
                    return;
                }
            }

            if (!iterator.moveNext()) {
                onResultListener!.onFailed!();
                return;
            }
            String filtered = keyword!.replaceAll(RegExp(iterator.current, caseSensitive: false), "");
            search(apiKey, filtered, anime, iterator);
        });
    }

    int selectBestResult(List<Result> result, String? keyword, Anime anime) {
        int similar = -1;
        double lastDiff = -1;

        for (int idx = 0; result.length > idx; idx++) {
            Result target = result[idx];

            if (target.firstAirDate == anime.startDate) {
                similar = idx;
                break;
            }

            List<int>? genreIdList = target.genreIdList;
            if (genreIdList == null || genreIdList.isEmpty) {
                continue;
            }

            if (genreIdList.contains(16) && ((target.mediaType == "tv" || target.mediaType == "movie"))) {
                String targetString = target.getTitle!.replaceAll(" ", "");

                double diff = (Levenshtein.getDistance(targetString, anime.subject!.replaceAll(" ", ""))
                        + Levenshtein.getDistance(targetString, keyword!.replaceAll(" ", ""))) / 2;

                if (lastDiff < diff) {
                    similar = idx;
                    lastDiff = diff;
                }
            }
        }

        return similar;
    }
}