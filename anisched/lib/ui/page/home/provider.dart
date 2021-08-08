import 'package:anisched/arch/observable.dart';
import 'package:anisched/arch/provider.dart';
import 'package:anisched/repository/github/model.dart';
import 'package:anisched/repository/github/service.dart';
import 'package:anisched/repository/preference/service.dart';
import 'package:anisched/repository/repository.dart';
import 'package:anisched/ui/page/home/model.dart';

class HomeDataProvider extends DataProvider {

    final GithubService _githubService = Repositories.githubService;
    final PreferenceService _preferenceService = Repositories.preferenceService;

    ObservableData<NewRelease>? _newRelease;

    void requestRelease(String? username, String? repo, String? os, String? version) {
        _githubService.requestRelease(username, repo).then((value) {
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

    void requestClearPreference() {
        _preferenceService.clear();
    }

    ObservableData<NewRelease>? get getNewRelease {
        if (_newRelease == null) {
            _newRelease = ObservableData();
        }
        return _newRelease;
    }
}
