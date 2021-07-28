import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/repository.dart';

class RecentDataProvider extends DataProvider {

    ObservableData<List<RecentCaption>>? _recentCaptionList;

    void requestRecentCaption() {
        Repositories.anissiaService.requestRecentCaption().then((value) {
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
