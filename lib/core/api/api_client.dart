import 'dart:async';

import 'package:dio/dio.dart';

import '../auth/token_store.dart';
import 'api_failure.dart';

const _retried = 'medemy.retried';
bool _isAuthPath(String path) => path.contains('/auth/');

/// Attaches the access token and, on a 401, refreshes it once and replays the request.
/// Parallel requests that fail together share a single refresh, because a refresh token works only once.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.dio, required this.refreshDio, required this.tokens, required this.onSessionExpired});

  final Dio dio;
  final Dio refreshDio;
  final TokenStore tokens;
  final Future<void> Function() onSessionExpired;
  Future<TokenPair?>? _refreshing;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!_isAuthPath(options.path)) {
      final current = await tokens.read();
      if (current != null) options.headers['Authorization'] = 'Bearer ${current.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    if (err.response?.statusCode != 401 || _isAuthPath(options.path) || options.extra[_retried] == true) {
      return handler.next(err);
    }
    final refreshed = await (_refreshing ??= _refresh().whenComplete(() => _refreshing = null));
    if (refreshed == null) {
      await onSessionExpired();
      return handler.next(err);
    }
    try {
      options.extra[_retried] = true;
      options.headers['Authorization'] = 'Bearer ${refreshed.accessToken}';
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (again) {
      handler.next(again);
    }
  }

  Future<TokenPair?> _refresh() async {
    final current = await tokens.read();
    if (current == null) return null;
    try {
      final response = await refreshDio.post<dynamic>('/api/v1/auth/refresh', data: {'refreshToken': current.refreshToken});
      final pair = TokenPair.fromJson((response.data as Map)['data'] as Map<String, dynamic>);
      await tokens.write(pair);
      return pair;
    } on DioException {
      await tokens.clear();
      return null;
    }
  }
}

/// Thin wrapper over Dio that unwraps the `{ data, meta }` envelope and turns errors into [ApiFailure].
class ApiClient {
  ApiClient(this._dio);

  factory ApiClient.create({required String baseUrl, required TokenStore tokens, required Future<void> Function() onSessionExpired}) {
    BaseOptions options() => BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20), headers: {'Accept': 'application/json'});
    final dio = Dio(options());
    dio.interceptors.add(AuthInterceptor(dio: dio, refreshDio: Dio(options()), tokens: tokens, onSessionExpired: onSessionExpired));
    return ApiClient(dio);
  }

  final Dio _dio;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) => _send(() => _dio.get<dynamic>('/api/v1$path', queryParameters: query));
  Future<dynamic> post(String path, [Object? body]) => _send(() => _dio.post<dynamic>('/api/v1$path', data: body ?? const <String, dynamic>{}));
  Future<dynamic> patch(String path, Object body) => _send(() => _dio.patch<dynamic>('/api/v1$path', data: body));

  Future<dynamic> _send(Future<Response<dynamic>> Function() request) async {
    try {
      final response = await request();
      final body = response.data;
      return body is Map ? body['data'] : null;
    } on DioException catch (error) {
      throw ApiFailure.fromDio(error);
    }
  }
}
