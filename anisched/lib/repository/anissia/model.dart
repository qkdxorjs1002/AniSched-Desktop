class AnissiaFactor {
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

    int? id;

    String? status;

    String? time;

    int? week;

    String? subject;

    String? genres;

    String? startDate;

    String? endDate;

    String? website;

    int? captionCount;

    List<Caption>? captionList;

    Anime({ 
        this.id, this.status, this.time, this.week, this.subject, 
        this.genres, this.startDate, this.endDate,
        this.website, this.captionCount, this.captionList 
    });

    factory Anime.fromJson(Map<String, dynamic> json) {
        int? week = -1;
        
        try {
            week = int.tryParse(json['week']);
        } catch (Exception) { }

        return Anime(
            id: json['animeNo'],
            status: json['status'],
            time: json['time'],
            week: week,
            subject: json['subject'],
            genres: json['genres'],
            startDate: json['startDate'],
            endDate: json['endDate'],
            website: json['website'],
            captionCount: json['captionCount'],
            captionList: (json['captions'] as List?)?.map((e) => Caption.fromJson(e)).toList(),
        );
    }

    String get getExtraInfo {
        if (time!.contains(":")) {
            return (isSoon)
                ? (time!.contains(":"))
                    ? startDate!.replaceAll("-99", "").replaceAll(RegExp("\\d\\d\\d\\d-"), "")
                    : startDate!.replaceAll("-99", "")
                : (!isEnd) 
                    ? (isStatus)
                        ? "" 
                        : "결방"
                    : "종영";
        }
        
        return "";
    } 

    String get getGenreString => genres!.replaceAll(",", " ᐧ ");

    List<String> get getGenreList => genres!.split(",");

    bool get isStatus {
        return (status == "ON" ? true : false);
    }

    bool get isSoon {
        if (startDate == "") {
            return true;
        }
        return DateTime.now().isBefore(DateTime.parse(startDate!));
    }

    bool get isEnd {
        if (endDate == "") {
            return false;
        }
        return DateTime.now().isAfter(DateTime.parse(endDate!));
    }

    String get getTimeString => time!.isNotEmpty ? time!.replaceAll("-99", "") : "미정";
    
    String get getStartDateString => startDate!.isNotEmpty ? startDate!.replaceAll("-99", "") : "미정";
    
    String get getEndDateString => endDate!.isNotEmpty ? endDate!.replaceAll("-99", "") : "미정";
}

class RecentCaption extends Caption {
    
    int? id;

    String? subject;

    RecentCaption({
        episode, uploadDate, website, author, this.id, this.subject
    }) : super(
        episode: episode, uploadDate: uploadDate, website: website, author: author
    );

    factory RecentCaption.fromJson(Map<String, dynamic> json) {
        return RecentCaption(
            id: json['animeNo'],
            subject: json['subject'],
            episode: json['episode'],
            uploadDate: json['updDt'],
            website: json['website'],
            author: json['name'],
        );
    }

}

class Caption {

    String? episode;

    String? uploadDate;

    String? website;

    String? author;

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

    String get getEpisodeString => (episode == "0" ? (isWIP ? "준비중" : "단편") : episode! + "화");

    bool get isWIP => DateTime.now().isBefore(DateTime.parse(uploadDate!));

    String get getUploadDateString {
        Duration diff = DateTime.now().difference(DateTime.parse(uploadDate!));

        if (diff.inDays > 0) {
            if (diff.inDays >= 30) {
                int inMonth = diff.inDays ~/ 30;
                
                if (inMonth >= 12) {
                    return "${(inMonth ~/ 12).toString()}년 전";
                } else {
                    return "${inMonth.toString()}개월 전";
                }
            } 
            return "${diff.inDays.toString()}일 전";
        } else if (diff.inHours > 0) {
            return "${diff.inHours.toString()}시간 전";
        } else if (diff.inMinutes > 0) {
            return "${diff.inMinutes.toString()}분 전";
        } else {
            return "방금 전";
        }
    }
}

class Rank {

    int? id;

    String? subject;

    int? diff;

    int? hit;

    int? rank;

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

    String get diffString => (diff != 0 ? (diff!.isOdd ? "▲" : "▼") + diff!.abs().toString() : "");

    String get rankString => "${rank.toString()}위";
}

class AutoCorrect {

    int? id;

    String? subject;

    AutoCorrect({ this.id, this.subject });

    factory AutoCorrect.fromString(String string) {
        final int delimIdx = string.indexOf(" ");

        return AutoCorrect(
            id: int.parse(string.substring(0, delimIdx)),
            subject: string.substring(delimIdx + 1, string.length),
        );
    }

}

class AllAnime {

    List<Anime>? content;

    bool? isLast;

    int? number;

    int? totalElements;

    int? totalPages;

    AllAnime({
        this.content, this.isLast, this.number, this.totalElements, this.totalPages
    });

    void update(AllAnime allAnime) {
        if (content == null) {
            content = [];
        }
        this.content!.addAll(allAnime.content!);
        this.isLast = allAnime.isLast;
        this.number = allAnime.number;
        this.totalElements = allAnime.totalElements;
        this.totalPages = allAnime.totalPages;
    }

    factory AllAnime.fromJson(Map<String, dynamic> json) {
        return AllAnime(
            content: (json['content'] as List?)?.map((e) => Anime.fromJson(e)).toList(),
            isLast: json['last'],
            number: json['number'],
            totalElements: json['totalElements'],
            totalPages: json['totalPages'],
        );
    }
}