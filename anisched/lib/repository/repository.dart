import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/github/service.dart';
import 'package:anisched/repository/preference/service.dart';
import 'package:anisched/repository/tmdb/service.dart';

class Repositories {

    static final AnissiaService anissiaService = AnissiaService();
    static final TMDBService tmdbService = TMDBService();
    static final GithubService githubService = GithubService();
    static final PreferenceService preferenceService = PreferenceService();

}