import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:medemy_app/core/api/api_client.dart';
import 'package:medemy_app/core/auth/identity_provider.dart';
import 'package:medemy_app/core/auth/token_store.dart';

typedef Reply = ({int status, Object? body});
Reply ok(Object? data, [int status = 200]) => (status: status, body: {'data': data, 'meta': {'requestId': 'test'}});
Reply failure(int status, String code, [String message = 'Failed']) =>
    (status: status, body: {'error': {'code': code, 'message': message, 'details': [], 'requestId': 'test'}});

/// Serves canned replies and records every request, so tests need no network.
class FakeServer implements HttpClientAdapter {
  FakeServer(this.handler);
  Future<Reply> Function(RequestOptions request) handler;
  final requests = <RequestOptions>[];
  bool offline = false;

  int count(String pathEnding) => requests.where((request) => request.path.endsWith(pathEnding)).length;

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    requests.add(options);
    if (offline) throw DioException.connectionError(requestOptions: options, reason: 'offline');
    final reply = await handler(options);
    return ResponseBody.fromString(jsonEncode(reply.body), reply.status, headers: {Headers.contentTypeHeader: [Headers.jsonContentType]});
  }

  @override
  void close({bool force = false}) {}
}

/// An [ApiClient] wired exactly like the real one, but talking to [server].
ApiClient fakeApi(FakeServer server, TokenStore tokens, {Future<void> Function()? onSessionExpired}) {
  Dio build() => Dio(BaseOptions(baseUrl: 'http://test'))..httpClientAdapter = server;
  final dio = build();
  dio.interceptors.add(AuthInterceptor(dio: dio, refreshDio: build(), tokens: tokens, onSessionExpired: onSessionExpired ?? () async {}));
  return ApiClient(dio);
}

class FakeIdentity implements IdentityProvider {
  FakeIdentity({this.email, this.verified = true, this.failWith});
  String? email;
  bool verified;
  IdentityFailure? failWith;
  int verificationEmails = 0;
  final resets = <String>[];
  final tokenRequests = <bool>[];

  @override
  String? get currentEmail => email;

  @override
  Future<void> signIn(String email, String password) async {
    if (failWith != null) throw failWith!;
    this.email = email;
  }

  @override
  Future<void> createAccount(String email, String password) async {
    if (failWith != null) throw failWith!;
    this.email = email;
    verified = false;
  }

  @override
  Future<void> sendVerificationEmail() async => verificationEmails++;
  @override
  Future<bool> reloadAndCheckVerified() async => verified;
  @override
  Future<String> idToken({bool forceRefresh = false}) async {
    tokenRequests.add(forceRefresh);
    return 'id-token-${verified ? 'verified' : 'unverified'}';
  }

  @override
  Future<void> sendPasswordReset(String email) async => resets.add(email);
  @override
  Future<void> signOut() async => email = null;
}

Map<String, dynamic> studentJson({String? semesterId, String name = 'Ananya Joseph'}) => {
      'id': 'student-1', 'email': 'ananya@example.com', 'roles': ['student'],
      'profile': {'displayName': name, 'currentSemesterId': semesterId, 'avatarUrl': null},
    };
Map<String, dynamic> sessionJson({String? semesterId}) =>
    {'user': studentJson(semesterId: semesterId), 'accessToken': 'access-1', 'refreshToken': 'refresh-1', 'expiresIn': 900, 'tokenType': 'Bearer'};
