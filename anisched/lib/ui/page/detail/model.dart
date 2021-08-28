import 'package:anisched/repository/tmdb/model.dart';

class TMDBDetail<T> {

    final T? media;
    final String? type;

    TMDBDetail({
        this.media, this.type
    });

    factory TMDBDetail.from(T media) {
        return TMDBDetail(
            media: media,
            type: (T is TV) ? TMDBMediaTypes.TV : TMDBMediaTypes.MOVIE,
        );
    }

}