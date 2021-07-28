import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/github/model.dart';
import 'package:anisched/repository/repository.dart';
import 'package:anisched/ui/page/home/model.dart';

class HomeDataProvider extends DataProvider {

    ObservableData<NewRelease>? _newRelease;

    void requestRelease(String? username, String? repo, String? os, String? version) {
        Repositories.githubService.requestRelease(username, repo).then((value) {
            Release _latest = value[0];
            
            if (_latest.tagName! != version!) {
                String _link = _latest.url!;

                _latest.assetList!.map((e) {
                    if (e.name!.contains(os == "macos" ? ".dmg" : ".zip")) {
                        _link = e.downloadUrl!;
                    }
                });
                
                _newRelease!.setData(
                    NewRelease(
                        tagName: _latest.tagName, 
                        body: _latest.body, 
                        url: _link
                    )
                );
            }
        });
    }

    ObservableData<NewRelease>? get getNewRelease {
        if (_newRelease == null) {
            _newRelease = ObservableData();
        }
        return _newRelease;
    }
}
