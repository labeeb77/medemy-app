import 'package:flutter_test/flutter_test.dart';
import 'package:medemy_app/core/api/api_failure.dart';
import 'package:medemy_app/core/auth/token_store.dart';

import 'support/fakes.dart';

void main() {
  const stored = TokenPair(accessToken: 'old-access', refreshToken: 'old-refresh');

  test('attaches the access token, except on auth requests', () async {
    final server = FakeServer((_) async => ok({'fine': true}));
    final api = fakeApi(server, InMemoryTokenStore(stored));
    expect(await api.get('/semesters'), {'fine': true});
    await api.post('/auth/firebase', {'idToken': 'x'});
    expect(server.requests[0].headers['Authorization'], 'Bearer old-access');
    expect(server.requests[1].headers.containsKey('Authorization'), isFalse);
  });

  test('parallel 401s share one refresh and are replayed with the new token', () async {
    final tokens = InMemoryTokenStore(stored);
    late final FakeServer server;
    server = FakeServer((request) async {
      if (request.path.endsWith('/auth/refresh')) {
        // A refresh token works once, so a second refresh would sign the student out.
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return ok({'accessToken': 'new-access', 'refreshToken': 'new-refresh'});
      }
      return request.headers['Authorization'] == 'Bearer new-access' ? ok({'path': request.path}) : failure(401, 'UNAUTHORIZED');
    });
    final api = fakeApi(server, tokens);
    final results = await Future.wait([api.get('/semesters'), api.get('/me'), api.get('/academic/current')]);
    expect(results.map((result) => (result as Map)['path']), ['/api/v1/semesters', '/api/v1/me', '/api/v1/academic/current']);
    expect(server.count('/auth/refresh'), 1);
    expect((await tokens.read())!.refreshToken, 'new-refresh');
  });

  test('a failed refresh ends the session and surfaces the 401', () async {
    final tokens = InMemoryTokenStore(stored);
    var expired = 0;
    final server = FakeServer((request) async => failure(401, request.path.endsWith('/auth/refresh') ? 'TOKEN_REUSE_DETECTED' : 'UNAUTHORIZED'));
    final api = fakeApi(server, tokens, onSessionExpired: () async => expired++);
    await expectLater(api.get('/me'), throwsA(isA<ApiFailure>().having((failure) => failure.isUnauthorized, 'unauthorized', isTrue)));
    expect(expired, 1);
    expect(await tokens.read(), isNull);
  });

  test('a request that is still unauthorized after refreshing is not retried again', () async {
    final server = FakeServer((request) async =>
        request.path.endsWith('/auth/refresh') ? ok({'accessToken': 'new-access', 'refreshToken': 'new-refresh'}) : failure(401, 'UNAUTHORIZED'));
    await expectLater(fakeApi(server, InMemoryTokenStore(stored)).get('/me'), throwsA(isA<ApiFailure>()));
    expect(server.count('/me'), 2);
    expect(server.count('/auth/refresh'), 1);
  });

  test('maps the error envelope and an unreachable server', () async {
    final server = FakeServer((_) async => failure(404, 'NOT_FOUND', 'This content is not available'));
    final api = fakeApi(server, InMemoryTokenStore(stored));
    await expectLater(api.get('/topic-placements/x/content'), throwsA(isA<ApiFailure>()
        .having((failure) => failure.isNotFound, 'not found', isTrue)
        .having((failure) => failure.code, 'code', 'NOT_FOUND')
        .having((failure) => failure.message, 'message', 'This content is not available')));
    server.offline = true;
    await expectLater(api.get('/semesters'), throwsA(isA<ApiFailure>().having((failure) => failure.isOffline, 'offline', isTrue)));
  });
}
