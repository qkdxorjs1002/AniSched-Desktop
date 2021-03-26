class Search {
    
    int page;

    List<Result> resultList;

    int totalPages;

    int totalResults;

    Search({ 
        this.page, this.resultList, this.totalPages, this.totalResults,
    });

    factory Search.fromJson(Map<String, dynamic> json) {
        return Search(
            page: json['page'],
            resultList: (json['results'] as List).map((e) => Result.fromJson(e)).toList(),
            totalPages: json['total_pages'],
            totalResults: json['total_results'],
        );
    }
}

class Result {

    bool adult;

    String backdropPath;

    String firstAirDate;

    List<int> genreIdList;

    int id;

    String mediaType;

    String name;

    List<String> originCountry;

    String originalLanguage;

    String originalName;

    String originalTitle;

    String overview;

    double popularity;

    String posterPath;

    String releaseDate;

    String title;

    bool video;

    double voteAverage;

    int voteCount;

    Result({ 
        this.adult, this.backdropPath, this.firstAirDate, this.genreIdList, this.id, 
        this.mediaType, this.name, this.originCountry, this.originalLanguage, this.originalName, 
        this.originalTitle, this.overview, this.popularity, this.posterPath, this.releaseDate, 
        this.title, this.video, this.voteAverage, this.voteCount,
    });

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            adult: json['adult'],
            backdropPath: json['backdrop_path'],
            firstAirDate: json['first_air_date'],
            genreIdList: (json['genre_ids'] as List).map((e) => e as int).toList(),
            id: json['id'],
            mediaType: json['media_type'],
            name: json['name'],
            originCountry: (json['origin_country'] as List).map((e) => e as String).toList(),
            originalLanguage: json['original_language'],
            originalName: json['original_name'],
            originalTitle: json['original_title'],
            overview: json['overview'],
            popularity: json['popularity'],
            posterPath: json['poster_path'],
            releaseDate: json['release_date'],
            title: json['title'],
            video: json['video'],
            voteAverage: json['vote_average'].toDouble(),
            voteCount: json['vote_count'],
        );
    }

    String get getBackdropPath {
        if (backdropPath.isEmpty) {
            return this.getPosterPath;
        }
        return "https://image.tmdb.org/t/p/original" + backdropPath;
    }
    
    String get getPosterPath {
        if (posterPath.isEmpty) {
            return "";
        }
        return "https://image.tmdb.org/t/p/original" + posterPath;
    }

}

class Videos {

    int id;

    List<Video> videoList;
    
    Videos({ 
        this.id, this.videoList,
    });

    factory Videos.fromJson(Map<String, dynamic> json) {
        return Videos(
            id: json['id'],
            videoList: (json['results'] as List).map((e) => Video.fromJson(e)).toList(),
        );
    }

}

class Video {

    String id;

    String lang;

    String country;

    String key;

    String name;

    String site;

    int res;

    String type;

    Video({ 
        this.id, this.lang, this.country, this.key, this.name, this.site, this.res, this.type,
    });

    factory Video.fromJson(Map<String, dynamic> json) {
        return Video(
            id: json['id'],
            lang: json['iso_639_1'],
            country: json['iso_3166_1'],
            key: json['key'],
            name: json['name'],
            site: json['site'],
            res: json['res'],
            type: json['type'],
        );
    }

}
