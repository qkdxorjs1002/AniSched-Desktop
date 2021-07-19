import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/repository.dart';
class RankingDataProvider extends DataProvider {

    ObservableData<List<Rank>> _rankList;

    void requestRanking() {
        Repositories.anissiaService.requestRanking(FACTOR.WEEK).then((value) {
            _rankList.setData(value);
        });
    }

    ObservableData<List<Rank>> get getRankList {
        if (_rankList == null) {
            _rankList = ObservableData();
        }
        return _rankList;
    }
}
