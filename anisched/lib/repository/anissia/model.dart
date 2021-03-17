class Anime {

    int id;

    String status;

    String time;

    String subject;

    String genres;

    String startDate;

    String endDate;

    String website;

    int captionCount;

    List<Caption> captionList;

    Anime({ 
        this.id, this.status, this.time, this.subject, 
        this.genres, this.startDate, this.endDate,
        this.website, this.captionCount, this.captionList 
    });

    factory Anime.fromJson(Map<String, dynamic> json) {
        return Anime(
            id: json['animeNo'],
            status: json['status'],
            time: json['time'],
            subject: json['subject'],
            genres: json['genres'],
            startDate: json['startDate'],
            endDate: json['endDate'],
            website: json['website'],
            captionCount: json['captionList'],
        );
    }
}

class Caption {

    String episode;

    String uploadDate;

    String website;

    String author;

    Caption({
        this.episode, this.uploadDate, this.website, this.author
    });

    factory Caption.fromJson(Map<String, dynamic> json) {
        return Caption(
            episode: json['episode'],
            uploadDate: json['updDt'],
            website: json['website'],
            author: json['name'],
        );
    }
}

class Rank {

    int id;

    String subject;

    int diff;

    int hit;

    int rank;

    Rank({
        this.id, this.subject, this.diff, this.hit, this.rank
    });

    factory Rank.fromJson(Map<String, dynamic> json) {
        return Rank(
            id: json['animeNo'],
            subject: json['subject'],
            diff: json['diff'],
            hit: json['hit'],
            rank: json['rank'],
        );
    }
}