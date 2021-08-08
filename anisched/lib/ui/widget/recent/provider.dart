import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/repository.dart';

class RecentDataProvider extends DataProvider {

    final AnissiaService _anissiaService = Repositories.anissiaService;

    ObservableData<List<RecentCaption>>? _recentCaptionList;

    void requestRecentCaption() {
        _anissiaService.requestRecentCaption().then((value) {
            _recentCaptionList!.setData(value);
        });
    }

    ObservableData<List<RecentCaption>>? get getRecentCaptionList {
        if (_recentCaptionList == null) {
            _recentCaptionList = ObservableData();
        }
        return _recentCaptionList;
    }
}
