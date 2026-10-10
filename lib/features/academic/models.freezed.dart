// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Semester {

 String get id; int get semesterNumber; int get displayOrder; bool get isCurrent;
/// Create a copy of Semester
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SemesterCopyWith<Semester> get copyWith => _$SemesterCopyWithImpl<Semester>(this as Semester, _$identity);

  /// Serializes this Semester to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Semester;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Semester&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.semesterNumber, _this.semesterNumber) || other.semesterNumber == _this.semesterNumber)&&(identical(other.displayOrder, _this.displayOrder) || other.displayOrder == _this.displayOrder)&&(identical(other.isCurrent, _this.isCurrent) || other.isCurrent == _this.isCurrent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Semester;
  return Object.hash(runtimeType,_this.id,_this.semesterNumber,_this.displayOrder,_this.isCurrent);
}

@override
String toString() {
  final _this = this as Semester;
  return 'Semester(id: ${_this.id}, semesterNumber: ${_this.semesterNumber}, displayOrder: ${_this.displayOrder}, isCurrent: ${_this.isCurrent})';
}


}

/// @nodoc
abstract mixin class $SemesterCopyWith<$Res>  {
  factory $SemesterCopyWith(Semester value, $Res Function(Semester) _then) = _$SemesterCopyWithImpl;
@useResult
$Res call({
 String id, int semesterNumber, int displayOrder, bool isCurrent
});




}
/// @nodoc
class _$SemesterCopyWithImpl<$Res>
    implements $SemesterCopyWith<$Res> {
  _$SemesterCopyWithImpl(this._self, this._then);

  final Semester _self;
  final $Res Function(Semester) _then;

/// Create a copy of Semester
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? semesterNumber = null,Object? displayOrder = null,Object? isCurrent = null,}) {
  return _then(Semester(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,semesterNumber: null == semesterNumber ? _self.semesterNumber : semesterNumber // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Semester].
extension SemesterPatterns on Semester {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Semester value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Semester() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Semester value)  $default,){
final _that = this;
switch (_that) {
case _Semester():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Semester value)?  $default,){
final _that = this;
switch (_that) {
case _Semester() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int semesterNumber,  int displayOrder,  bool isCurrent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Semester() when $default != null:
return $default(_that.id,_that.semesterNumber,_that.displayOrder,_that.isCurrent);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int semesterNumber,  int displayOrder,  bool isCurrent)  $default,) {final _that = this;
switch (_that) {
case _Semester():
return $default(_that.id,_that.semesterNumber,_that.displayOrder,_that.isCurrent);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int semesterNumber,  int displayOrder,  bool isCurrent)?  $default,) {final _that = this;
switch (_that) {
case _Semester() when $default != null:
return $default(_that.id,_that.semesterNumber,_that.displayOrder,_that.isCurrent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Semester implements Semester {
  const _Semester({required this.id, required this.semesterNumber, this.displayOrder = 0, this.isCurrent = false});
  factory _Semester.fromJson(Map<String, dynamic> json) => _$SemesterFromJson(json);

@override final  String id;
@override final  int semesterNumber;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool isCurrent;

/// Create a copy of Semester
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SemesterCopyWith<_Semester> get copyWith => __$SemesterCopyWithImpl<_Semester>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SemesterToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Semester&&(identical(other.id, id) || other.id == id)&&(identical(other.semesterNumber, semesterNumber) || other.semesterNumber == semesterNumber)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,semesterNumber,displayOrder,isCurrent);
}

@override
String toString() {
    return 'Semester(id: $id, semesterNumber: $semesterNumber, displayOrder: $displayOrder, isCurrent: $isCurrent)';
}


}

/// @nodoc
abstract mixin class _$SemesterCopyWith<$Res> implements $SemesterCopyWith<$Res> {
  factory _$SemesterCopyWith(_Semester value, $Res Function(_Semester) _then) = __$SemesterCopyWithImpl;
@override @useResult
$Res call({
 String id, int semesterNumber, int displayOrder, bool isCurrent
});




}
/// @nodoc
class __$SemesterCopyWithImpl<$Res>
    implements _$SemesterCopyWith<$Res> {
  __$SemesterCopyWithImpl(this._self, this._then);

  final _Semester _self;
  final $Res Function(_Semester) _then;

/// Create a copy of Semester
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? semesterNumber = null,Object? displayOrder = null,Object? isCurrent = null,}) {
  return _then(_Semester(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,semesterNumber: null == semesterNumber ? _self.semesterNumber : semesterNumber // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CurriculumNode {

 String get id; String get title; String? get code; String? get description; int get displayOrder; String get availability; int? get unitCount; int? get topicCount;
/// Create a copy of CurriculumNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurriculumNodeCopyWith<CurriculumNode> get copyWith => _$CurriculumNodeCopyWithImpl<CurriculumNode>(this as CurriculumNode, _$identity);

  /// Serializes this CurriculumNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CurriculumNode;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurriculumNode&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.displayOrder, _this.displayOrder) || other.displayOrder == _this.displayOrder)&&(identical(other.availability, _this.availability) || other.availability == _this.availability)&&(identical(other.unitCount, _this.unitCount) || other.unitCount == _this.unitCount)&&(identical(other.topicCount, _this.topicCount) || other.topicCount == _this.topicCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CurriculumNode;
  return Object.hash(runtimeType,_this.id,_this.title,_this.code,_this.description,_this.displayOrder,_this.availability,_this.unitCount,_this.topicCount);
}

@override
String toString() {
  final _this = this as CurriculumNode;
  return 'CurriculumNode(id: ${_this.id}, title: ${_this.title}, code: ${_this.code}, description: ${_this.description}, displayOrder: ${_this.displayOrder}, availability: ${_this.availability}, unitCount: ${_this.unitCount}, topicCount: ${_this.topicCount})';
}


}

/// @nodoc
abstract mixin class $CurriculumNodeCopyWith<$Res>  {
  factory $CurriculumNodeCopyWith(CurriculumNode value, $Res Function(CurriculumNode) _then) = _$CurriculumNodeCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? code, String? description, int displayOrder, String availability, int? unitCount, int? topicCount
});




}
/// @nodoc
class _$CurriculumNodeCopyWithImpl<$Res>
    implements $CurriculumNodeCopyWith<$Res> {
  _$CurriculumNodeCopyWithImpl(this._self, this._then);

  final CurriculumNode _self;
  final $Res Function(CurriculumNode) _then;

/// Create a copy of CurriculumNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? description = freezed,Object? displayOrder = null,Object? availability = null,Object? unitCount = freezed,Object? topicCount = freezed,}) {
  return _then(CurriculumNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,unitCount: freezed == unitCount ? _self.unitCount : unitCount // ignore: cast_nullable_to_non_nullable
as int?,topicCount: freezed == topicCount ? _self.topicCount : topicCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurriculumNode].
extension CurriculumNodePatterns on CurriculumNode {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurriculumNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurriculumNode() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurriculumNode value)  $default,){
final _that = this;
switch (_that) {
case _CurriculumNode():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurriculumNode value)?  $default,){
final _that = this;
switch (_that) {
case _CurriculumNode() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? description,  int displayOrder,  String availability,  int? unitCount,  int? topicCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurriculumNode() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.description,_that.displayOrder,_that.availability,_that.unitCount,_that.topicCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? description,  int displayOrder,  String availability,  int? unitCount,  int? topicCount)  $default,) {final _that = this;
switch (_that) {
case _CurriculumNode():
return $default(_that.id,_that.title,_that.code,_that.description,_that.displayOrder,_that.availability,_that.unitCount,_that.topicCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? code,  String? description,  int displayOrder,  String availability,  int? unitCount,  int? topicCount)?  $default,) {final _that = this;
switch (_that) {
case _CurriculumNode() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.description,_that.displayOrder,_that.availability,_that.unitCount,_that.topicCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurriculumNode extends CurriculumNode {
  const _CurriculumNode({required this.id, required this.title, this.code, this.description, this.displayOrder = 0, this.availability = 'available', this.unitCount, this.topicCount}): super._();
  factory _CurriculumNode.fromJson(Map<String, dynamic> json) => _$CurriculumNodeFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? code;
@override final  String? description;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  String availability;
@override final  int? unitCount;
@override final  int? topicCount;

/// Create a copy of CurriculumNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurriculumNodeCopyWith<_CurriculumNode> get copyWith => __$CurriculumNodeCopyWithImpl<_CurriculumNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurriculumNodeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurriculumNode&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.unitCount, unitCount) || other.unitCount == unitCount)&&(identical(other.topicCount, topicCount) || other.topicCount == topicCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,code,description,displayOrder,availability,unitCount,topicCount);
}

@override
String toString() {
    return 'CurriculumNode(id: $id, title: $title, code: $code, description: $description, displayOrder: $displayOrder, availability: $availability, unitCount: $unitCount, topicCount: $topicCount)';
}


}

/// @nodoc
abstract mixin class _$CurriculumNodeCopyWith<$Res> implements $CurriculumNodeCopyWith<$Res> {
  factory _$CurriculumNodeCopyWith(_CurriculumNode value, $Res Function(_CurriculumNode) _then) = __$CurriculumNodeCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? code, String? description, int displayOrder, String availability, int? unitCount, int? topicCount
});




}
/// @nodoc
class __$CurriculumNodeCopyWithImpl<$Res>
    implements _$CurriculumNodeCopyWith<$Res> {
  __$CurriculumNodeCopyWithImpl(this._self, this._then);

  final _CurriculumNode _self;
  final $Res Function(_CurriculumNode) _then;

/// Create a copy of CurriculumNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? description = freezed,Object? displayOrder = null,Object? availability = null,Object? unitCount = freezed,Object? topicCount = freezed,}) {
  return _then(_CurriculumNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,unitCount: freezed == unitCount ? _self.unitCount : unitCount // ignore: cast_nullable_to_non_nullable
as int?,topicCount: freezed == topicCount ? _self.topicCount : topicCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TopicNode {

 String get id; String get title; int get displayOrder; String get availability; bool get hasContent; String? get contentVersionId; List<TopicNode> get children;
/// Create a copy of TopicNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopicNodeCopyWith<TopicNode> get copyWith => _$TopicNodeCopyWithImpl<TopicNode>(this as TopicNode, _$identity);

  /// Serializes this TopicNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TopicNode;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopicNode&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.displayOrder, _this.displayOrder) || other.displayOrder == _this.displayOrder)&&(identical(other.availability, _this.availability) || other.availability == _this.availability)&&(identical(other.hasContent, _this.hasContent) || other.hasContent == _this.hasContent)&&(identical(other.contentVersionId, _this.contentVersionId) || other.contentVersionId == _this.contentVersionId)&&const DeepCollectionEquality().equals(other.children, _this.children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TopicNode;
  return Object.hash(runtimeType,_this.id,_this.title,_this.displayOrder,_this.availability,_this.hasContent,_this.contentVersionId,const DeepCollectionEquality().hash(_this.children));
}

@override
String toString() {
  final _this = this as TopicNode;
  return 'TopicNode(id: ${_this.id}, title: ${_this.title}, displayOrder: ${_this.displayOrder}, availability: ${_this.availability}, hasContent: ${_this.hasContent}, contentVersionId: ${_this.contentVersionId}, children: ${_this.children})';
}


}

/// @nodoc
abstract mixin class $TopicNodeCopyWith<$Res>  {
  factory $TopicNodeCopyWith(TopicNode value, $Res Function(TopicNode) _then) = _$TopicNodeCopyWithImpl;
@useResult
$Res call({
 String id, String title, int displayOrder, String availability, bool hasContent, String? contentVersionId, List<TopicNode> children
});




}
/// @nodoc
class _$TopicNodeCopyWithImpl<$Res>
    implements $TopicNodeCopyWith<$Res> {
  _$TopicNodeCopyWithImpl(this._self, this._then);

  final TopicNode _self;
  final $Res Function(TopicNode) _then;

/// Create a copy of TopicNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? displayOrder = null,Object? availability = null,Object? hasContent = null,Object? contentVersionId = freezed,Object? children = null,}) {
  return _then(TopicNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,hasContent: null == hasContent ? _self.hasContent : hasContent // ignore: cast_nullable_to_non_nullable
as bool,contentVersionId: freezed == contentVersionId ? _self.contentVersionId : contentVersionId // ignore: cast_nullable_to_non_nullable
as String?,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<TopicNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [TopicNode].
extension TopicNodePatterns on TopicNode {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopicNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopicNode() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopicNode value)  $default,){
final _that = this;
switch (_that) {
case _TopicNode():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopicNode value)?  $default,){
final _that = this;
switch (_that) {
case _TopicNode() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int displayOrder,  String availability,  bool hasContent,  String? contentVersionId,  List<TopicNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopicNode() when $default != null:
return $default(_that.id,_that.title,_that.displayOrder,_that.availability,_that.hasContent,_that.contentVersionId,_that.children);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int displayOrder,  String availability,  bool hasContent,  String? contentVersionId,  List<TopicNode> children)  $default,) {final _that = this;
switch (_that) {
case _TopicNode():
return $default(_that.id,_that.title,_that.displayOrder,_that.availability,_that.hasContent,_that.contentVersionId,_that.children);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int displayOrder,  String availability,  bool hasContent,  String? contentVersionId,  List<TopicNode> children)?  $default,) {final _that = this;
switch (_that) {
case _TopicNode() when $default != null:
return $default(_that.id,_that.title,_that.displayOrder,_that.availability,_that.hasContent,_that.contentVersionId,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopicNode extends TopicNode {
  const _TopicNode({required this.id, required this.title, this.displayOrder = 0, this.availability = 'available', this.hasContent = false, this.contentVersionId,  List<TopicNode> children = const <TopicNode>[]}): _children = children,super._();
  factory _TopicNode.fromJson(Map<String, dynamic> json) => _$TopicNodeFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  String availability;
@override@JsonKey() final  bool hasContent;
@override final  String? contentVersionId;
 final  List<TopicNode> _children;
@override@JsonKey() List<TopicNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of TopicNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopicNodeCopyWith<_TopicNode> get copyWith => __$TopicNodeCopyWithImpl<_TopicNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopicNodeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopicNode&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.hasContent, hasContent) || other.hasContent == hasContent)&&(identical(other.contentVersionId, contentVersionId) || other.contentVersionId == contentVersionId)&&const DeepCollectionEquality().equals(other.children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,displayOrder,availability,hasContent,contentVersionId,const DeepCollectionEquality().hash(_children));
}

@override
String toString() {
    return 'TopicNode(id: $id, title: $title, displayOrder: $displayOrder, availability: $availability, hasContent: $hasContent, contentVersionId: $contentVersionId, children: $children)';
}


}

/// @nodoc
abstract mixin class _$TopicNodeCopyWith<$Res> implements $TopicNodeCopyWith<$Res> {
  factory _$TopicNodeCopyWith(_TopicNode value, $Res Function(_TopicNode) _then) = __$TopicNodeCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int displayOrder, String availability, bool hasContent, String? contentVersionId, List<TopicNode> children
});




}
/// @nodoc
class __$TopicNodeCopyWithImpl<$Res>
    implements _$TopicNodeCopyWith<$Res> {
  __$TopicNodeCopyWithImpl(this._self, this._then);

  final _TopicNode _self;
  final $Res Function(_TopicNode) _then;

/// Create a copy of TopicNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? displayOrder = null,Object? availability = null,Object? hasContent = null,Object? contentVersionId = freezed,Object? children = null,}) {
  return _then(_TopicNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,hasContent: null == hasContent ? _self.hasContent : hasContent // ignore: cast_nullable_to_non_nullable
as bool,contentVersionId: freezed == contentVersionId ? _self.contentVersionId : contentVersionId // ignore: cast_nullable_to_non_nullable
as String?,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<TopicNode>,
  ));
}


}

// dart format on
