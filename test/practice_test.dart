import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medemy_app/core/api/api_failure.dart';
import 'package:medemy_app/core/auth/session.dart';
import 'package:medemy_app/core/auth/token_store.dart';
import 'package:medemy_app/core/theme/app_theme.dart';
import 'package:medemy_app/features/practice/models.dart';
import 'package:medemy_app/features/practice/practice_repository.dart';
import 'package:medemy_app/features/practice/practice_screens.dart';

import 'support/fakes.dart';

/// A practice backend in miniature: two questions, option A correct in both, answers revealed only once attempted.
class PracticeBackend {
  PracticeBackend({this.status = 'active', this.empty = false});
  String status;
  bool empty;
  final attempts = <String, String>{};
  final submitted = <String>[];
  Reply? nextAnswerReply;

  Map<String, dynamic> _item(int order) {
    final id = 'item-$order';
    final chosen = attempts[id];
    return {
      'id': id, 'displayOrder': order, 'questionVersionId': 'qv-$order', 'questionType': 'clinical_mcq', 'difficulty': 'medium',
      'stem': 'Question $order: which action comes first?',
      'options': [for (final key in ['A', 'B'])
        {'optionKey': key, 'text': key == 'A' ? 'Sit the patient upright' : 'Give oral fluids', if (chosen != null) 'isCorrect': key == 'A', if (chosen != null) 'rationale': 'Rationale $key'}],
      'attempt': chosen == null ? null : {'selectedOptionKey': chosen, 'isCorrect': chosen == 'A', 'correctOptionKey': 'A', 'rationale': 'Airway and breathing first.',
        'keyConcept': 'Prioritise by ABC', 'answeredAt': '2026-10-10T07:18:07.070Z'},
    };
  }

  Map<String, dynamic> session({bool withItems = true}) {
    final correct = attempts.values.where((key) => key == 'A').length;
    return {
      'id': 'session-1', 'category': 'high_yield', 'contextType': null, 'contextId': null, 'status': status, 'startedAt': '2026-10-10T07:18:07.056Z',
      'completedAt': status == 'completed' ? '2026-10-10T07:30:00.000Z' : null, 'totalQuestions': 2, 'requestedQuestionCount': 10, 'correctCount': correct,
      'answeredCount': attempts.length, 'scorePercentage': status == 'completed' && attempts.isNotEmpty ? correct / attempts.length * 100 : null,
      if (withItems) 'items': [_item(1), _item(2)],
    };
  }

  Future<Reply> handle(dynamic request) async {
    final path = request.path as String;
    if (path.endsWith('/attempts')) {
      final itemId = path.split('/')[path.split('/').length - 2];
      final key = (request.data as Map)['optionKey'] as String;
      submitted.add(key);
      if (nextAnswerReply != null) { final reply = nextAnswerReply!; nextAnswerReply = null; return reply; }
      attempts.putIfAbsent(itemId, () => key);
      return ok(_item(int.parse(itemId.split('-').last)), 201);
    }
    if (path.endsWith('/complete')) { status = 'completed'; return ok(session(withItems: false)); }
    if (path.endsWith('/practice-sessions') && request.method == 'POST') return empty ? failure(422, 'NO_ELIGIBLE_QUESTIONS') : ok(session(), 201);
    if (path.endsWith('/practice-sessions')) return (status: 200, body: {'data': empty ? [] : [session(withItems: false)], 'meta': {'requestId': 't', 'nextCursor': null}});
    return ok(session());
  }
}

void main() {
  late PracticeBackend backend;
  late FakeServer server;

  setUp(() {
    backend = PracticeBackend();
    server = FakeServer((request) => backend.handle(request));
  });

  List<Object?> overrides() {
    final tokens = InMemoryTokenStore(const TokenPair(accessToken: 'a', refreshToken: 'r'));
    return [apiClientProvider.overrideWith((ref) => fakeApi(server, tokens))];
  }

  Widget app(String location, {double textScale = 1, Object? extra}) {
    final router = GoRouter(initialLocation: location, initialExtra: extra, routes: [
      GoRoute(path: '/learn', builder: (_, _) => const Scaffold(body: Text('Learn tab'))),
      GoRoute(path: '/practice', builder: (_, _) => const PracticeHubScreen(), routes: [GoRoute(path: 'history', builder: (_, _) => const PracticeHistoryScreen())]),
      GoRoute(path: '/practice/setup', builder: (_, state) => PracticeSetupScreen(setup: state.extra as PracticeSetup? ?? const PracticeSetup(category: PracticeCategory.highYield))),
      GoRoute(path: '/practice/sessions/:id', builder: (_, state) => PracticeSessionScreen(sessionId: state.pathParameters['id']!, notice: state.extra as String?), routes: [
        GoRoute(path: 'results', builder: (_, state) => PracticeResultsScreen(sessionId: state.pathParameters['id']!)),
        GoRoute(path: 'review', builder: (_, state) => PracticeReviewScreen(sessionId: state.pathParameters['id']!)),
      ]),
    ]);
    return ProviderScope(retry: (_, _) => null, overrides: [...overrides().cast()], child: MaterialApp.router(theme: buildTheme(Brightness.light), routerConfig: router,
        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)), child: child!)));
  }

  FilledButton button(WidgetTester tester, String label) => tester.widget<FilledButton>(find.widgetWithText(FilledButton, label));

  test('parses a session before and after an answer, and a history row without items', () {
    final fresh = PracticeSession.fromJson(backend.session());
    expect(fresh.items.first.options.first.isCorrect, isNull, reason: 'the answer key is absent until attempted');
    expect([fresh.nextUnanswered, fresh.answered, fresh.unanswered], [0, 0, 2]);
    backend.attempts['item-1'] = 'B';
    final answered = PracticeSession.fromJson(backend.session());
    expect(answered.items.first.attempt!.correctOptionKey, 'A');
    expect([answered.nextUnanswered, answered.correct, answered.incorrect, answered.unanswered], [1, 0, 1, 1]);
    final row = PracticeSession.fromJson(backend.session(withItems: false));
    expect([row.items.length, row.answered], [0, 1]);
    expect(PracticeCategory.fromApi('faculty_pick'), PracticeCategory.facultyPick);
  });

  test('the controller adopts the server record when an answer already exists, and rethrows real failures', () async {
    final container = ProviderContainer(retry: (_, _) => null, overrides: [...overrides().cast()]);
    addTearDown(container.dispose);
    final subscription = container.listen(practiceSessionProvider('session-1'), (_, _) {});
    addTearDown(subscription.close);
    await container.read(practiceSessionProvider('session-1').future);
    final controller = container.read(practiceSessionProvider('session-1').notifier);

    // Answered on another device as A; this device tries B.
    backend.attempts['item-1'] = 'A';
    backend.nextAnswerReply = failure(409, 'ATTEMPT_EXISTS');
    final item = await controller.answer('item-1', 'B');
    expect(item.attempt!.selectedOptionKey, 'A');
    expect(container.read(practiceSessionProvider('session-1')).value!.answered, 1);

    backend.nextAnswerReply = failure(422, 'INVALID_ANSWER');
    await expectLater(controller.answer('item-2', 'Z'), throwsA(isA<ApiFailure>()));
    server.offline = true;
    await expectLater(controller.answer('item-2', 'A'), throwsA(isA<ApiFailure>().having((failure) => failure.isOffline, 'offline', isTrue)));
  });

  testWidgets('a full session: setup, answer, feedback, finish, results and review', (tester) async {
    await tester.pumpWidget(app('/practice/setup'));
    await tester.pumpAndSettle();
    expect(find.text('10 questions'), findsOneWidget);
    await tester.tap(find.byTooltip('More questions'));
    await tester.pump();
    expect(find.text('15 questions'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Start practice'));
    await tester.pumpAndSettle();
    expect((server.requests.firstWhere((request) => request.method == 'POST').data as Map)['questionCount'], 15);
    expect(find.textContaining('Only 2 questions available'), findsOneWidget);

    // The first answer is final: nothing to submit until a choice is made, and nothing to change afterwards.
    expect(find.text('Question 1 of 2'), findsOneWidget);
    expect(button(tester, 'Submit answer').onPressed, isNull);
    expect(find.textContaining('correct'), findsNothing);
    await tester.tap(find.text('Give oral fluids'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Submit answer'));
    await tester.pumpAndSettle();
    expect(find.text('Incorrect. The correct answer is A.'), findsOneWidget);
    expect(find.text('Your answer, incorrect'), findsOneWidget);
    expect(find.text('Correct answer'), findsOneWidget);
    await tester.tap(find.text('Sit the patient upright'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Prioritise by ABC'), 200, scrollable: find.byType(Scrollable).first);
    expect(find.text('Airway and breathing first.'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(backend.submitted, ['B'], reason: 'tapping another option after answering sends nothing');

    await tester.tap(find.widgetWithText(FilledButton, 'Next question'));
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 2'), findsOneWidget);
    await tester.tap(find.text('Sit the patient upright'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Submit answer'));
    await tester.pumpAndSettle();
    expect(find.text('Your answer, correct'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Finish and see results'));
    await tester.pumpAndSettle();

    expect(find.text('1 of 2 correct'), findsOneWidget);
    expect(find.text('50% of the questions you answered'), findsOneWidget);
    expect(backend.status, 'completed');
    await tester.tap(find.widgetWithText(FilledButton, 'Review answers'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Question 1:'), findsOneWidget);
    expect(find.textContaining('Question 2:'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'Incorrect'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Question 1:'), findsOneWidget);
    expect(find.textContaining('Question 2:'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a failed submit keeps the choice, and trying again sends the same answer', (tester) async {
    await tester.pumpWidget(app('/practice/sessions/session-1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sit the patient upright'));
    await tester.pump();
    server.offline = true;
    await tester.tap(find.widgetWithText(FilledButton, 'Submit answer'));
    await tester.pumpAndSettle();
    expect(find.textContaining('offline'), findsOneWidget);
    expect(find.textContaining('Your answer'), findsNothing, reason: 'correctness is never guessed without the server');

    server.offline = false;
    await tester.tap(find.widgetWithText(FilledButton, 'Try again'));
    await tester.pumpAndSettle();
    expect(backend.submitted, ['A']);
    expect(find.text('Your answer, correct'), findsOneWidget);
  });

  testWidgets('resuming opens the first unanswered question; finishing early scores only what was answered', (tester) async {
    backend.attempts['item-1'] = 'A';
    await tester.pumpWidget(app('/practice/sessions/session-1'));
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 2'), findsOneWidget);
    await tester.tap(find.byTooltip('Session options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Finish and see results'));
    await tester.pumpAndSettle();
    expect(find.textContaining('You have answered 1 of 2'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Finish'));
    await tester.pumpAndSettle();
    expect(find.text('1 of 1 correct'), findsOneWidget);
    expect(find.descendant(of: find.widgetWithText(ListTile, 'Unanswered'), matching: find.text('1')), findsOneWidget);
  });

  testWidgets('a category with nothing to practise says so plainly', (tester) async {
    backend.empty = true;
    await tester.pumpWidget(app('/practice/setup', extra: const PracticeSetup(category: PracticeCategory.bookmarked)));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Start practice'));
    await tester.pumpAndSettle();
    expect(find.text('Nothing to practise here yet'), findsOneWidget);
  });

  testWidgets('the hub offers every category, resumes an active session, and sends topic practice to Learn', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 1600 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app('/practice'));
    await tester.pumpAndSettle();
    for (final category in PracticeCategory.values) {
      expect(find.text(category.label), findsWidgets, reason: category.label);
    }
    expect(find.text('Continue your session'), findsOneWidget);
    await tester.tap(find.text('Topic'));
    await tester.pumpAndSettle();
    expect(find.text('Learn tab'), findsOneWidget);
  });

  testWidgets('without sessions the hub has no Continue card, and history is empty', (tester) async {
    backend.empty = true;
    await tester.pumpWidget(app('/practice'));
    await tester.pumpAndSettle();
    expect(find.text('Continue your session'), findsNothing);
    await tester.scrollUntilVisible(find.text('You have not practised yet.'), 300, scrollable: find.byType(Scrollable).first);
    expect(find.text('You have not practised yet.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(app('/practice/history'));
    await tester.pumpAndSettle();
    expect(find.text('No sessions yet'), findsOneWidget);
  });

  testWidgets('a question stays usable on a small phone at double text size', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    backend.attempts['item-1'] = 'B';
    await tester.pumpWidget(app('/practice/sessions/session-1', textScale: 2));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Submit answer'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
