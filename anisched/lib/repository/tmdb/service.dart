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
        @Query("query") String keyword,
    );

    @GET("movie/{id}")
    Future<Movie> requestMovie(
        @Query("api_key") String apiKey,
        @Query("language") String lang,
        @Path("id") int id,
    );

    @GET("tv/{id}")
    Future<TV> requestTV(
        @Query("api_key") String apiKey,
        @Query("language") String lang,
        @Path("id") int id,
    );

    @GET("{type}/{id}/videos")
    Future<Videos> requestVideos(
        @Query("api_key") String apiKey,
        @Query("language") String lang,
        @Path("type") String type,
        @Path("id") int id,
    );

}