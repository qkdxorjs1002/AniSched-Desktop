// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TMDBService implements TMDBService {
  _TMDBService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.themoviedb.org/3/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<Search> requestSearch(apiKey, lang, keyword) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(lang, 'lang');
    ArgumentError.checkNotNull(keyword, 'keyword');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': lang,
      r'query': keyword
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('search/multi',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Search.fromJson(_result.data);
    return value;
  }

  @override
  Future<Movie> requestMovie(apiKey, lang, id) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(lang, 'lang');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': lang
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('movie/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Movie.fromJson(_result.data);
    return value;
  }

  @override
  Future<TV> requestTV(apiKey, lang, id) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(lang, 'lang');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': lang
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('tv/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TV.fromJson(_result.data);
    return value;
  }

  @override
  Future<Videos> requestVideos(apiKey, lang, type, id) async {
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    ArgumentError.checkNotNull(lang, 'lang');
    ArgumentError.checkNotNull(type, 'type');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': lang
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('$type/$id/videos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Videos.fromJson(_result.data);
    return value;
  }
}
