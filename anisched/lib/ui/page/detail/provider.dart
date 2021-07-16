import 'package:anisched/_API_KEY.dart';
import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/tmdb/helper.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/repository/tmdb/service.dart';
import 'package:anisched/ui/page/detail/model.dart';

class DetailDataProvider extends DataProvider {
    
    final AnissiaService _anissiaService = AnissiaService();
    final TMDBService _tmdbService = TMDBService();

    ObservableData<Anime> _animeInfo;
    ObservableData<List<Caption>> _captionList;
    ObservableData<TMDBDetail> _tmdbDetail;

    void requestAnimeInfo(int id) {
        _anissiaService.requestAnime(id).then((value) {
            _animeInfo.setData(value);
        });
    }

    void requestCaption(int id) {
        _anissiaService.requestCaption(id).then((value) {
            _captionList.setData(value);
        });
    }

    void requestTMDB(Anime anime) {
        Future(() {
            TMDBHelper(
                tmdbService: _tmdbService,
                onResultListener: OnResultListener(
                    onFind: (Result result) {
                        _requestDetail(result.mediaType, result.id);
                    },
                    onFailed: () {

                    }
                ),
            ).searchWithFilter(APIKey.TMDB_API_KEY, anime);
        });
    }

    void _requestDetail(String type, int id) {
        if (type == TMDBMediaTypes.MOVIE) {
            _tmdbService.requestMovie(APIKey.TMDB_API_KEY, "ko-KR", id).then((value) {
                _tmdbDetail.setData(TMDBDetail<Movie>.from(value));
            });
        } else if (type == TMDBMediaTypes.TV) {
            _tmdbService.requestTV(APIKey.TMDB_API_KEY, "ko-KR", id).then((value) {
                _tmdbDetail.setData(TMDBDetail<TV>.from(value));
            });
        }

        if (type == TMDBMediaTypes.MOVIE || type == TMDBMediaTypes.TV) {
            // requestVideos(apiKey, type, id);
        }
    }

    ObservableData<Anime> get getAnimeInfo {
        if (_animeInfo == null) {
            _animeInfo = ObservableData();
        }
        return _animeInfo;
    }

    ObservableData<List<Caption>> get getCaption {
        if (_captionList == null) {
            _captionList = ObservableData();
        }
        return _captionList;
    }

    ObservableData<TMDBDetail> get getTMDBDetail {
        if (_tmdbDetail == null) {
            _tmdbDetail = ObservableData();
        }
        return _tmdbDetail;
    }
}
