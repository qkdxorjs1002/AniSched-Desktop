import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'model.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class TMDBService {

    factory TMDBService({ String baseUrl }) {
        final dio = Dio();
        
        return _TMDBService(dio);
    }

    @GET("search/multi")
    Future<Search> requestSearch(
        @Query("api_key") String apiKey,
        @Query("language") String lang,
        @Query("query") String keyword
    );

    @GET("{type}/{id}/videos")
    Future<Videos> requestVideos(
        @Path("type") String type,
        @Path("id") int id,
        @Query("api_key") String apiKey,
        @Query("language") String lang
    );

}