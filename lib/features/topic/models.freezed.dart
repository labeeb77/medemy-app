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
mixin _$BlockAsset {

 String get id; String get url; String? get altText; String? get mimeType;
/// Create a copy of BlockAsset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockAssetCopyWith<BlockAsset> get copyWith => _$BlockAssetCopyWithImpl<BlockAsset>(this as BlockAsset, _$identity);

  /// Serializes this BlockAsset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BlockAsset;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockAsset&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.altText, _this.altText) || other.altText == _this.altText)&&(identical(other.mimeType, _this.mimeType) || other.mimeType == _this.mimeType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BlockAsset;
  return Object.hash(runtimeType,_this.id,_this.url,_this.altText,_this.mimeType);
}

@override
String toString() {
  final _this = this as BlockAsset;
  return 'BlockAsset(id: ${_this.id}, url: ${_this.url}, altText: ${_this.altText}, mimeType: ${_this.mimeType})';
}


}

/// @nodoc
abstract mixin class $BlockAssetCopyWith<$Res>  {
  factory $BlockAssetCopyWith(BlockAsset value, $Res Function(BlockAsset) _then) = _$BlockAssetCopyWithImpl;
@useResult
$Res call({
 String id, String url, String? altText, String? mimeType
});




}
/// @nodoc
class _$BlockAssetCopyWithImpl<$Res>
    implements $BlockAssetCopyWith<$Res> {
  _$BlockAssetCopyWithImpl(this._self, this._then);

  final BlockAsset _self;
  final $Res Function(BlockAsset) _then;

/// Create a copy of BlockAsset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? altText = freezed,Object? mimeType = freezed,}) {
  return _then(BlockAsset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,altText: freezed == altText ? _self.altText : altText // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockAsset].
extension BlockAssetPatterns on BlockAsset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockAsset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockAsset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockAsset value)  $default,){
final _that = this;
switch (_that) {
case _BlockAsset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockAsset value)?  $default,){
final _that = this;
switch (_that) {
case _BlockAsset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String url,  String? altText,  String? mimeType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockAsset() when $default != null:
return $default(_that.id,_that.url,_that.altText,_that.mimeType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String url,  String? altText,  String? mimeType)  $default,) {final _that = this;
switch (_that) {
case _BlockAsset():
return $default(_that.id,_that.url,_that.altText,_that.mimeType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String url,  String? altText,  String? mimeType)?  $default,) {final _that = this;
switch (_that) {
case _BlockAsset() when $default != null:
return $default(_that.id,_that.url,_that.altText,_that.mimeType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockAsset implements BlockAsset {
  const _BlockAsset({required this.id, required this.url, this.altText, this.mimeType});
  factory _BlockAsset.fromJson(Map<String, dynamic> json) => _$BlockAssetFromJson(json);

@override final  String id;
@override final  String url;
@override final  String? altText;
@override final  String? mimeType;

/// Create a copy of BlockAsset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockAssetCopyWith<_BlockAsset> get copyWith => __$BlockAssetCopyWithImpl<_BlockAsset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockAssetToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.altText, altText) || other.altText == altText)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,url,altText,mimeType);
}

@override
String toString() {
    return 'BlockAsset(id: $id, url: $url, altText: $altText, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class _$BlockAssetCopyWith<$Res> implements $BlockAssetCopyWith<$Res> {
  factory _$BlockAssetCopyWith(_BlockAsset value, $Res Function(_BlockAsset) _then) = __$BlockAssetCopyWithImpl;
@override @useResult
$Res call({
 String id, String url, String? altText, String? mimeType
});




}
/// @nodoc
class __$BlockAssetCopyWithImpl<$Res>
    implements _$BlockAssetCopyWith<$Res> {
  __$BlockAssetCopyWithImpl(this._self, this._then);

  final _BlockAsset _self;
  final $Res Function(_BlockAsset) _then;

/// Create a copy of BlockAsset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? altText = freezed,Object? mimeType = freezed,}) {
  return _then(_BlockAsset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,altText: freezed == altText ? _self.altText : altText // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Citation {

 String get resourceTitle; int? get resourceVersion; int? get pageFrom; int? get pageTo; String? get section;
/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CitationCopyWith<Citation> get copyWith => _$CitationCopyWithImpl<Citation>(this as Citation, _$identity);

  /// Serializes this Citation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Citation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Citation&&(identical(other.resourceTitle, _this.resourceTitle) || other.resourceTitle == _this.resourceTitle)&&(identical(other.resourceVersion, _this.resourceVersion) || other.resourceVersion == _this.resourceVersion)&&(identical(other.pageFrom, _this.pageFrom) || other.pageFrom == _this.pageFrom)&&(identical(other.pageTo, _this.pageTo) || other.pageTo == _this.pageTo)&&(identical(other.section, _this.section) || other.section == _this.section));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Citation;
  return Object.hash(runtimeType,_this.resourceTitle,_this.resourceVersion,_this.pageFrom,_this.pageTo,_this.section);
}

@override
String toString() {
  final _this = this as Citation;
  return 'Citation(resourceTitle: ${_this.resourceTitle}, resourceVersion: ${_this.resourceVersion}, pageFrom: ${_this.pageFrom}, pageTo: ${_this.pageTo}, section: ${_this.section})';
}


}

/// @nodoc
abstract mixin class $CitationCopyWith<$Res>  {
  factory $CitationCopyWith(Citation value, $Res Function(Citation) _then) = _$CitationCopyWithImpl;
@useResult
$Res call({
 String resourceTitle, int? resourceVersion, int? pageFrom, int? pageTo, String? section
});




}
/// @nodoc
class _$CitationCopyWithImpl<$Res>
    implements $CitationCopyWith<$Res> {
  _$CitationCopyWithImpl(this._self, this._then);

  final Citation _self;
  final $Res Function(Citation) _then;

/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? resourceTitle = null,Object? resourceVersion = freezed,Object? pageFrom = freezed,Object? pageTo = freezed,Object? section = freezed,}) {
  return _then(Citation(
resourceTitle: null == resourceTitle ? _self.resourceTitle : resourceTitle // ignore: cast_nullable_to_non_nullable
as String,resourceVersion: freezed == resourceVersion ? _self.resourceVersion : resourceVersion // ignore: cast_nullable_to_non_nullable
as int?,pageFrom: freezed == pageFrom ? _self.pageFrom : pageFrom // ignore: cast_nullable_to_non_nullable
as int?,pageTo: freezed == pageTo ? _self.pageTo : pageTo // ignore: cast_nullable_to_non_nullable
as int?,section: freezed == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Citation].
extension CitationPatterns on Citation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Citation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Citation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Citation value)  $default,){
final _that = this;
switch (_that) {
case _Citation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Citation value)?  $default,){
final _that = this;
switch (_that) {
case _Citation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String resourceTitle,  int? resourceVersion,  int? pageFrom,  int? pageTo,  String? section)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Citation() when $default != null:
return $default(_that.resourceTitle,_that.resourceVersion,_that.pageFrom,_that.pageTo,_that.section);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String resourceTitle,  int? resourceVersion,  int? pageFrom,  int? pageTo,  String? section)  $default,) {final _that = this;
switch (_that) {
case _Citation():
return $default(_that.resourceTitle,_that.resourceVersion,_that.pageFrom,_that.pageTo,_that.section);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String resourceTitle,  int? resourceVersion,  int? pageFrom,  int? pageTo,  String? section)?  $default,) {final _that = this;
switch (_that) {
case _Citation() when $default != null:
return $default(_that.resourceTitle,_that.resourceVersion,_that.pageFrom,_that.pageTo,_that.section);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Citation implements Citation {
  const _Citation({required this.resourceTitle, this.resourceVersion, this.pageFrom, this.pageTo, this.section});
  factory _Citation.fromJson(Map<String, dynamic> json) => _$CitationFromJson(json);

@override final  String resourceTitle;
@override final  int? resourceVersion;
@override final  int? pageFrom;
@override final  int? pageTo;
@override final  String? section;

/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CitationCopyWith<_Citation> get copyWith => __$CitationCopyWithImpl<_Citation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CitationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Citation&&(identical(other.resourceTitle, resourceTitle) || other.resourceTitle == resourceTitle)&&(identical(other.resourceVersion, resourceVersion) || other.resourceVersion == resourceVersion)&&(identical(other.pageFrom, pageFrom) || other.pageFrom == pageFrom)&&(identical(other.pageTo, pageTo) || other.pageTo == pageTo)&&(identical(other.section, section) || other.section == section));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,resourceTitle,resourceVersion,pageFrom,pageTo,section);
}

@override
String toString() {
    return 'Citation(resourceTitle: $resourceTitle, resourceVersion: $resourceVersion, pageFrom: $pageFrom, pageTo: $pageTo, section: $section)';
}


}

/// @nodoc
abstract mixin class _$CitationCopyWith<$Res> implements $CitationCopyWith<$Res> {
  factory _$CitationCopyWith(_Citation value, $Res Function(_Citation) _then) = __$CitationCopyWithImpl;
@override @useResult
$Res call({
 String resourceTitle, int? resourceVersion, int? pageFrom, int? pageTo, String? section
});




}
/// @nodoc
class __$CitationCopyWithImpl<$Res>
    implements _$CitationCopyWith<$Res> {
  __$CitationCopyWithImpl(this._self, this._then);

  final _Citation _self;
  final $Res Function(_Citation) _then;

/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? resourceTitle = null,Object? resourceVersion = freezed,Object? pageFrom = freezed,Object? pageTo = freezed,Object? section = freezed,}) {
  return _then(_Citation(
resourceTitle: null == resourceTitle ? _self.resourceTitle : resourceTitle // ignore: cast_nullable_to_non_nullable
as String,resourceVersion: freezed == resourceVersion ? _self.resourceVersion : resourceVersion // ignore: cast_nullable_to_non_nullable
as int?,pageFrom: freezed == pageFrom ? _self.pageFrom : pageFrom // ignore: cast_nullable_to_non_nullable
as int?,pageTo: freezed == pageTo ? _self.pageTo : pageTo // ignore: cast_nullable_to_non_nullable
as int?,section: freezed == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ContentBlock {

 String get id; String get mode; String get type; String get rendererKey; int get schemaVersion; String? get title; Map<String, dynamic> get payload; List<BlockAsset> get assets; List<Citation> get citations;
/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentBlockCopyWith<ContentBlock> get copyWith => _$ContentBlockCopyWithImpl<ContentBlock>(this as ContentBlock, _$identity);

  /// Serializes this ContentBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentBlock;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentBlock&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.rendererKey, _this.rendererKey) || other.rendererKey == _this.rendererKey)&&(identical(other.schemaVersion, _this.schemaVersion) || other.schemaVersion == _this.schemaVersion)&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.payload, _this.payload)&&const DeepCollectionEquality().equals(other.assets, _this.assets)&&const DeepCollectionEquality().equals(other.citations, _this.citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentBlock;
  return Object.hash(runtimeType,_this.id,_this.mode,_this.type,_this.rendererKey,_this.schemaVersion,_this.title,const DeepCollectionEquality().hash(_this.payload),const DeepCollectionEquality().hash(_this.assets),const DeepCollectionEquality().hash(_this.citations));
}

@override
String toString() {
  final _this = this as ContentBlock;
  return 'ContentBlock(id: ${_this.id}, mode: ${_this.mode}, type: ${_this.type}, rendererKey: ${_this.rendererKey}, schemaVersion: ${_this.schemaVersion}, title: ${_this.title}, payload: ${_this.payload}, assets: ${_this.assets}, citations: ${_this.citations})';
}


}

/// @nodoc
abstract mixin class $ContentBlockCopyWith<$Res>  {
  factory $ContentBlockCopyWith(ContentBlock value, $Res Function(ContentBlock) _then) = _$ContentBlockCopyWithImpl;
@useResult
$Res call({
 String id, String mode, String type, String rendererKey, int schemaVersion, String? title, Map<String, dynamic> payload, List<BlockAsset> assets, List<Citation> citations
});




}
/// @nodoc
class _$ContentBlockCopyWithImpl<$Res>
    implements $ContentBlockCopyWith<$Res> {
  _$ContentBlockCopyWithImpl(this._self, this._then);

  final ContentBlock _self;
  final $Res Function(ContentBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mode = null,Object? type = null,Object? rendererKey = null,Object? schemaVersion = null,Object? title = freezed,Object? payload = null,Object? assets = null,Object? citations = null,}) {
  return _then(ContentBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,rendererKey: null == rendererKey ? _self.rendererKey : rendererKey // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as List<BlockAsset>,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentBlock].
extension ContentBlockPatterns on ContentBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentBlock value)  $default,){
final _that = this;
switch (_that) {
case _ContentBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentBlock value)?  $default,){
final _that = this;
switch (_that) {
case _ContentBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mode,  String type,  String rendererKey,  int schemaVersion,  String? title,  Map<String, dynamic> payload,  List<BlockAsset> assets,  List<Citation> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentBlock() when $default != null:
return $default(_that.id,_that.mode,_that.type,_that.rendererKey,_that.schemaVersion,_that.title,_that.payload,_that.assets,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mode,  String type,  String rendererKey,  int schemaVersion,  String? title,  Map<String, dynamic> payload,  List<BlockAsset> assets,  List<Citation> citations)  $default,) {final _that = this;
switch (_that) {
case _ContentBlock():
return $default(_that.id,_that.mode,_that.type,_that.rendererKey,_that.schemaVersion,_that.title,_that.payload,_that.assets,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mode,  String type,  String rendererKey,  int schemaVersion,  String? title,  Map<String, dynamic> payload,  List<BlockAsset> assets,  List<Citation> citations)?  $default,) {final _that = this;
switch (_that) {
case _ContentBlock() when $default != null:
return $default(_that.id,_that.mode,_that.type,_that.rendererKey,_that.schemaVersion,_that.title,_that.payload,_that.assets,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentBlock implements ContentBlock {
  const _ContentBlock({required this.id, required this.mode, required this.type, required this.rendererKey, this.schemaVersion = 1, this.title,  Map<String, dynamic> payload = const <String, dynamic>{},  List<BlockAsset> assets = const <BlockAsset>[],  List<Citation> citations = const <Citation>[]}): _payload = payload,_assets = assets,_citations = citations;
  factory _ContentBlock.fromJson(Map<String, dynamic> json) => _$ContentBlockFromJson(json);

@override final  String id;
@override final  String mode;
@override final  String type;
@override final  String rendererKey;
@override@JsonKey() final  int schemaVersion;
@override final  String? title;
 final  Map<String, dynamic> _payload;
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

 final  List<BlockAsset> _assets;
@override@JsonKey() List<BlockAsset> get assets {
  if (_assets is EqualUnmodifiableListView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assets);
}

 final  List<Citation> _citations;
@override@JsonKey() List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentBlockCopyWith<_ContentBlock> get copyWith => __$ContentBlockCopyWithImpl<_ContentBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentBlockToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.type, type) || other.type == type)&&(identical(other.rendererKey, rendererKey) || other.rendererKey == rendererKey)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.payload, _payload)&&const DeepCollectionEquality().equals(other.assets, _assets)&&const DeepCollectionEquality().equals(other.citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,mode,type,rendererKey,schemaVersion,title,const DeepCollectionEquality().hash(_payload),const DeepCollectionEquality().hash(_assets),const DeepCollectionEquality().hash(_citations));
}

@override
String toString() {
    return 'ContentBlock(id: $id, mode: $mode, type: $type, rendererKey: $rendererKey, schemaVersion: $schemaVersion, title: $title, payload: $payload, assets: $assets, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$ContentBlockCopyWith<$Res> implements $ContentBlockCopyWith<$Res> {
  factory _$ContentBlockCopyWith(_ContentBlock value, $Res Function(_ContentBlock) _then) = __$ContentBlockCopyWithImpl;
@override @useResult
$Res call({
 String id, String mode, String type, String rendererKey, int schemaVersion, String? title, Map<String, dynamic> payload, List<BlockAsset> assets, List<Citation> citations
});




}
/// @nodoc
class __$ContentBlockCopyWithImpl<$Res>
    implements _$ContentBlockCopyWith<$Res> {
  __$ContentBlockCopyWithImpl(this._self, this._then);

  final _ContentBlock _self;
  final $Res Function(_ContentBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mode = null,Object? type = null,Object? rendererKey = null,Object? schemaVersion = null,Object? title = freezed,Object? payload = null,Object? assets = null,Object? citations = null,}) {
  return _then(_ContentBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,rendererKey: null == rendererKey ? _self.rendererKey : rendererKey // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as List<BlockAsset>,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}


}


/// @nodoc
mixin _$TopicContent {

 String get contentVersionId; String get topicPlacementId; String get title; int get versionNumber; String? get mode; List<ContentBlock> get blocks;
/// Create a copy of TopicContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopicContentCopyWith<TopicContent> get copyWith => _$TopicContentCopyWithImpl<TopicContent>(this as TopicContent, _$identity);

  /// Serializes this TopicContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TopicContent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopicContent&&(identical(other.contentVersionId, _this.contentVersionId) || other.contentVersionId == _this.contentVersionId)&&(identical(other.topicPlacementId, _this.topicPlacementId) || other.topicPlacementId == _this.topicPlacementId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.versionNumber, _this.versionNumber) || other.versionNumber == _this.versionNumber)&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&const DeepCollectionEquality().equals(other.blocks, _this.blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TopicContent;
  return Object.hash(runtimeType,_this.contentVersionId,_this.topicPlacementId,_this.title,_this.versionNumber,_this.mode,const DeepCollectionEquality().hash(_this.blocks));
}

@override
String toString() {
  final _this = this as TopicContent;
  return 'TopicContent(contentVersionId: ${_this.contentVersionId}, topicPlacementId: ${_this.topicPlacementId}, title: ${_this.title}, versionNumber: ${_this.versionNumber}, mode: ${_this.mode}, blocks: ${_this.blocks})';
}


}

/// @nodoc
abstract mixin class $TopicContentCopyWith<$Res>  {
  factory $TopicContentCopyWith(TopicContent value, $Res Function(TopicContent) _then) = _$TopicContentCopyWithImpl;
@useResult
$Res call({
 String contentVersionId, String topicPlacementId, String title, int versionNumber, String? mode, List<ContentBlock> blocks
});




}
/// @nodoc
class _$TopicContentCopyWithImpl<$Res>
    implements $TopicContentCopyWith<$Res> {
  _$TopicContentCopyWithImpl(this._self, this._then);

  final TopicContent _self;
  final $Res Function(TopicContent) _then;

/// Create a copy of TopicContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentVersionId = null,Object? topicPlacementId = null,Object? title = null,Object? versionNumber = null,Object? mode = freezed,Object? blocks = null,}) {
  return _then(TopicContent(
contentVersionId: null == contentVersionId ? _self.contentVersionId : contentVersionId // ignore: cast_nullable_to_non_nullable
as String,topicPlacementId: null == topicPlacementId ? _self.topicPlacementId : topicPlacementId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,versionNumber: null == versionNumber ? _self.versionNumber : versionNumber // ignore: cast_nullable_to_non_nullable
as int,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [TopicContent].
extension TopicContentPatterns on TopicContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopicContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopicContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopicContent value)  $default,){
final _that = this;
switch (_that) {
case _TopicContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopicContent value)?  $default,){
final _that = this;
switch (_that) {
case _TopicContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String contentVersionId,  String topicPlacementId,  String title,  int versionNumber,  String? mode,  List<ContentBlock> blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopicContent() when $default != null:
return $default(_that.contentVersionId,_that.topicPlacementId,_that.title,_that.versionNumber,_that.mode,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String contentVersionId,  String topicPlacementId,  String title,  int versionNumber,  String? mode,  List<ContentBlock> blocks)  $default,) {final _that = this;
switch (_that) {
case _TopicContent():
return $default(_that.contentVersionId,_that.topicPlacementId,_that.title,_that.versionNumber,_that.mode,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String contentVersionId,  String topicPlacementId,  String title,  int versionNumber,  String? mode,  List<ContentBlock> blocks)?  $default,) {final _that = this;
switch (_that) {
case _TopicContent() when $default != null:
return $default(_that.contentVersionId,_that.topicPlacementId,_that.title,_that.versionNumber,_that.mode,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopicContent implements TopicContent {
  const _TopicContent({required this.contentVersionId, required this.topicPlacementId, required this.title, this.versionNumber = 1, this.mode,  List<ContentBlock> blocks = const <ContentBlock>[]}): _blocks = blocks;
  factory _TopicContent.fromJson(Map<String, dynamic> json) => _$TopicContentFromJson(json);

@override final  String contentVersionId;
@override final  String topicPlacementId;
@override final  String title;
@override@JsonKey() final  int versionNumber;
@override final  String? mode;
 final  List<ContentBlock> _blocks;
@override@JsonKey() List<ContentBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}


/// Create a copy of TopicContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopicContentCopyWith<_TopicContent> get copyWith => __$TopicContentCopyWithImpl<_TopicContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopicContentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopicContent&&(identical(other.contentVersionId, contentVersionId) || other.contentVersionId == contentVersionId)&&(identical(other.topicPlacementId, topicPlacementId) || other.topicPlacementId == topicPlacementId)&&(identical(other.title, title) || other.title == title)&&(identical(other.versionNumber, versionNumber) || other.versionNumber == versionNumber)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.blocks, _blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,contentVersionId,topicPlacementId,title,versionNumber,mode,const DeepCollectionEquality().hash(_blocks));
}

@override
String toString() {
    return 'TopicContent(contentVersionId: $contentVersionId, topicPlacementId: $topicPlacementId, title: $title, versionNumber: $versionNumber, mode: $mode, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$TopicContentCopyWith<$Res> implements $TopicContentCopyWith<$Res> {
  factory _$TopicContentCopyWith(_TopicContent value, $Res Function(_TopicContent) _then) = __$TopicContentCopyWithImpl;
@override @useResult
$Res call({
 String contentVersionId, String topicPlacementId, String title, int versionNumber, String? mode, List<ContentBlock> blocks
});




}
/// @nodoc
class __$TopicContentCopyWithImpl<$Res>
    implements _$TopicContentCopyWith<$Res> {
  __$TopicContentCopyWithImpl(this._self, this._then);

  final _TopicContent _self;
  final $Res Function(_TopicContent) _then;

/// Create a copy of TopicContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentVersionId = null,Object? topicPlacementId = null,Object? title = null,Object? versionNumber = null,Object? mode = freezed,Object? blocks = null,}) {
  return _then(_TopicContent(
contentVersionId: null == contentVersionId ? _self.contentVersionId : contentVersionId // ignore: cast_nullable_to_non_nullable
as String,topicPlacementId: null == topicPlacementId ? _self.topicPlacementId : topicPlacementId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,versionNumber: null == versionNumber ? _self.versionNumber : versionNumber // ignore: cast_nullable_to_non_nullable
as int,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,
  ));
}


}

// dart format on
