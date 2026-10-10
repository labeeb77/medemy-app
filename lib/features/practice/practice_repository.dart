import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_failure.dart';
import '../../core/auth/session.dart';
import 'models.dart';

typedef SessionPage = ({List<PracticeSession> sessions, String? nextCursor});

class PracticeRepository {
  PracticeRepository(this._api);
  final ApiClient _api;

  Future<PracticeSession> start({required PracticeCategory category, String? contextId, int questionCount = 10}) async => PracticeSession.fromJson(
      await _api.post('/practice-sessions', {'category': category.apiValue, 'contextId': ?contextId, 'questionCount': questionCount}) as Map<String, dynamic>);

  Future<PracticeSession> get(String sessionId) async => PracticeSession.fromJson(await _api.get('/practice-sessions/$sessionId') as Map<String, dynamic>);

  Future<PracticeItem> answer(String sessionId, String itemId, String optionKey, {int? responseTimeMs}) async => PracticeItem.fromJson(
      await _api.post('/practice-sessions/$sessionId/items/$itemId/attempts', {'optionKey': optionKey, 'responseTimeMs': ?responseTimeMs}) as Map<String, dynamic>);

  Future<void> complete(String sessionId) => _api.post('/practice-sessions/$sessionId/complete');

  Future<SessionPage> history({String? cursor, int limit = 20}) async {
    final page = await _api.getPage('/practice-sessions', query: {'limit': limit, 'cursor': ?cursor});
    return (sessions: page.items.map((item) => PracticeSession.fromJson(item as Map<String, dynamic>)).toList(), nextCursor: page.nextCursor);
  }
}

final practiceRepositoryProvider = Provider<PracticeRepository>((ref) => PracticeRepository(ref.watch(apiClientProvider)));

/// The most recent sessions, for the hub's "Continue" card and recent list.
final recentSessionsProvider = FutureProvider.autoDispose<List<PracticeSession>>((ref) async => (await ref.watch(practiceRepositoryProvider).history(limit: 10)).sessions);

final practiceSessionProvider = AsyncNotifierProvider.autoDispose.family<PracticeSessionController, PracticeSession, String>(PracticeSessionController.new);

/// One session and the changes a student can make to it. The server is the only source of what is correct.
class PracticeSessionController extends AsyncNotifier<PracticeSession> {
  PracticeSessionController(this.sessionId);
  final String sessionId;

  PracticeRepository get _repository => ref.read(practiceRepositoryProvider);

  @override
  Future<PracticeSession> build() => _repository.get(sessionId);

  Future<PracticeSession> _reload() async {
    final session = await _repository.get(sessionId);
    state = AsyncData(session);
    return session;
  }

  /// Submits the one final answer for [itemId] and returns the item with its answer revealed.
  /// Sending the same answer again is safe, so the caller may simply retry after a dropped connection.
  Future<PracticeItem> answer(String itemId, String optionKey, {int? responseTimeMs}) async {
    PracticeItem answered;
    try {
      answered = await _repository.answer(sessionId, itemId, optionKey, responseTimeMs: responseTimeMs);
    } on ApiFailure catch (failure) {
      // Already answered elsewhere, or the session was finished: the server's record is the truth, so adopt it.
      if (failure.code != 'ATTEMPT_EXISTS' && failure.code != 'SESSION_COMPLETED') rethrow;
      final session = await _reload();
      final item = session.items.firstWhere((candidate) => candidate.id == itemId);
      if (item.attempt == null) rethrow;
      return item;
    }
    final session = state.value;
    if (session != null) {
      state = AsyncData(session.copyWith(items: [for (final item in session.items) item.id == itemId ? answered : item]));
    }
    return answered;
  }

  Future<PracticeSession> complete() async {
    await _repository.complete(sessionId);
    ref.invalidate(recentSessionsProvider);
    return _reload();
  }
}
