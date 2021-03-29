import 'package:anisched/_API_KEY.dart';
import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/tmdb/helper.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/repository/tmdb/service.dart';

class ScheduleDataProvider extends DataProvider {
    
    final AnissiaService _anissiaService = AnissiaService();
    final TMDBService _tmdbService = TMDBService();

    ObservableData<List<Anime>> _scheduleList;
    ObservableData<Result> _tmdbResult;

    void requestSchedule(int week) {
        _anissiaService.requestSchedule(week).then((value) {
            _scheduleList.setData(value);
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

    ObservableData<List<Anime>> get getScheduleList {
        if (_scheduleList == null) {
            _scheduleList = ObservableData();
        }
        return _scheduleList;
    }

    ObservableData<Result> get getTMDBResult {
        if (_tmdbResult == null) {
            _tmdbResult = ObservableData();
        }
        return _tmdbResult;
    }
}
