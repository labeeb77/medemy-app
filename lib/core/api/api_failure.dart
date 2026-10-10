import 'package:dio/dio.dart';

/// A failed API call, in the shape of the server's error envelope (see docs/STUDENT_API.md in the backend repo).
class ApiFailure implements Exception {
  const ApiFailure({required this.message, this.status, this.code, this.details = const [], this.retryAfterSeconds});

  final int? status;
  final String? code;
  final String message;
  final List<String> details;
  final int? retryAfterSeconds;

  /// No response reached us: offline, timed out, or the server is down.
  bool get isOffline => status == null;
  bool get isNotFound => status == 404;
  bool get isUnauthorized => status == 401;

  factory ApiFailure.fromDio(DioException error) {
    final response = error.response;
    if (response == null) {
      return const ApiFailure(message: 'You appear to be offline. Check your connection and try again.');
    }
    final body = response.data;
    final envelope = body is Map && body['error'] is Map ? body['error'] as Map : const {};
    final details = envelope['details'] is List
        ? (envelope['details'] as List).map((item) => item is Map ? '${item['message'] ?? ''}' : '$item').where((text) => text.isNotEmpty).toList()
        : const <String>[];
    return ApiFailure(
      status: response.statusCode,
      code: envelope['code'] as String?,
      message: (envelope['message'] as String?) ?? 'Something went wrong. Please try again.',
      details: details,
      retryAfterSeconds: int.tryParse(response.headers.value('retry-after') ?? ''),
    );
  }

  @override
  String toString() => 'ApiFailure($status, $code, $message)';
}
