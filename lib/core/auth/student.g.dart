// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentProfile _$StudentProfileFromJson(Map<String, dynamic> json) =>
    _StudentProfile(
      displayName: json['displayName'] as String,
      currentSemesterId: json['currentSemesterId'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$StudentProfileToJson(_StudentProfile instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'currentSemesterId': instance.currentSemesterId,
      'avatarUrl': instance.avatarUrl,
    };

_Student _$StudentFromJson(Map<String, dynamic> json) => _Student(
  id: json['id'] as String,
  email: json['email'] as String,
  roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  profile: json['profile'] == null
      ? null
      : StudentProfile.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StudentToJson(_Student instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'roles': instance.roles,
  'profile': instance.profile,
};
