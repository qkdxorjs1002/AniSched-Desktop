import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'model.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://api.github.com/")
abstract class GithubService {

    factory GithubService({ String? baseUrl }) {
        final dio = Dio();
        
        return _GithubService(dio);
    }

    @GET("repos/{username}/{repo}/releases")
    Future<List<Release>> requestRelease(
        @Path("username") String? username,
        @Path("repo") String? repo,
    );
    
}