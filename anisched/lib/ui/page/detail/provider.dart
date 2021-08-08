import 'package:anisched/_API_KEY.dart';
import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/repository.dart';
import 'package:anisched/repository/tmdb/helper.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/page/detail/model.dart';

class DetailDataProvider extends DataProvider {

    ObservableData<Anime>? _animeInfo;
    ObservableData<List<Caption>>? _captionList;
    ObservableData<TMDBDetail>? _tmdbDetail;
    ObservableData<bool>? _isFavorited;

    void requestAnimeInfo(int id) {
        Repositories.anissiaService.requestAnime(id).then((value) {
            _animeInfo!.setData(value);
        });
    }

    void requestCaption(int id) {
        Repositories.anissiaService.requestCaption(id).then((value) {
            _captionList!.setData(value);
        });
    }

    void requestTMDB(Anime anime) {
        Future(() {
            TMDBHelper(
                tmdbService: Repositories.tmdbService,
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

    void _requestDetail(String? type, int? id) {
        if (type == TMDBMediaTypes.MOVIE) {
            Repositories.tmdbService.requestMovie(APIKey.TMDB_API_KEY, "ko-KR", id).then((value) {
                _tmdbDetail!.setData(TMDBDetail<Movie>.from(value));
            });
        } else if (type == TMDBMediaTypes.TV) {
            Repositories.tmdbService.requestTV(APIKey.TMDB_API_KEY, "ko-KR", id).then((value) {
                _tmdbDetail!.setData(TMDBDetail<TV>.from(value));
            });
        }

        if (type == TMDBMediaTypes.MOVIE || type == TMDBMediaTypes.TV) {
            // requestVideos(apiKey, type, id);
        }
    }

    void requestExistFavorite(int id) {
        Repositories.preferenceService.existFavorite(id).then((value) {
            _isFavorited!.setData(value);
        });
    }

    void requestAddFavorite(Anime anime) {
        Repositories.preferenceService.addFavorite(anime).then((value) {
            if (value) {
                requestExistFavorite(anime.id!);
            }
        });
    }

    void requestDelFavorite(int id) {
        Repositories.preferenceService.delFavorite(id).then((value) {
            if (value) {
                requestExistFavorite(id);
            }
        });
    }

    ObservableData<Anime>? get getAnimeInfo {
        if (_animeInfo == null) {
            _animeInfo = ObservableData();
        }
        return _animeInfo;
    }

    ObservableData<List<Caption>>? get getCaption {
        if (_captionList == null) {
            _captionList = ObservableData();
        }
        return _captionList;
    }

    ObservableData<TMDBDetail>? get getTMDBDetail {
        if (_tmdbDetail == null) {
            _tmdbDetail = ObservableData();
        }
        return _tmdbDetail;
    }

    ObservableData<bool>? get getIsFavorited {
        if (_isFavorited == null) {
            _isFavorited = ObservableData();
        }
        return _isFavorited;
    }
}
