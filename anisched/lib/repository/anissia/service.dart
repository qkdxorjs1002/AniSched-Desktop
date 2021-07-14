import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'model.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://anissia.net/api/anime/")
abstract class AnissiaService {

    factory AnissiaService({ String baseUrl }) {
        final dio = Dio();
        
        return _AnissiaService(dio);
    }

    @GET("schedule/{week}")
    Future<List<Anime>> requestSchedule(@Path("week") int week);

    @GET("list/{page}")
    Future<List<Anime>> requestAllSchedule(@Path("page") int page);

    @GET("caption/recent")
    Future<List<RecentCaption>> requestRecentCaption();

    @GET("caption/animeNo/{id}")
    Future<List<Caption>> requestCaption(@Path("id") int id);

    @GET("animeNo/{id}")
    Future<Anime> requestAnime(@Path("id") int id);

    @GET("rank/{factor}")
    Future<List<Rank>> requestRanking(@Path("factor") String factor);

    @GET("autocorrect")
    Future<List<String>> requestAutoCorrect(@Query("q") String query);
    
}