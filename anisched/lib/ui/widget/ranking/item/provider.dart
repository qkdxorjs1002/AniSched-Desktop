import 'package:anisched/_API_KEY.dart';
import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/tmdb/helper.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/repository/tmdb/service.dart';

class RankingItemDataProvider extends DataProvider {
    
    final AnissiaService _anissiaService = AnissiaService();
    final TMDBService _tmdbService = TMDBService();

    ObservableData<Anime> _animeInfo;
    ObservableData<Result> _tmdbResult;

    void requestAnime(int id) {
        _anissiaService.requestAnime(id).then((value) {
            _animeInfo.setData(value);
        });
    }

    void requestTMDB(Anime anime) {
        Future(() {
            TMDBHelper(
                tmdbService: _tmdbService,
                onResultListener: OnResultListener(
                    onFind: (Result result) {
                        _tmdbResult.setData(result);
                    },
                    onFailed: () {

                    }
                ),
            ).searchWithFilter(APIKey.TMDB_API_KEY, anime);
        });
    }

    ObservableData<Anime> get getAnimeInfo {
        if (_animeInfo == null) {
            _animeInfo = ObservableData();
        }
        return _animeInfo;
    }

    ObservableData<Result> get getTMDBResult {
        if (_tmdbResult == null) {
            _tmdbResult = ObservableData();
        }
        return _tmdbResult;
    }
}
