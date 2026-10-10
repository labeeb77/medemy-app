import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

/// The seven practice categories of the contract. Topic and unit practice start from a topic or a unit.
enum PracticeCategory {
  topic('topic', 'Topic', 'Questions from one topic.', Icons.article_outlined, needsContext: true),
  unit('unit', 'Unit', 'Questions across a unit.', Icons.folder_outlined, needsContext: true),
  facultyPick('faculty_pick', 'Faculty Picks', 'Questions your faculty marked as essential.', Icons.workspace_premium_outlined),
  highYield('high_yield', 'High-Yield', 'Questions most relevant to exams.', Icons.star_outline_rounded),
  weakArea('weak_area', 'Weak Areas', 'Topics with at least 5 attempts and under 50% accuracy.', Icons.trending_down_rounded),
  previouslyIncorrect('previously_incorrect', 'Previously Incorrect', 'Questions you last answered wrongly.', Icons.replay_outlined),
  bookmarked('bookmarked', 'Bookmarked', 'Questions you saved.', Icons.bookmark_outline_rounded);

  const PracticeCategory(this.apiValue, this.label, this.description, this.icon, {this.needsContext = false});
  final String apiValue;
  final String label;
  final String description;
  final IconData icon;
  final bool needsContext;

  static PracticeCategory fromApi(String? value) => PracticeCategory.values.firstWhere((category) => category.apiValue == value, orElse: () => PracticeCategory.topic);
}

@freezed
abstract class PracticeOption with _$PracticeOption {
  /// [isCorrect] and [rationale] are absent until the question has been answered.
  const factory PracticeOption({required String optionKey, required String text, bool? isCorrect, String? rationale}) = _PracticeOption;
  factory PracticeOption.fromJson(Map<String, dynamic> json) => _$PracticeOptionFromJson(json);
}

@freezed
abstract class PracticeAttempt with _$PracticeAttempt {
  const factory PracticeAttempt({required String selectedOptionKey, required bool isCorrect, String? correctOptionKey, String? rationale, String? keyConcept}) = _PracticeAttempt;
  factory PracticeAttempt.fromJson(Map<String, dynamic> json) => _$PracticeAttemptFromJson(json);
}

@freezed
abstract class PracticeItem with _$PracticeItem {
  const factory PracticeItem({required String id, required int displayOrder, required String stem, @Default('') String questionType,
    @Default('') String difficulty, @Default(<PracticeOption>[]) List<PracticeOption> options, PracticeAttempt? attempt}) = _PracticeItem;
  factory PracticeItem.fromJson(Map<String, dynamic> json) => _$PracticeItemFromJson(json);
}

@freezed
abstract class PracticeSession with _$PracticeSession {
  const PracticeSession._();
  const factory PracticeSession({required String id, required String category, required String status, required int totalQuestions,
    @Default(0) int correctCount, double? scorePercentage, int? answeredCount, int? requestedQuestionCount, DateTime? startedAt, DateTime? completedAt,
    @Default(<PracticeItem>[]) List<PracticeItem> items}) = _PracticeSession;
  factory PracticeSession.fromJson(Map<String, dynamic> json) => _$PracticeSessionFromJson(json);

  bool get isCompleted => status == 'completed';
  int get answered => items.isEmpty ? (answeredCount ?? 0) : items.where((item) => item.attempt != null).length;
  int get correct => items.isEmpty ? correctCount : items.where((item) => item.attempt?.isCorrect == true).length;
  int get incorrect => answered - correct;
  int get unanswered => totalQuestions - answered;
  /// Position of the first question still to answer, or null when all are answered.
  int? get nextUnanswered {
    final index = items.indexWhere((item) => item.attempt == null);
    return index < 0 ? null : index;
  }
}
