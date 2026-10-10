import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
abstract class Semester with _$Semester {
  const factory Semester({required String id, required int semesterNumber, @Default(0) int displayOrder, @Default(false) bool isCurrent}) = _Semester;
  factory Semester.fromJson(Map<String, dynamic> json) => _$SemesterFromJson(json);
}

/// A subject or a unit: both are listed the same way.
@freezed
abstract class CurriculumNode with _$CurriculumNode {
  const CurriculumNode._();
  const factory CurriculumNode({required String id, required String title, String? code, String? description,
    @Default(0) int displayOrder, @Default('available') String availability, int? unitCount, int? topicCount}) = _CurriculumNode;
  factory CurriculumNode.fromJson(Map<String, dynamic> json) => _$CurriculumNodeFromJson(json);

  /// Listed so it can be announced, but not openable.
  bool get comingSoon => availability == 'coming_soon';
}

@freezed
abstract class TopicNode with _$TopicNode {
  const TopicNode._();
  const factory TopicNode({required String id, required String title, @Default(0) int displayOrder, @Default('available') String availability,
    @Default(false) bool hasContent, String? contentVersionId, @Default(<TopicNode>[]) List<TopicNode> children}) = _TopicNode;
  factory TopicNode.fromJson(Map<String, dynamic> json) => _$TopicNodeFromJson(json);

  bool get comingSoon => availability == 'coming_soon';
}
