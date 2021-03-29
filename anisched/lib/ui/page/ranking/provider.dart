import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';

class RankingDataProvider extends DataProvider {
    
    final AnissiaService _anissiaService = AnissiaService();

    ObservableData<Anime> _anime;
    ObservableData<List<Rank>> _rankList;

    void requestAnime(int id) {
        _anissiaService.requestAnime(id).then((value) {
            _anime.setData(value);
        });
    }

    void requestRanking(String factor) {
        _anissiaService.requestRanking(factor).then((value) {
            _rankList.setData(value);
        });
    }

    ObservableData<Anime> get getAnime {
        if (_anime == null) {
            _anime = ObservableData();
        }
        return _anime;
    }

    ObservableData<List<Rank>> get getRankList {
        if (_rankList == null) {
            _rankList = ObservableData();
        }
        return _rankList;
    }
}
