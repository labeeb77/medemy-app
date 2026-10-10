// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Semester _$SemesterFromJson(Map<String, dynamic> json) => _Semester(
  id: json['id'] as String,
  semesterNumber: (json['semesterNumber'] as num).toInt(),
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  isCurrent: json['isCurrent'] as bool? ?? false,
);

Map<String, dynamic> _$SemesterToJson(_Semester instance) => <String, dynamic>{
  'id': instance.id,
  'semesterNumber': instance.semesterNumber,
  'displayOrder': instance.displayOrder,
  'isCurrent': instance.isCurrent,
};

_CurriculumNode _$CurriculumNodeFromJson(Map<String, dynamic> json) =>
    _CurriculumNode(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String?,
      description: json['description'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      availability: json['availability'] as String? ?? 'available',
      unitCount: (json['unitCount'] as num?)?.toInt(),
      topicCount: (json['topicCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurriculumNodeToJson(_CurriculumNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'code': instance.code,
      'description': instance.description,
      'displayOrder': instance.displayOrder,
      'availability': instance.availability,
      'unitCount': instance.unitCount,
      'topicCount': instance.topicCount,
    };

_TopicNode _$TopicNodeFromJson(Map<String, dynamic> json) => _TopicNode(
  id: json['id'] as String,
  title: json['title'] as String,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  availability: json['availability'] as String? ?? 'available',
  hasContent: json['hasContent'] as bool? ?? false,
  contentVersionId: json['contentVersionId'] as String?,
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => TopicNode.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TopicNode>[],
);

Map<String, dynamic> _$TopicNodeToJson(_TopicNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'displayOrder': instance.displayOrder,
      'availability': instance.availability,
      'hasContent': instance.hasContent,
      'contentVersionId': instance.contentVersionId,
      'children': instance.children,
    };
