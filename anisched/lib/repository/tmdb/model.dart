class TMDBMediaTypes {
    static const String TV = "tv";
    static const String MOVIE = "movie";
}

class TMDBImageSizes {
    static const String ORIGINAL = "original";
    static const String W300 = "w300";
    static const String W500 = "w500";
    static const String W1280 = "w1280";
}

abstract class TMDBInterface {

    String getBackdropPath(String width);
    
    String getPosterPath(String width);

    int get getVoteDecimal;

    double get getVoteDouble;

    String get getVoteCountString;

    String get getTitle;

    String get getOriginalTitle;

    String get getOverview;
}

abstract class TMDBMediaInterface implements TMDBInterface {

    String get getProductionsString;
}

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
            resultList: (json['results'] as List)?.map((e) => Result.fromJson(e))?.toList(),
            totalPages: json['total_pages'],
            totalResults: json['total_results'],
        );
    }
}

class Result implements TMDBInterface {

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
            genreIdList: (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
            id: json['id'],
            mediaType: json['media_type'],
            name: json['name'],
            originCountry: (json['origin_country'] as List)?.map((e) => e as String)?.toList(),
            originalLanguage: json['original_language'],
            originalName: json['original_name'],
            originalTitle: json['original_title'],
            overview: json['overview'],
            popularity: json['popularity']?.toDouble(),
            posterPath: json['poster_path'],
            releaseDate: json['release_date'],
            title: json['title'],
            video: json['video'],
            voteAverage: json['vote_average']?.toDouble(),
            voteCount: json['vote_count'],
        );
    }

    @override
    String getBackdropPath(String width) {
        if (backdropPath == null || backdropPath.isEmpty) {
            return this.getPosterPath(width);
        }
        return "https://image.tmdb.org/t/p/${width}${backdropPath}";
    }
    
    @override
    String getPosterPath(String width) {
        if (posterPath == null || posterPath.isEmpty) {
            return "";
        }
        return "https://image.tmdb.org/t/p/${width}${posterPath}";
    }

    @override
    String get getTitle {
        if (mediaType == TMDBMediaTypes.TV) {
            return name;
        } else if (mediaType == TMDBMediaTypes.MOVIE) {
            return title;
        }
        return "";
    }

    @override
    String get getOriginalTitle {
        if (mediaType == TMDBMediaTypes.TV) {
            return originalName;
        } else if (mediaType == TMDBMediaTypes.MOVIE) {
            return originalTitle;
        }
        return "";
    }

    @override
    int get getVoteDecimal => (voteAverage * 10).toInt();

    @override
    double get getVoteDouble => (voteAverage / 10);

    @override
    String get getVoteCountString => "${voteCount}명의 시청자 평가";

    @override
    String get getOverview => (overview != null && overview.isNotEmpty) ? overview : "줄거리 내용 없음";

}

class TV implements TMDBMediaInterface {

    String backdropPath;

    List<int> episodeRuntime;

    String firstAirDate;

    List<Genre> genreList;

    String homepage;

    int id;

    bool inProduction;

    List<String> languageList;

    String lastAirDate;

    Episode lastEpisodeToAir;

    String name;

    List<Network> networkList;

    int numberOfEpisodes;

    int numberOfSeasons;

    List<String> originCountry;

    String originalLanguage;

    String originalName;

    String overview;

    double popularity;

    String posterPath;

    List<Production> productionCompany;

    List<Season> seasonList;

    String status;

    String tagLine;

    String type;

    double voteAverage;

    int voteCount;

    TV({ 
        this.backdropPath, this.episodeRuntime, this.firstAirDate, this.genreList, this.homepage, this.id, this.inProduction, this.languageList, 
        this.lastAirDate, this.lastEpisodeToAir, this.name, this.networkList, this.numberOfEpisodes, this.numberOfSeasons, this.originCountry, this.originalLanguage, 
        this.originalName, this.overview, this.popularity, this.posterPath, this.productionCompany, this.seasonList, this.status, this.tagLine, this.type, this.voteAverage, this.voteCount,
    });

    factory TV.fromJson(Map<String, dynamic> json) {
        return TV(
            backdropPath: json['backdrop_path'],
            episodeRuntime: (json['episode_run_time'] as List)?.map((e) => e as int)?.toList(),
            firstAirDate: json['first_air_date'],
            genreList: (json['genres'] as List)?.map((e) => Genre.fromJson(e))?.toList(),
            homepage: json['homepage'],
            id: json['id'],
            inProduction: json['in_production'],
            languageList: (json['languages'] as List)?.map((e) => e as String)?.toList(),
            lastAirDate: json['last_air_date'],
            lastEpisodeToAir: (json['last_episode_to_air'] != null) ? Episode.fromJson(json['last_episode_to_air']) : null,
            name: json['name'],
            networkList: (json['networks'] as List)?.map((e) => Network.fromJson(e))?.toList(),
            numberOfEpisodes: json['number_of_episodes'],
            numberOfSeasons: json['number_of_seasons'],
            originCountry: (json['origin_country'] as List)?.map((e) => e as String)?.toList(),
            originalLanguage: json['original_language'],
            originalName: json['original_name'],
            overview: json['overview'],
            popularity: json['popularity']?.toDouble(),
            posterPath: json['poster_path'],
            productionCompany: (json['production_companies'] as List)?.map((e) => Production.fromJson(e))?.toList(),
            seasonList: (json['seasons'] as List)?.map((e) => Season.fromJson(e))?.toList(),
            status: json['status'],
            tagLine: json['tagline'],
            type: json['type'],
            voteAverage: json['vote_average']?.toDouble(),
            voteCount: json['vote_count'],
        );
    }

    String get getNetworksString {
        String string = "";

        if (networkList != null) {
            for (int idx = 0; idx < networkList.length; idx++) {
                string += networkList[idx].name;
                if (idx < networkList.length - 1) {
                    string += " • ";
                } 
            }
        } else {
            return "방영사 정보 없음";
        }

        return string;
    }

    String get getProductionsString {
        String string = "";

        if (productionCompany != null) {
            for (int idx = 0; idx < productionCompany.length; idx++) {
                string += productionCompany[idx].name;
                if (idx < productionCompany.length - 1) {
                    string += " • ";
                } 
            }
        } else {
            return "제작사 정보 없음";
        }

        return string;
    }

    @override
    String getBackdropPath(String width) {
        if (backdropPath == null || backdropPath.isEmpty) {
            return this.getPosterPath(width);
        }
        return "https://image.tmdb.org/t/p/${width}${backdropPath}";
    }
    
    @override
    String getPosterPath(String width) {
        if (posterPath == null || posterPath.isEmpty) {
            return "";
        }
        return "https://image.tmdb.org/t/p/${width}${posterPath}";
    }

    @override
    int get getVoteDecimal => (voteAverage * 10).toInt();

    @override
    double get getVoteDouble => (voteAverage / 10);

    @override
    String get getVoteCountString => "${voteCount}명의 시청자 평가";

    @override
    String get getOverview => (overview != null && overview.isNotEmpty) ? overview : "줄거리 내용 없음";

    @override
    String get getTitle => name;

    @override
    String get getOriginalTitle => originalName;

}

class Movie implements TMDBMediaInterface {

    bool adult;

    String backdropPath;

    int budget;

    List<Genre> genreList;

    String homepage;

    int id;

    String imdbId;

    String originalLanguage;

    String originalTitle;

    String overview;

    double popularity;

    String posterPath;

    List<Production> productionCompany;

    String releaseDate;

    int revenue;

    int runtime;

    String status;

    String tagLine;

    String title;

    bool video;

    double voteAverage;

    int voteCount;

    Movie({ 
        this.adult, this.backdropPath, this.budget, this.genreList, this.homepage, this.id, this.imdbId,
        this.originalLanguage, this.originalTitle, this.overview, this.popularity, this.posterPath, this.productionCompany,
        this.releaseDate, this.revenue, this.runtime, this.status, this.tagLine, this.title, this.video, this.voteAverage, this.voteCount,
    });

    factory Movie.fromJson(Map<String, dynamic> json) {
        return Movie(
            adult: json['adult'],
            backdropPath: json['backdrop_path'],
            budget: json['budget'],
            genreList: (json['genres'] as List)?.map((e) => Genre.fromJson(e))?.toList(),
            homepage: json['homepage'],
            id: json['id'],
            imdbId: json['imdb_id'],
            originalLanguage: json['original_language'],
            originalTitle: json['original_title'],
            overview: json['overview'],
            popularity: json['popularity']?.toDouble(),
            posterPath: json['poster_path'],
            productionCompany: (json['production_companies'] as List)?.map((e) => Production.fromJson(e))?.toList(),
            releaseDate: json['release_date'],
            revenue: json['revenue'],
            runtime: json['runtime'],
            status: json['status'],
            tagLine: json['tagline'],
            title: json['title'],
            video: json['video'],
            voteAverage: json['vote_average']?.toDouble(),
            voteCount: json['vote_count'],
        );
    }

    String get getProductionsString {
        String string = "";

        if (productionCompany != null) {
            for (int idx = 0; idx < productionCompany.length; idx++) {
                string += productionCompany[idx].name;
                if (idx < productionCompany.length - 1) {
                    string += " • ";
                } 
            }
        } else {
            return "제작사 정보 없음";
        }

        return string;
    }

    @override
    String getBackdropPath(String width) {
        if (backdropPath == null || backdropPath.isEmpty) {
            return this.getPosterPath(width);
        }
        return "https://image.tmdb.org/t/p/${width}${backdropPath}";
    }
    
    @override
    String getPosterPath(String width) {
        if (posterPath == null || posterPath.isEmpty) {
            return "";
        }
        return "https://image.tmdb.org/t/p/${width}${posterPath}";
    }

    @override
    int get getVoteDecimal => (voteAverage * 10).toInt();
    
    @override
    double get getVoteDouble => (voteAverage / 10);

    @override
    String get getVoteCountString => "${voteCount}명의 시청자 평가";

    @override
    String get getOverview => (overview != null && overview.isNotEmpty) ? overview : "줄거리 내용 없음";

    @override
    String get getTitle => title;

    @override
    String get getOriginalTitle => originalTitle;
    
}

class Episode {

    String airDate;

    int episodeNumber;

    int id;

    String name;

    String overview;

    String productionCode;

    int seasonNumber;

    String stillPath;

    double voteAverage;

    int voteCount;

    Episode({ 
        this.airDate, this.episodeNumber, this.id, this.name,
        this.overview, this.productionCode, this.seasonNumber,
        this.stillPath, this.voteAverage, this.voteCount
    });

    factory Episode.fromJson(Map<String, dynamic> json) {
        return Episode(
            airDate: json['air_date'],
            episodeNumber: json['episode_number'],
            id: json['id'],
            name: json['name'],
            overview: json['overview'],
            productionCode: json['production_code'],
            seasonNumber: json['season_number'],
            stillPath: json['still_path'],
            voteAverage: json['vote_average'],
            voteCount: json['vote_count'],
        );
    }
    
    String getStillPath(String width) {
        if (stillPath == null || stillPath.isEmpty) {
            return "";
        }
        return "https://image.tmdb.org/t/p/${width}${stillPath}";
    }
    
    String get getOverview => (overview != null && overview.isNotEmpty) ? overview : "줄거리 내용 없음";

    int get getVoteDecimal => (voteAverage * 10).toInt();
    
    double get getVoteDouble => (voteAverage / 10);

    String get getVoteCountString => "${voteCount}명의 시청자 평가";
}

class Season {

    String airDate;

    int episodeCount;

    int id;

    String name;

    String overview;

    String posterPath;

    int seasonNumber;

    Season({ 
        this.airDate, this.episodeCount, this.id, this.name,
        this.overview, this.posterPath, this.seasonNumber,
    });

    factory Season.fromJson(Map<String, dynamic> json) {
        return Season(
            airDate: json['air_date'],
            episodeCount: json['episode_count'],
            id: json['id'],
            name: json['name'],
            overview: json['overview'],
            posterPath: json['poster_path'],
            seasonNumber: json['season_number'],
        );
    }
    
    String getPosterPath(String width) {
        if (posterPath == null || posterPath.isEmpty) {
            return "";
        }
        return "https://image.tmdb.org/t/p/${width}${posterPath}";
    }

}

class Genre {

    int id;

    String name;

    Genre({ this.id, this.name });

    factory Genre.fromJson(Map<String, dynamic> json) {
        return Genre(
            id: json['id'],
            name: json['name'],
        );
    }
}

class Production {

    int id;

    String logoPath;

    String name;

    String originCountry;

    Production({ this.id, this.logoPath, this.name, this.originCountry });

    factory Production.fromJson(Map<String, dynamic> json) {
        return Production(
            id: json['id'],
            logoPath: json['logo_path'],
            name: json['name'],
            originCountry: json['origin_country'],
        );
    }

    String getLogoURL(String width) {
        if (logoPath == null || logoPath == "") {
            return "";
        }
        return "https://image.tmdb.org/t/p/${width}${logoPath}";
    }

}

class Network {

    int id;

    String logoPath;

    String name;

    String originCountry;

    Network({ this.id, this.logoPath, this.name, this.originCountry });

    factory Network.fromJson(Map<String, dynamic> json) {
        return Network(
            id: json['id'],
            logoPath: json['logo_path'],
            name: json['name'],
            originCountry: json['origin_country'],
        );
    }

    String getLogoURL(String width) {
        if (logoPath == null || logoPath == "") {
            return "";
        }
        return "https://image.tmdb.org/t/p/${width}${logoPath}";
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
            videoList: (json['results'] as List)?.map((e) => Video.fromJson(e))?.toList(),
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
            res: json['size'],
            type: json['type'],
        );
    }

}
