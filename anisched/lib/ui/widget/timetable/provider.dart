import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/anissia/service.dart';

class TimeTableDataProvider extends DataProvider {

    final AnissiaService _anissiaService = AnissiaService();

    ObservableData<List<Anime>> _scheduleList;

    void requestSchedule(int week) {
        _anissiaService.requestSchedule(week).then((value) {
            _scheduleList.setData(value);
        });
    }

    ObservableData<List<Anime>> get getScheduleList {
        if (_scheduleList == null) {
            _scheduleList = ObservableData();
        }
        return _scheduleList;
    }
}
