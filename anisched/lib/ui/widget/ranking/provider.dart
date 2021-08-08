import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/repository.dart';
class RankingDataProvider extends DataProvider {

    final AnissiaService _anissiaService = Repositories.anissiaService;

    ObservableData<List<Rank>>? _rankList;

    void requestRanking() {
        _anissiaService.requestRanking(AnissiaFactor.WEEK).then((value) {
            _rankList!.setData(value);
        });
    }

    ObservableData<List<Rank>>? get getRankList {
        if (_rankList == null) {
            _rankList = ObservableData();
        }
        return _rankList;
    }
}
