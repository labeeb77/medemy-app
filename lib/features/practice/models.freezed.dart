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
mixin _$PracticeOption {

 String get optionKey; String get text; bool? get isCorrect; String? get rationale;
/// Create a copy of PracticeOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeOptionCopyWith<PracticeOption> get copyWith => _$PracticeOptionCopyWithImpl<PracticeOption>(this as PracticeOption, _$identity);

  /// Serializes this PracticeOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PracticeOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeOption&&(identical(other.optionKey, _this.optionKey) || other.optionKey == _this.optionKey)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.isCorrect, _this.isCorrect) || other.isCorrect == _this.isCorrect)&&(identical(other.rationale, _this.rationale) || other.rationale == _this.rationale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PracticeOption;
  return Object.hash(runtimeType,_this.optionKey,_this.text,_this.isCorrect,_this.rationale);
}

@override
String toString() {
  final _this = this as PracticeOption;
  return 'PracticeOption(optionKey: ${_this.optionKey}, text: ${_this.text}, isCorrect: ${_this.isCorrect}, rationale: ${_this.rationale})';
}


}

/// @nodoc
abstract mixin class $PracticeOptionCopyWith<$Res>  {
  factory $PracticeOptionCopyWith(PracticeOption value, $Res Function(PracticeOption) _then) = _$PracticeOptionCopyWithImpl;
@useResult
$Res call({
 String optionKey, String text, bool? isCorrect, String? rationale
});




}
/// @nodoc
class _$PracticeOptionCopyWithImpl<$Res>
    implements $PracticeOptionCopyWith<$Res> {
  _$PracticeOptionCopyWithImpl(this._self, this._then);

  final PracticeOption _self;
  final $Res Function(PracticeOption) _then;

/// Create a copy of PracticeOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionKey = null,Object? text = null,Object? isCorrect = freezed,Object? rationale = freezed,}) {
  return _then(PracticeOption(
optionKey: null == optionKey ? _self.optionKey : optionKey // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isCorrect: freezed == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool?,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeOption].
extension PracticeOptionPatterns on PracticeOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeOption value)  $default,){
final _that = this;
switch (_that) {
case _PracticeOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeOption value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String optionKey,  String text,  bool? isCorrect,  String? rationale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeOption() when $default != null:
return $default(_that.optionKey,_that.text,_that.isCorrect,_that.rationale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String optionKey,  String text,  bool? isCorrect,  String? rationale)  $default,) {final _that = this;
switch (_that) {
case _PracticeOption():
return $default(_that.optionKey,_that.text,_that.isCorrect,_that.rationale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String optionKey,  String text,  bool? isCorrect,  String? rationale)?  $default,) {final _that = this;
switch (_that) {
case _PracticeOption() when $default != null:
return $default(_that.optionKey,_that.text,_that.isCorrect,_that.rationale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeOption implements PracticeOption {
  const _PracticeOption({required this.optionKey, required this.text, this.isCorrect, this.rationale});
  factory _PracticeOption.fromJson(Map<String, dynamic> json) => _$PracticeOptionFromJson(json);

@override final  String optionKey;
@override final  String text;
@override final  bool? isCorrect;
@override final  String? rationale;

/// Create a copy of PracticeOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeOptionCopyWith<_PracticeOption> get copyWith => __$PracticeOptionCopyWithImpl<_PracticeOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeOptionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeOption&&(identical(other.optionKey, optionKey) || other.optionKey == optionKey)&&(identical(other.text, text) || other.text == text)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.rationale, rationale) || other.rationale == rationale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,optionKey,text,isCorrect,rationale);
}

@override
String toString() {
    return 'PracticeOption(optionKey: $optionKey, text: $text, isCorrect: $isCorrect, rationale: $rationale)';
}


}

/// @nodoc
abstract mixin class _$PracticeOptionCopyWith<$Res> implements $PracticeOptionCopyWith<$Res> {
  factory _$PracticeOptionCopyWith(_PracticeOption value, $Res Function(_PracticeOption) _then) = __$PracticeOptionCopyWithImpl;
@override @useResult
$Res call({
 String optionKey, String text, bool? isCorrect, String? rationale
});




}
/// @nodoc
class __$PracticeOptionCopyWithImpl<$Res>
    implements _$PracticeOptionCopyWith<$Res> {
  __$PracticeOptionCopyWithImpl(this._self, this._then);

  final _PracticeOption _self;
  final $Res Function(_PracticeOption) _then;

/// Create a copy of PracticeOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionKey = null,Object? text = null,Object? isCorrect = freezed,Object? rationale = freezed,}) {
  return _then(_PracticeOption(
optionKey: null == optionKey ? _self.optionKey : optionKey // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isCorrect: freezed == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool?,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PracticeAttempt {

 String get selectedOptionKey; bool get isCorrect; String? get correctOptionKey; String? get rationale; String? get keyConcept;
/// Create a copy of PracticeAttempt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeAttemptCopyWith<PracticeAttempt> get copyWith => _$PracticeAttemptCopyWithImpl<PracticeAttempt>(this as PracticeAttempt, _$identity);

  /// Serializes this PracticeAttempt to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PracticeAttempt;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeAttempt&&(identical(other.selectedOptionKey, _this.selectedOptionKey) || other.selectedOptionKey == _this.selectedOptionKey)&&(identical(other.isCorrect, _this.isCorrect) || other.isCorrect == _this.isCorrect)&&(identical(other.correctOptionKey, _this.correctOptionKey) || other.correctOptionKey == _this.correctOptionKey)&&(identical(other.rationale, _this.rationale) || other.rationale == _this.rationale)&&(identical(other.keyConcept, _this.keyConcept) || other.keyConcept == _this.keyConcept));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PracticeAttempt;
  return Object.hash(runtimeType,_this.selectedOptionKey,_this.isCorrect,_this.correctOptionKey,_this.rationale,_this.keyConcept);
}

@override
String toString() {
  final _this = this as PracticeAttempt;
  return 'PracticeAttempt(selectedOptionKey: ${_this.selectedOptionKey}, isCorrect: ${_this.isCorrect}, correctOptionKey: ${_this.correctOptionKey}, rationale: ${_this.rationale}, keyConcept: ${_this.keyConcept})';
}


}

/// @nodoc
abstract mixin class $PracticeAttemptCopyWith<$Res>  {
  factory $PracticeAttemptCopyWith(PracticeAttempt value, $Res Function(PracticeAttempt) _then) = _$PracticeAttemptCopyWithImpl;
@useResult
$Res call({
 String selectedOptionKey, bool isCorrect, String? correctOptionKey, String? rationale, String? keyConcept
});




}
/// @nodoc
class _$PracticeAttemptCopyWithImpl<$Res>
    implements $PracticeAttemptCopyWith<$Res> {
  _$PracticeAttemptCopyWithImpl(this._self, this._then);

  final PracticeAttempt _self;
  final $Res Function(PracticeAttempt) _then;

/// Create a copy of PracticeAttempt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedOptionKey = null,Object? isCorrect = null,Object? correctOptionKey = freezed,Object? rationale = freezed,Object? keyConcept = freezed,}) {
  return _then(PracticeAttempt(
selectedOptionKey: null == selectedOptionKey ? _self.selectedOptionKey : selectedOptionKey // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,correctOptionKey: freezed == correctOptionKey ? _self.correctOptionKey : correctOptionKey // ignore: cast_nullable_to_non_nullable
as String?,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,keyConcept: freezed == keyConcept ? _self.keyConcept : keyConcept // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeAttempt].
extension PracticeAttemptPatterns on PracticeAttempt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeAttempt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeAttempt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeAttempt value)  $default,){
final _that = this;
switch (_that) {
case _PracticeAttempt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeAttempt value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeAttempt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String selectedOptionKey,  bool isCorrect,  String? correctOptionKey,  String? rationale,  String? keyConcept)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeAttempt() when $default != null:
return $default(_that.selectedOptionKey,_that.isCorrect,_that.correctOptionKey,_that.rationale,_that.keyConcept);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String selectedOptionKey,  bool isCorrect,  String? correctOptionKey,  String? rationale,  String? keyConcept)  $default,) {final _that = this;
switch (_that) {
case _PracticeAttempt():
return $default(_that.selectedOptionKey,_that.isCorrect,_that.correctOptionKey,_that.rationale,_that.keyConcept);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String selectedOptionKey,  bool isCorrect,  String? correctOptionKey,  String? rationale,  String? keyConcept)?  $default,) {final _that = this;
switch (_that) {
case _PracticeAttempt() when $default != null:
return $default(_that.selectedOptionKey,_that.isCorrect,_that.correctOptionKey,_that.rationale,_that.keyConcept);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeAttempt implements PracticeAttempt {
  const _PracticeAttempt({required this.selectedOptionKey, required this.isCorrect, this.correctOptionKey, this.rationale, this.keyConcept});
  factory _PracticeAttempt.fromJson(Map<String, dynamic> json) => _$PracticeAttemptFromJson(json);

@override final  String selectedOptionKey;
@override final  bool isCorrect;
@override final  String? correctOptionKey;
@override final  String? rationale;
@override final  String? keyConcept;

/// Create a copy of PracticeAttempt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeAttemptCopyWith<_PracticeAttempt> get copyWith => __$PracticeAttemptCopyWithImpl<_PracticeAttempt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeAttemptToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeAttempt&&(identical(other.selectedOptionKey, selectedOptionKey) || other.selectedOptionKey == selectedOptionKey)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.correctOptionKey, correctOptionKey) || other.correctOptionKey == correctOptionKey)&&(identical(other.rationale, rationale) || other.rationale == rationale)&&(identical(other.keyConcept, keyConcept) || other.keyConcept == keyConcept));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,selectedOptionKey,isCorrect,correctOptionKey,rationale,keyConcept);
}

@override
String toString() {
    return 'PracticeAttempt(selectedOptionKey: $selectedOptionKey, isCorrect: $isCorrect, correctOptionKey: $correctOptionKey, rationale: $rationale, keyConcept: $keyConcept)';
}


}

/// @nodoc
abstract mixin class _$PracticeAttemptCopyWith<$Res> implements $PracticeAttemptCopyWith<$Res> {
  factory _$PracticeAttemptCopyWith(_PracticeAttempt value, $Res Function(_PracticeAttempt) _then) = __$PracticeAttemptCopyWithImpl;
@override @useResult
$Res call({
 String selectedOptionKey, bool isCorrect, String? correctOptionKey, String? rationale, String? keyConcept
});




}
/// @nodoc
class __$PracticeAttemptCopyWithImpl<$Res>
    implements _$PracticeAttemptCopyWith<$Res> {
  __$PracticeAttemptCopyWithImpl(this._self, this._then);

  final _PracticeAttempt _self;
  final $Res Function(_PracticeAttempt) _then;

/// Create a copy of PracticeAttempt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedOptionKey = null,Object? isCorrect = null,Object? correctOptionKey = freezed,Object? rationale = freezed,Object? keyConcept = freezed,}) {
  return _then(_PracticeAttempt(
selectedOptionKey: null == selectedOptionKey ? _self.selectedOptionKey : selectedOptionKey // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,correctOptionKey: freezed == correctOptionKey ? _self.correctOptionKey : correctOptionKey // ignore: cast_nullable_to_non_nullable
as String?,rationale: freezed == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String?,keyConcept: freezed == keyConcept ? _self.keyConcept : keyConcept // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PracticeItem {

 String get id; int get displayOrder; String get stem; String get questionType; String get difficulty; List<PracticeOption> get options; PracticeAttempt? get attempt;
/// Create a copy of PracticeItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeItemCopyWith<PracticeItem> get copyWith => _$PracticeItemCopyWithImpl<PracticeItem>(this as PracticeItem, _$identity);

  /// Serializes this PracticeItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PracticeItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayOrder, _this.displayOrder) || other.displayOrder == _this.displayOrder)&&(identical(other.stem, _this.stem) || other.stem == _this.stem)&&(identical(other.questionType, _this.questionType) || other.questionType == _this.questionType)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&const DeepCollectionEquality().equals(other.options, _this.options)&&(identical(other.attempt, _this.attempt) || other.attempt == _this.attempt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PracticeItem;
  return Object.hash(runtimeType,_this.id,_this.displayOrder,_this.stem,_this.questionType,_this.difficulty,const DeepCollectionEquality().hash(_this.options),_this.attempt);
}

@override
String toString() {
  final _this = this as PracticeItem;
  return 'PracticeItem(id: ${_this.id}, displayOrder: ${_this.displayOrder}, stem: ${_this.stem}, questionType: ${_this.questionType}, difficulty: ${_this.difficulty}, options: ${_this.options}, attempt: ${_this.attempt})';
}


}

/// @nodoc
abstract mixin class $PracticeItemCopyWith<$Res>  {
  factory $PracticeItemCopyWith(PracticeItem value, $Res Function(PracticeItem) _then) = _$PracticeItemCopyWithImpl;
@useResult
$Res call({
 String id, int displayOrder, String stem, String questionType, String difficulty, List<PracticeOption> options, PracticeAttempt? attempt
});


$PracticeAttemptCopyWith<$Res>? get attempt;

}
/// @nodoc
class _$PracticeItemCopyWithImpl<$Res>
    implements $PracticeItemCopyWith<$Res> {
  _$PracticeItemCopyWithImpl(this._self, this._then);

  final PracticeItem _self;
  final $Res Function(PracticeItem) _then;

/// Create a copy of PracticeItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayOrder = null,Object? stem = null,Object? questionType = null,Object? difficulty = null,Object? options = null,Object? attempt = freezed,}) {
  return _then(PracticeItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,stem: null == stem ? _self.stem : stem // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PracticeOption>,attempt: freezed == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as PracticeAttempt?,
  ));
}
/// Create a copy of PracticeItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeAttemptCopyWith<$Res>? get attempt {
    if (_self.attempt == null) {
    return null;
  }

  return $PracticeAttemptCopyWith<$Res>(_self.attempt!, (value) {
    return _then(_self.copyWith(attempt: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeItem].
extension PracticeItemPatterns on PracticeItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeItem value)  $default,){
final _that = this;
switch (_that) {
case _PracticeItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeItem value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int displayOrder,  String stem,  String questionType,  String difficulty,  List<PracticeOption> options,  PracticeAttempt? attempt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeItem() when $default != null:
return $default(_that.id,_that.displayOrder,_that.stem,_that.questionType,_that.difficulty,_that.options,_that.attempt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int displayOrder,  String stem,  String questionType,  String difficulty,  List<PracticeOption> options,  PracticeAttempt? attempt)  $default,) {final _that = this;
switch (_that) {
case _PracticeItem():
return $default(_that.id,_that.displayOrder,_that.stem,_that.questionType,_that.difficulty,_that.options,_that.attempt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int displayOrder,  String stem,  String questionType,  String difficulty,  List<PracticeOption> options,  PracticeAttempt? attempt)?  $default,) {final _that = this;
switch (_that) {
case _PracticeItem() when $default != null:
return $default(_that.id,_that.displayOrder,_that.stem,_that.questionType,_that.difficulty,_that.options,_that.attempt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeItem implements PracticeItem {
  const _PracticeItem({required this.id, required this.displayOrder, required this.stem, this.questionType = '', this.difficulty = '',  List<PracticeOption> options = const <PracticeOption>[], this.attempt}): _options = options;
  factory _PracticeItem.fromJson(Map<String, dynamic> json) => _$PracticeItemFromJson(json);

@override final  String id;
@override final  int displayOrder;
@override final  String stem;
@override@JsonKey() final  String questionType;
@override@JsonKey() final  String difficulty;
 final  List<PracticeOption> _options;
@override@JsonKey() List<PracticeOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  PracticeAttempt? attempt;

/// Create a copy of PracticeItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeItemCopyWith<_PracticeItem> get copyWith => __$PracticeItemCopyWithImpl<_PracticeItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeItem&&(identical(other.id, id) || other.id == id)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.stem, stem) || other.stem == stem)&&(identical(other.questionType, questionType) || other.questionType == questionType)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&const DeepCollectionEquality().equals(other.options, _options)&&(identical(other.attempt, attempt) || other.attempt == attempt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayOrder,stem,questionType,difficulty,const DeepCollectionEquality().hash(_options),attempt);
}

@override
String toString() {
    return 'PracticeItem(id: $id, displayOrder: $displayOrder, stem: $stem, questionType: $questionType, difficulty: $difficulty, options: $options, attempt: $attempt)';
}


}

/// @nodoc
abstract mixin class _$PracticeItemCopyWith<$Res> implements $PracticeItemCopyWith<$Res> {
  factory _$PracticeItemCopyWith(_PracticeItem value, $Res Function(_PracticeItem) _then) = __$PracticeItemCopyWithImpl;
@override @useResult
$Res call({
 String id, int displayOrder, String stem, String questionType, String difficulty, List<PracticeOption> options, PracticeAttempt? attempt
});


@override $PracticeAttemptCopyWith<$Res>? get attempt;

}
/// @nodoc
class __$PracticeItemCopyWithImpl<$Res>
    implements _$PracticeItemCopyWith<$Res> {
  __$PracticeItemCopyWithImpl(this._self, this._then);

  final _PracticeItem _self;
  final $Res Function(_PracticeItem) _then;

/// Create a copy of PracticeItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayOrder = null,Object? stem = null,Object? questionType = null,Object? difficulty = null,Object? options = null,Object? attempt = freezed,}) {
  return _then(_PracticeItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,stem: null == stem ? _self.stem : stem // ignore: cast_nullable_to_non_nullable
as String,questionType: null == questionType ? _self.questionType : questionType // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PracticeOption>,attempt: freezed == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as PracticeAttempt?,
  ));
}

/// Create a copy of PracticeItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeAttemptCopyWith<$Res>? get attempt {
    if (_self.attempt == null) {
    return null;
  }

  return $PracticeAttemptCopyWith<$Res>(_self.attempt!, (value) {
    return _then(_self.copyWith(attempt: value));
  });
}
}


/// @nodoc
mixin _$PracticeSession {

 String get id; String get category; String get status; int get totalQuestions; int get correctCount; double? get scorePercentage; int? get answeredCount; int? get requestedQuestionCount; DateTime? get startedAt; DateTime? get completedAt; List<PracticeItem> get items;
/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeSessionCopyWith<PracticeSession> get copyWith => _$PracticeSessionCopyWithImpl<PracticeSession>(this as PracticeSession, _$identity);

  /// Serializes this PracticeSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PracticeSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.totalQuestions, _this.totalQuestions) || other.totalQuestions == _this.totalQuestions)&&(identical(other.correctCount, _this.correctCount) || other.correctCount == _this.correctCount)&&(identical(other.scorePercentage, _this.scorePercentage) || other.scorePercentage == _this.scorePercentage)&&(identical(other.answeredCount, _this.answeredCount) || other.answeredCount == _this.answeredCount)&&(identical(other.requestedQuestionCount, _this.requestedQuestionCount) || other.requestedQuestionCount == _this.requestedQuestionCount)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PracticeSession;
  return Object.hash(runtimeType,_this.id,_this.category,_this.status,_this.totalQuestions,_this.correctCount,_this.scorePercentage,_this.answeredCount,_this.requestedQuestionCount,_this.startedAt,_this.completedAt,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as PracticeSession;
  return 'PracticeSession(id: ${_this.id}, category: ${_this.category}, status: ${_this.status}, totalQuestions: ${_this.totalQuestions}, correctCount: ${_this.correctCount}, scorePercentage: ${_this.scorePercentage}, answeredCount: ${_this.answeredCount}, requestedQuestionCount: ${_this.requestedQuestionCount}, startedAt: ${_this.startedAt}, completedAt: ${_this.completedAt}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $PracticeSessionCopyWith<$Res>  {
  factory $PracticeSessionCopyWith(PracticeSession value, $Res Function(PracticeSession) _then) = _$PracticeSessionCopyWithImpl;
@useResult
$Res call({
 String id, String category, String status, int totalQuestions, int correctCount, double? scorePercentage, int? answeredCount, int? requestedQuestionCount, DateTime? startedAt, DateTime? completedAt, List<PracticeItem> items
});




}
/// @nodoc
class _$PracticeSessionCopyWithImpl<$Res>
    implements $PracticeSessionCopyWith<$Res> {
  _$PracticeSessionCopyWithImpl(this._self, this._then);

  final PracticeSession _self;
  final $Res Function(PracticeSession) _then;

/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? status = null,Object? totalQuestions = null,Object? correctCount = null,Object? scorePercentage = freezed,Object? answeredCount = freezed,Object? requestedQuestionCount = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? items = null,}) {
  return _then(PracticeSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,correctCount: null == correctCount ? _self.correctCount : correctCount // ignore: cast_nullable_to_non_nullable
as int,scorePercentage: freezed == scorePercentage ? _self.scorePercentage : scorePercentage // ignore: cast_nullable_to_non_nullable
as double?,answeredCount: freezed == answeredCount ? _self.answeredCount : answeredCount // ignore: cast_nullable_to_non_nullable
as int?,requestedQuestionCount: freezed == requestedQuestionCount ? _self.requestedQuestionCount : requestedQuestionCount // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PracticeItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeSession].
extension PracticeSessionPatterns on PracticeSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeSession value)  $default,){
final _that = this;
switch (_that) {
case _PracticeSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeSession value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String category,  String status,  int totalQuestions,  int correctCount,  double? scorePercentage,  int? answeredCount,  int? requestedQuestionCount,  DateTime? startedAt,  DateTime? completedAt,  List<PracticeItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
return $default(_that.id,_that.category,_that.status,_that.totalQuestions,_that.correctCount,_that.scorePercentage,_that.answeredCount,_that.requestedQuestionCount,_that.startedAt,_that.completedAt,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String category,  String status,  int totalQuestions,  int correctCount,  double? scorePercentage,  int? answeredCount,  int? requestedQuestionCount,  DateTime? startedAt,  DateTime? completedAt,  List<PracticeItem> items)  $default,) {final _that = this;
switch (_that) {
case _PracticeSession():
return $default(_that.id,_that.category,_that.status,_that.totalQuestions,_that.correctCount,_that.scorePercentage,_that.answeredCount,_that.requestedQuestionCount,_that.startedAt,_that.completedAt,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String category,  String status,  int totalQuestions,  int correctCount,  double? scorePercentage,  int? answeredCount,  int? requestedQuestionCount,  DateTime? startedAt,  DateTime? completedAt,  List<PracticeItem> items)?  $default,) {final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
return $default(_that.id,_that.category,_that.status,_that.totalQuestions,_that.correctCount,_that.scorePercentage,_that.answeredCount,_that.requestedQuestionCount,_that.startedAt,_that.completedAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeSession extends PracticeSession {
  const _PracticeSession({required this.id, required this.category, required this.status, required this.totalQuestions, this.correctCount = 0, this.scorePercentage, this.answeredCount, this.requestedQuestionCount, this.startedAt, this.completedAt,  List<PracticeItem> items = const <PracticeItem>[]}): _items = items,super._();
  factory _PracticeSession.fromJson(Map<String, dynamic> json) => _$PracticeSessionFromJson(json);

@override final  String id;
@override final  String category;
@override final  String status;
@override final  int totalQuestions;
@override@JsonKey() final  int correctCount;
@override final  double? scorePercentage;
@override final  int? answeredCount;
@override final  int? requestedQuestionCount;
@override final  DateTime? startedAt;
@override final  DateTime? completedAt;
 final  List<PracticeItem> _items;
@override@JsonKey() List<PracticeItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeSessionCopyWith<_PracticeSession> get copyWith => __$PracticeSessionCopyWithImpl<_PracticeSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeSession&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.correctCount, correctCount) || other.correctCount == correctCount)&&(identical(other.scorePercentage, scorePercentage) || other.scorePercentage == scorePercentage)&&(identical(other.answeredCount, answeredCount) || other.answeredCount == answeredCount)&&(identical(other.requestedQuestionCount, requestedQuestionCount) || other.requestedQuestionCount == requestedQuestionCount)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,category,status,totalQuestions,correctCount,scorePercentage,answeredCount,requestedQuestionCount,startedAt,completedAt,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'PracticeSession(id: $id, category: $category, status: $status, totalQuestions: $totalQuestions, correctCount: $correctCount, scorePercentage: $scorePercentage, answeredCount: $answeredCount, requestedQuestionCount: $requestedQuestionCount, startedAt: $startedAt, completedAt: $completedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$PracticeSessionCopyWith<$Res> implements $PracticeSessionCopyWith<$Res> {
  factory _$PracticeSessionCopyWith(_PracticeSession value, $Res Function(_PracticeSession) _then) = __$PracticeSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String category, String status, int totalQuestions, int correctCount, double? scorePercentage, int? answeredCount, int? requestedQuestionCount, DateTime? startedAt, DateTime? completedAt, List<PracticeItem> items
});




}
/// @nodoc
class __$PracticeSessionCopyWithImpl<$Res>
    implements _$PracticeSessionCopyWith<$Res> {
  __$PracticeSessionCopyWithImpl(this._self, this._then);

  final _PracticeSession _self;
  final $Res Function(_PracticeSession) _then;

/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? status = null,Object? totalQuestions = null,Object? correctCount = null,Object? scorePercentage = freezed,Object? answeredCount = freezed,Object? requestedQuestionCount = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? items = null,}) {
  return _then(_PracticeSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,correctCount: null == correctCount ? _self.correctCount : correctCount // ignore: cast_nullable_to_non_nullable
as int,scorePercentage: freezed == scorePercentage ? _self.scorePercentage : scorePercentage // ignore: cast_nullable_to_non_nullable
as double?,answeredCount: freezed == answeredCount ? _self.answeredCount : answeredCount // ignore: cast_nullable_to_non_nullable
as int?,requestedQuestionCount: freezed == requestedQuestionCount ? _self.requestedQuestionCount : requestedQuestionCount // ignore: cast_nullable_to_non_nullable
as int?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PracticeItem>,
  ));
}


}

// dart format on
