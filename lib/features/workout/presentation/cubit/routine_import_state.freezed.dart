// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_import_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoutineImportState {
  String get pastedText => throw _privateConstructorUsedError;

  /// The parsed routines waiting for the user to confirm. Null until the text
  /// has been checked, and cleared again on every edit so the preview can
  /// never describe text that is no longer in the field.
  RoutineImportResult? get preview => throw _privateConstructorUsedError;
  RoutineImportFailure? get failure => throw _privateConstructorUsedError;
  bool get isChecking => throw _privateConstructorUsedError;
  bool get isImporting => throw _privateConstructorUsedError;
  int get importedCount => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of RoutineImportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutineImportStateCopyWith<RoutineImportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineImportStateCopyWith<$Res> {
  factory $RoutineImportStateCopyWith(
          RoutineImportState value, $Res Function(RoutineImportState) then) =
      _$RoutineImportStateCopyWithImpl<$Res, RoutineImportState>;
  @useResult
  $Res call(
      {String pastedText,
      RoutineImportResult? preview,
      RoutineImportFailure? failure,
      bool isChecking,
      bool isImporting,
      int importedCount,
      String? errorMessage});
}

/// @nodoc
class _$RoutineImportStateCopyWithImpl<$Res, $Val extends RoutineImportState>
    implements $RoutineImportStateCopyWith<$Res> {
  _$RoutineImportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutineImportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pastedText = null,
    Object? preview = freezed,
    Object? failure = freezed,
    Object? isChecking = null,
    Object? isImporting = null,
    Object? importedCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      pastedText: null == pastedText
          ? _value.pastedText
          : pastedText // ignore: cast_nullable_to_non_nullable
              as String,
      preview: freezed == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as RoutineImportResult?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as RoutineImportFailure?,
      isChecking: null == isChecking
          ? _value.isChecking
          : isChecking // ignore: cast_nullable_to_non_nullable
              as bool,
      isImporting: null == isImporting
          ? _value.isImporting
          : isImporting // ignore: cast_nullable_to_non_nullable
              as bool,
      importedCount: null == importedCount
          ? _value.importedCount
          : importedCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutineImportStateImplCopyWith<$Res>
    implements $RoutineImportStateCopyWith<$Res> {
  factory _$$RoutineImportStateImplCopyWith(_$RoutineImportStateImpl value,
          $Res Function(_$RoutineImportStateImpl) then) =
      __$$RoutineImportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String pastedText,
      RoutineImportResult? preview,
      RoutineImportFailure? failure,
      bool isChecking,
      bool isImporting,
      int importedCount,
      String? errorMessage});
}

/// @nodoc
class __$$RoutineImportStateImplCopyWithImpl<$Res>
    extends _$RoutineImportStateCopyWithImpl<$Res, _$RoutineImportStateImpl>
    implements _$$RoutineImportStateImplCopyWith<$Res> {
  __$$RoutineImportStateImplCopyWithImpl(_$RoutineImportStateImpl _value,
      $Res Function(_$RoutineImportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoutineImportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pastedText = null,
    Object? preview = freezed,
    Object? failure = freezed,
    Object? isChecking = null,
    Object? isImporting = null,
    Object? importedCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$RoutineImportStateImpl(
      pastedText: null == pastedText
          ? _value.pastedText
          : pastedText // ignore: cast_nullable_to_non_nullable
              as String,
      preview: freezed == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as RoutineImportResult?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as RoutineImportFailure?,
      isChecking: null == isChecking
          ? _value.isChecking
          : isChecking // ignore: cast_nullable_to_non_nullable
              as bool,
      isImporting: null == isImporting
          ? _value.isImporting
          : isImporting // ignore: cast_nullable_to_non_nullable
              as bool,
      importedCount: null == importedCount
          ? _value.importedCount
          : importedCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RoutineImportStateImpl implements _RoutineImportState {
  const _$RoutineImportStateImpl(
      {this.pastedText = '',
      this.preview,
      this.failure,
      this.isChecking = false,
      this.isImporting = false,
      this.importedCount = 0,
      this.errorMessage});

  @override
  @JsonKey()
  final String pastedText;

  /// The parsed routines waiting for the user to confirm. Null until the text
  /// has been checked, and cleared again on every edit so the preview can
  /// never describe text that is no longer in the field.
  @override
  final RoutineImportResult? preview;
  @override
  final RoutineImportFailure? failure;
  @override
  @JsonKey()
  final bool isChecking;
  @override
  @JsonKey()
  final bool isImporting;
  @override
  @JsonKey()
  final int importedCount;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'RoutineImportState(pastedText: $pastedText, preview: $preview, failure: $failure, isChecking: $isChecking, isImporting: $isImporting, importedCount: $importedCount, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineImportStateImpl &&
            (identical(other.pastedText, pastedText) ||
                other.pastedText == pastedText) &&
            (identical(other.preview, preview) || other.preview == preview) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.isChecking, isChecking) ||
                other.isChecking == isChecking) &&
            (identical(other.isImporting, isImporting) ||
                other.isImporting == isImporting) &&
            (identical(other.importedCount, importedCount) ||
                other.importedCount == importedCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pastedText, preview, failure,
      isChecking, isImporting, importedCount, errorMessage);

  /// Create a copy of RoutineImportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineImportStateImplCopyWith<_$RoutineImportStateImpl> get copyWith =>
      __$$RoutineImportStateImplCopyWithImpl<_$RoutineImportStateImpl>(
          this, _$identity);
}

abstract class _RoutineImportState implements RoutineImportState {
  const factory _RoutineImportState(
      {final String pastedText,
      final RoutineImportResult? preview,
      final RoutineImportFailure? failure,
      final bool isChecking,
      final bool isImporting,
      final int importedCount,
      final String? errorMessage}) = _$RoutineImportStateImpl;

  @override
  String get pastedText;

  /// The parsed routines waiting for the user to confirm. Null until the text
  /// has been checked, and cleared again on every edit so the preview can
  /// never describe text that is no longer in the field.
  @override
  RoutineImportResult? get preview;
  @override
  RoutineImportFailure? get failure;
  @override
  bool get isChecking;
  @override
  bool get isImporting;
  @override
  int get importedCount;
  @override
  String? get errorMessage;

  /// Create a copy of RoutineImportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutineImportStateImplCopyWith<_$RoutineImportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
