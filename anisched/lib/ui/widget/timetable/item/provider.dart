import 'package:anisched/_API_KEY.dart';
import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/repository.dart';
import 'package:anisched/repository/tmdb/helper.dart';
import 'package:anisched/repository/tmdb/model.dart';

class TimeTableItemDataProvider extends DataProvider {

    ObservableData<Result> _tmdbResult;

    void requestTMDB(Anime anime) {
        Future(() {
            TMDBHelper(
                tmdbService: Repositories.tmdbService,
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

    ObservableData<Result> get getTMDBResult {
        if (_tmdbResult == null) {
            _tmdbResult = ObservableData();
        }
        return _tmdbResult;
    }
}
