import 'package:anisched/repository/anissia/service.dart';
import 'package:anisched/repository/github/service.dart';
import 'package:anisched/repository/tmdb/service.dart';

class Repositories {

    static AnissiaService anissiaService = AnissiaService();
    static TMDBService tmdbService = TMDBService();
    static GithubService githubService = GithubService();

}