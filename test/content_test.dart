import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medemy_app/core/api/api_failure.dart';
import 'package:medemy_app/core/theme/app_theme.dart';
import 'package:medemy_app/features/academic/academic_repository.dart';
import 'package:medemy_app/features/academic/learn_screens.dart';
import 'package:medemy_app/features/academic/models.dart';
import 'package:medemy_app/features/topic/block_renderers.dart';
import 'package:medemy_app/features/topic/models.dart';
import 'package:medemy_app/features/topic/topic_repository.dart';
import 'package:medemy_app/features/topic/topic_screens.dart';

// One block of every type in the contract, with the payload fields documented in docs/STUDENT_API.md.
const _payloads = <String, Map<String, dynamic>>{
  'quick_concept_card': {'summary': 'The heart cannot pump enough blood.', 'keyPoints': ['Reduced cardiac output']},
  'definition_card': {'term': 'Preload', 'definition': 'Ventricular filling volume.', 'clinicalContext': 'Raised in fluid overload.'},
  'visual_concept_card': {'title': 'Forward and backward failure', 'diagramType': 'flow', 'elements': ['Left ventricle'], 'caption': 'Overview'},
  'pathophysiology_card': {'etiology': 'Myocardial damage', 'progressionSteps': ['Reduced contractility', 'Fluid retention'],
    'compensatoryMechanisms': ['RAAS activation'], 'clinicalConsequences': ['Pulmonary congestion']},
  'manifestations_card': {'signs': ['Crackles'], 'symptoms': ['Dyspnoea'], 'earlyVsLate': {'early': ['Fatigue'], 'late': ['Orthopnoea']}, 'redFlags': ['Pink frothy sputum']},
  'diagnostics_card': {'investigations': [{'testName': 'BNP', 'findings': 'Elevated', 'normalValue': 'Under 100 pg/mL', 'nursingImplications': 'Trend the value'}]},
  'pharmacology_card': {'drugClasses': [{'className': 'Loop diuretics', 'mechanism': 'Block sodium reabsorption', 'commonDrugs': ['Furosemide'],
    'adverseEffects': ['Hypokalaemia'], 'nursingAlerts': ['Monitor potassium']}]},
  'nursing_priority_card': {'immediatePriorities': ['Sit upright'], 'nursingDiagnoses': ['Decreased cardiac output'],
    'monitoringParameters': ['Daily weight'], 'patientEducation': ['Fluid restriction']},
  'comparison_card': {'title': 'Left versus right', 'columns': ['Left-sided', 'Right-sided'], 'rows': [{'feature': 'Congestion', 'values': ['Pulmonary', 'Systemic']}]},
  'exam_focus_card': {'highYieldPearls': ['Weigh at the same time daily'], 'commonPitfalls': ['Confusing preload and afterload'], 'examMnemonics': ['FACES']},
};

Map<String, dynamic> _block(String key, {int schemaVersion = 1, String mode = 'learn', Map<String, dynamic>? payload}) => {
      'id': 'block-$key-$schemaVersion', 'mode': mode, 'type': key.replaceAll('_card', ''), 'rendererKey': key, 'schemaVersion': schemaVersion,
      'title': 'Title $key', 'payload': payload ?? _payloads[key] ?? {}, 'assets': [],
      'citations': [{'resourceTitle': "Lewis's Medical-Surgical Nursing", 'resourceVersion': 3, 'pageFrom': 132, 'pageTo': 134, 'section': null}],
    };

TopicContent _content(List<Map<String, dynamic>> blocks) => TopicContent.fromJson({'contentVersionId': 'version-1', 'versionNumber': 3,
  'topicPlacementId': 'topic-1', 'title': 'Heart Failure', 'mode': 'learn', 'blocks': blocks});

Widget _app(Widget child, {List<Object?> overrides = const [], double textScale = 1}) => ProviderScope(
    retry: (_, _) => null,
    overrides: [...overrides.cast()],
    child: MaterialApp(theme: buildTheme(Brightness.light), home: MediaQuery(data: MediaQueryData(textScaler: TextScaler.linear(textScale)), child: child)));

void main() {
  test('parses the contract samples and ignores fields it does not know', () {
    final content = TopicContent.fromJson({'contentVersionId': 'ec048912', 'versionNumber': 3, 'topicPlacementId': 'c471318e', 'title': 'Heart Failure',
      'mode': 'learn', 'somethingNew': true, 'blocks': [{..._block('quick_concept_card'), 'futureField': 1,
        'assets': [{'id': 'a1', 'mimeType': 'image/png', 'altText': 'Flow', 'url': 'https://example.com/a.png', 'urlExpiresIn': 900}]}]});
    expect(content.blocks.single.assets.single.altText, 'Flow');
    expect(content.blocks.single.citations.single.pageFrom, 132);

    final tree = TopicNode.fromJson({'id': 't1', 'title': 'Heart Failure', 'displayOrder': 1, 'availability': 'available', 'hasContent': true,
      'contentVersionId': 'v1', 'children': [{'id': 't2', 'title': 'Left-Sided', 'availability': 'coming_soon', 'hasContent': false, 'contentVersionId': null, 'children': []}]});
    expect(tree.children.single.comingSoon, isTrue);
    expect(CurriculumNode.fromJson({'id': 's1', 'title': 'Nursing', 'code': null, 'description': null, 'displayOrder': 1, 'availability': 'available', 'unitCount': 2}).unitCount, 2);
    expect(Semester.fromJson({'id': 's', 'semesterNumber': 3, 'displayOrder': 3, 'isCurrent': true}).isCurrent, isTrue);
  });

  test('every renderer key in the contract is supported, and unknown ones are not', () {
    expect(supportedSchemaVersions.keys.toSet(), _payloads.keys.toSet());
    for (final key in _payloads.keys) {
      expect(canRender(ContentBlock.fromJson(_block(key))), isTrue, reason: key);
    }
    expect(canRender(ContentBlock.fromJson(_block('case_study_card'))), isFalse);
    expect(canRender(ContentBlock.fromJson(_block('quick_concept_card', schemaVersion: 2))), isFalse);
  });

  testWidgets('a topic renders every block type, and unknown blocks degrade to an update notice', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final content = _content([for (final key in _payloads.keys) _block(key), _block('case_study_card'), _block('quick_concept_card', schemaVersion: 2)]);
    await tester.pumpWidget(_app(const TopicContentScreen(topicPlacementId: 'topic-1', mode: ContentMode.learn),
        overrides: [topicContentProvider.overrideWith((ref, request) async => content)]));
    await tester.pumpAndSettle();

    final list = find.byType(Scrollable).first;
    for (final text in ['The heart cannot pump enough blood.', 'Ventricular filling volume.', 'Reduced contractility', 'Pink frothy sputum', 'Under 100 pg/mL',
      'Monitor potassium', 'Daily weight', 'Systemic', 'Confusing preload and afterload']) {
      await tester.scrollUntilVisible(find.textContaining(text), 300, scrollable: list);
      expect(find.textContaining(text), findsWidgets, reason: text);
    }
    await tester.scrollUntilVisible(find.text('Update the app to view this part of the topic.').first, 300, scrollable: list);
    expect(find.text('Update the app to view this part of the topic.'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('content reflows without overflow on a small phone at double text size', (tester) async {
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final content = _content([for (final key in _payloads.keys) _block(key)]);
    await tester.pumpWidget(_app(const TopicContentScreen(topicPlacementId: 'topic-1', mode: ContentMode.highYield), textScale: 2,
        overrides: [topicContentProvider.overrideWith((ref, request) async => content)]));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(find.textContaining('FACES'), find.byType(Scrollable).first, const Offset(0, -400), maxIteration: 200);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sources open in a sheet with a student-safe citation', (tester) async {
    await tester.pumpWidget(_app(const TopicContentScreen(topicPlacementId: 'topic-1', mode: ContentMode.learn),
        overrides: [topicContentProvider.overrideWith((ref, request) async => _content([_block('quick_concept_card')]))]));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sources (1)'));
    await tester.pumpAndSettle();
    expect(find.text("Lewis's Medical-Surgical Nursing (version 3), pages 132–134"), findsOneWidget);
  });

  testWidgets('a 404 shows the unavailable state without saying why; other failures offer a retry', (tester) async {
    Future<void> show(Object error) async {
      await tester.pumpWidget(_app(const TopicContentScreen(topicPlacementId: 'topic-1', mode: ContentMode.learn), overrides: [
        topicContentProvider.overrideWith((ref, request) => Future<TopicContent>.error(error)),
      ]));
      await tester.pumpAndSettle();
    }

    await show(const ApiFailure(status: 404, code: 'NOT_FOUND', message: 'This content is not available'));
    expect(find.text('Not available yet'), findsOneWidget);
    expect(find.text('Try again'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    await show(const ApiFailure(message: 'You appear to be offline. Check your connection and try again.'));
    expect(find.text('You are offline'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('the topic overview offers only the modes that have content', (tester) async {
    final content = _content([_block('quick_concept_card'), _block('exam_focus_card', mode: 'exam_high_yield')]);
    await tester.pumpWidget(_app(const TopicOverviewScreen(topicPlacementId: 'topic-1'), overrides: [topicContentProvider.overrideWith((ref, request) async => content)]));
    await tester.pumpAndSettle();
    expect(find.text('Learn'), findsOneWidget);
    expect(find.text('Exam High-Yield'), findsOneWidget);
    expect(find.text('Not available for this topic yet.'), findsOneWidget);
  });

  testWidgets('a subject lists units; coming-soon items are announced but cannot be opened', (tester) async {
    final units = [
      const CurriculumNode(id: 'u1', title: 'Cardiovascular Nursing', topicCount: 2),
      const CurriculumNode(id: 'u2', title: 'Respiratory Nursing', availability: 'coming_soon'),
    ];
    final topics = [
      const TopicNode(id: 't1', title: 'Heart Failure', hasContent: true, children: [TopicNode(id: 't2', title: 'Left-Sided Heart Failure')]),
      const TopicNode(id: 't3', title: 'Hypertension', availability: 'coming_soon'),
    ];
    await tester.pumpWidget(_app(const SubjectScreen(subjectId: 's1', title: 'Medical-Surgical Nursing I'), overrides: [
      unitsProvider.overrideWith((ref, id) async => units),
      topicsProvider.overrideWith((ref, id) async => topics),
    ]));
    await tester.pumpAndSettle();
    expect(find.text('2 topics'), findsOneWidget);
    expect(find.text('Coming soon'), findsOneWidget);
    expect(find.byType(ExpansionTile), findsOneWidget, reason: 'a coming-soon unit does not expand');

    await tester.tap(find.text('Cardiovascular Nursing'));
    await tester.pumpAndSettle();
    expect(find.text('Left-Sided Heart Failure'), findsOneWidget);
    expect(find.text('Coming soon'), findsNWidgets(2));
    final tiles = {for (final tile in tester.widgetList<ListTile>(find.byType(ListTile))) ((tile.title as Text).data ?? ''): tile};
    expect(tiles['Heart Failure']!.onTap, isNotNull);
    expect(tiles['Hypertension']!.onTap, isNull);
    expect(tiles['Left-Sided Heart Failure']!.onTap, isNull, reason: 'a heading without content has nothing to open');
  });
}
