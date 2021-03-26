class FACTOR {
    static const Map<int, String> WEEKDAY = {
        0: "일요일",
        1: "월요일",
        2: "화요일",
        3: "수요일",
        4: "목요일",
        5: "금요일",
        6: "토요일",
        7: "외전",
        8: "신작",
    };

    static const String WEEK = "week";
    static const String MONTH = "month";
    static const String QUARTER = "quarter";
}

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

    String get extraInfo {
        if (time.contains(":")) {
            return (isSoon
                ? startDate.replaceAll(RegExp("\\d\\d\\d\\d-"), "")
                : (!isEnd 
                    ? (isStatus 
                        ? "" 
                        : "결방") 
                    : "종영"));
        }
        
        return "";
    } 

    String get genreString => genres.replaceAll(",", " / ");

    bool get isStatus {
        return (status == "ON" ? true : false);
    }

    bool get isSoon {
        if (startDate == "") {
            return true;
        }
        return DateTime.now().isBefore(DateTime.parse(startDate));
    }

    bool get isEnd {
        if (endDate == "") {
            return false;
        }
        return DateTime.now().isAfter(DateTime.parse(endDate));
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

    String get diffString => (diff != 0 ? diff.abs().toString() + (diff.isOdd ? " ▼" : " ▲") : "");

    String get rankString => "${rank.toString()}위";
}