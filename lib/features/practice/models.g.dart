// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PracticeOption _$PracticeOptionFromJson(Map<String, dynamic> json) =>
    _PracticeOption(
      optionKey: json['optionKey'] as String,
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool?,
      rationale: json['rationale'] as String?,
    );

Map<String, dynamic> _$PracticeOptionToJson(_PracticeOption instance) =>
    <String, dynamic>{
      'optionKey': instance.optionKey,
      'text': instance.text,
      'isCorrect': instance.isCorrect,
      'rationale': instance.rationale,
    };

_PracticeAttempt _$PracticeAttemptFromJson(Map<String, dynamic> json) =>
    _PracticeAttempt(
      selectedOptionKey: json['selectedOptionKey'] as String,
      isCorrect: json['isCorrect'] as bool,
      correctOptionKey: json['correctOptionKey'] as String?,
      rationale: json['rationale'] as String?,
      keyConcept: json['keyConcept'] as String?,
    );

Map<String, dynamic> _$PracticeAttemptToJson(_PracticeAttempt instance) =>
    <String, dynamic>{
      'selectedOptionKey': instance.selectedOptionKey,
      'isCorrect': instance.isCorrect,
      'correctOptionKey': instance.correctOptionKey,
      'rationale': instance.rationale,
      'keyConcept': instance.keyConcept,
    };

_PracticeItem _$PracticeItemFromJson(Map<String, dynamic> json) =>
    _PracticeItem(
      id: json['id'] as String,
      displayOrder: (json['displayOrder'] as num).toInt(),
      stem: json['stem'] as String,
      questionType: json['questionType'] as String? ?? '',
      difficulty: json['difficulty'] as String? ?? '',
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => PracticeOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PracticeOption>[],
      attempt: json['attempt'] == null
          ? null
          : PracticeAttempt.fromJson(json['attempt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PracticeItemToJson(_PracticeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayOrder': instance.displayOrder,
      'stem': instance.stem,
      'questionType': instance.questionType,
      'difficulty': instance.difficulty,
      'options': instance.options,
      'attempt': instance.attempt,
    };

_PracticeSession _$PracticeSessionFromJson(Map<String, dynamic> json) =>
    _PracticeSession(
      id: json['id'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      correctCount: (json['correctCount'] as num?)?.toInt() ?? 0,
      scorePercentage: (json['scorePercentage'] as num?)?.toDouble(),
      answeredCount: (json['answeredCount'] as num?)?.toInt(),
      requestedQuestionCount: (json['requestedQuestionCount'] as num?)?.toInt(),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => PracticeItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PracticeItem>[],
    );

Map<String, dynamic> _$PracticeSessionToJson(_PracticeSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'status': instance.status,
      'totalQuestions': instance.totalQuestions,
      'correctCount': instance.correctCount,
      'scorePercentage': instance.scorePercentage,
      'answeredCount': instance.answeredCount,
      'requestedQuestionCount': instance.requestedQuestionCount,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'items': instance.items,
    };
