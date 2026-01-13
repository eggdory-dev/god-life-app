// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoutineModel _$RoutineModelFromJson(Map<String, dynamic> json) {
  return _RoutineModel.fromJson(json);
}

/// @nodoc
mixin _$RoutineModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  RoutineScheduleModel get schedule => throw _privateConstructorUsedError;
  int get streak => throw _privateConstructorUsedError;
  int get maxStreak => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoutineModelCopyWith<RoutineModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineModelCopyWith<$Res> {
  factory $RoutineModelCopyWith(
          RoutineModel value, $Res Function(RoutineModel) then) =
      _$RoutineModelCopyWithImpl<$Res, RoutineModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String? description,
      String? category,
      RoutineScheduleModel schedule,
      int streak,
      int maxStreak,
      String status,
      DateTime createdAt,
      DateTime? updatedAt});

  $RoutineScheduleModelCopyWith<$Res> get schedule;
}

/// @nodoc
class _$RoutineModelCopyWithImpl<$Res, $Val extends RoutineModel>
    implements $RoutineModelCopyWith<$Res> {
  _$RoutineModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = freezed,
    Object? schedule = null,
    Object? streak = null,
    Object? maxStreak = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as RoutineScheduleModel,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      maxStreak: null == maxStreak
          ? _value.maxStreak
          : maxStreak // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RoutineScheduleModelCopyWith<$Res> get schedule {
    return $RoutineScheduleModelCopyWith<$Res>(_value.schedule, (value) {
      return _then(_value.copyWith(schedule: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoutineModelImplCopyWith<$Res>
    implements $RoutineModelCopyWith<$Res> {
  factory _$$RoutineModelImplCopyWith(
          _$RoutineModelImpl value, $Res Function(_$RoutineModelImpl) then) =
      __$$RoutineModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String? description,
      String? category,
      RoutineScheduleModel schedule,
      int streak,
      int maxStreak,
      String status,
      DateTime createdAt,
      DateTime? updatedAt});

  @override
  $RoutineScheduleModelCopyWith<$Res> get schedule;
}

/// @nodoc
class __$$RoutineModelImplCopyWithImpl<$Res>
    extends _$RoutineModelCopyWithImpl<$Res, _$RoutineModelImpl>
    implements _$$RoutineModelImplCopyWith<$Res> {
  __$$RoutineModelImplCopyWithImpl(
      _$RoutineModelImpl _value, $Res Function(_$RoutineModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = freezed,
    Object? schedule = null,
    Object? streak = null,
    Object? maxStreak = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$RoutineModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as RoutineScheduleModel,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      maxStreak: null == maxStreak
          ? _value.maxStreak
          : maxStreak // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineModelImpl extends _RoutineModel {
  const _$RoutineModelImpl(
      {required this.id,
      required this.userId,
      required this.name,
      this.description,
      this.category,
      required this.schedule,
      this.streak = 0,
      this.maxStreak = 0,
      this.status = 'active',
      required this.createdAt,
      this.updatedAt})
      : super._();

  factory _$RoutineModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final RoutineScheduleModel schedule;
  @override
  @JsonKey()
  final int streak;
  @override
  @JsonKey()
  final int maxStreak;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'RoutineModel(id: $id, userId: $userId, name: $name, description: $description, category: $category, schedule: $schedule, streak: $streak, maxStreak: $maxStreak, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.maxStreak, maxStreak) ||
                other.maxStreak == maxStreak) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, description,
      category, schedule, streak, maxStreak, status, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineModelImplCopyWith<_$RoutineModelImpl> get copyWith =>
      __$$RoutineModelImplCopyWithImpl<_$RoutineModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineModelImplToJson(
      this,
    );
  }
}

abstract class _RoutineModel extends RoutineModel {
  const factory _RoutineModel(
      {required final String id,
      required final String userId,
      required final String name,
      final String? description,
      final String? category,
      required final RoutineScheduleModel schedule,
      final int streak,
      final int maxStreak,
      final String status,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$RoutineModelImpl;
  const _RoutineModel._() : super._();

  factory _RoutineModel.fromJson(Map<String, dynamic> json) =
      _$RoutineModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get category;
  @override
  RoutineScheduleModel get schedule;
  @override
  int get streak;
  @override
  int get maxStreak;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$RoutineModelImplCopyWith<_$RoutineModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoutineScheduleModel _$RoutineScheduleModelFromJson(Map<String, dynamic> json) {
  return _RoutineScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$RoutineScheduleModel {
  String get frequency => throw _privateConstructorUsedError;
  List<int> get days => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  bool get reminderEnabled => throw _privateConstructorUsedError;
  int get reminderMinutesBefore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoutineScheduleModelCopyWith<RoutineScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineScheduleModelCopyWith<$Res> {
  factory $RoutineScheduleModelCopyWith(RoutineScheduleModel value,
          $Res Function(RoutineScheduleModel) then) =
      _$RoutineScheduleModelCopyWithImpl<$Res, RoutineScheduleModel>;
  @useResult
  $Res call(
      {String frequency,
      List<int> days,
      String time,
      bool reminderEnabled,
      int reminderMinutesBefore});
}

/// @nodoc
class _$RoutineScheduleModelCopyWithImpl<$Res,
        $Val extends RoutineScheduleModel>
    implements $RoutineScheduleModelCopyWith<$Res> {
  _$RoutineScheduleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? days = null,
    Object? time = null,
    Object? reminderEnabled = null,
    Object? reminderMinutesBefore = null,
  }) {
    return _then(_value.copyWith(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      reminderEnabled: null == reminderEnabled
          ? _value.reminderEnabled
          : reminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderMinutesBefore: null == reminderMinutesBefore
          ? _value.reminderMinutesBefore
          : reminderMinutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutineScheduleModelImplCopyWith<$Res>
    implements $RoutineScheduleModelCopyWith<$Res> {
  factory _$$RoutineScheduleModelImplCopyWith(_$RoutineScheduleModelImpl value,
          $Res Function(_$RoutineScheduleModelImpl) then) =
      __$$RoutineScheduleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String frequency,
      List<int> days,
      String time,
      bool reminderEnabled,
      int reminderMinutesBefore});
}

/// @nodoc
class __$$RoutineScheduleModelImplCopyWithImpl<$Res>
    extends _$RoutineScheduleModelCopyWithImpl<$Res, _$RoutineScheduleModelImpl>
    implements _$$RoutineScheduleModelImplCopyWith<$Res> {
  __$$RoutineScheduleModelImplCopyWithImpl(_$RoutineScheduleModelImpl _value,
      $Res Function(_$RoutineScheduleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
    Object? days = null,
    Object? time = null,
    Object? reminderEnabled = null,
    Object? reminderMinutesBefore = null,
  }) {
    return _then(_$RoutineScheduleModelImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      reminderEnabled: null == reminderEnabled
          ? _value.reminderEnabled
          : reminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderMinutesBefore: null == reminderMinutesBefore
          ? _value.reminderMinutesBefore
          : reminderMinutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineScheduleModelImpl extends _RoutineScheduleModel {
  const _$RoutineScheduleModelImpl(
      {required this.frequency,
      final List<int> days = const [],
      required this.time,
      this.reminderEnabled = true,
      this.reminderMinutesBefore = 10})
      : _days = days,
        super._();

  factory _$RoutineScheduleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineScheduleModelImplFromJson(json);

  @override
  final String frequency;
  final List<int> _days;
  @override
  @JsonKey()
  List<int> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final String time;
  @override
  @JsonKey()
  final bool reminderEnabled;
  @override
  @JsonKey()
  final int reminderMinutesBefore;

  @override
  String toString() {
    return 'RoutineScheduleModel(frequency: $frequency, days: $days, time: $time, reminderEnabled: $reminderEnabled, reminderMinutesBefore: $reminderMinutesBefore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineScheduleModelImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.reminderEnabled, reminderEnabled) ||
                other.reminderEnabled == reminderEnabled) &&
            (identical(other.reminderMinutesBefore, reminderMinutesBefore) ||
                other.reminderMinutesBefore == reminderMinutesBefore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      frequency,
      const DeepCollectionEquality().hash(_days),
      time,
      reminderEnabled,
      reminderMinutesBefore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineScheduleModelImplCopyWith<_$RoutineScheduleModelImpl>
      get copyWith =>
          __$$RoutineScheduleModelImplCopyWithImpl<_$RoutineScheduleModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineScheduleModelImplToJson(
      this,
    );
  }
}

abstract class _RoutineScheduleModel extends RoutineScheduleModel {
  const factory _RoutineScheduleModel(
      {required final String frequency,
      final List<int> days,
      required final String time,
      final bool reminderEnabled,
      final int reminderMinutesBefore}) = _$RoutineScheduleModelImpl;
  const _RoutineScheduleModel._() : super._();

  factory _RoutineScheduleModel.fromJson(Map<String, dynamic> json) =
      _$RoutineScheduleModelImpl.fromJson;

  @override
  String get frequency;
  @override
  List<int> get days;
  @override
  String get time;
  @override
  bool get reminderEnabled;
  @override
  int get reminderMinutesBefore;
  @override
  @JsonKey(ignore: true)
  _$$RoutineScheduleModelImplCopyWith<_$RoutineScheduleModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RoutineCompletionModel _$RoutineCompletionModelFromJson(
    Map<String, dynamic> json) {
  return _RoutineCompletionModel.fromJson(json);
}

/// @nodoc
mixin _$RoutineCompletionModel {
  String get id => throw _privateConstructorUsedError;
  String get routineId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoutineCompletionModelCopyWith<RoutineCompletionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutineCompletionModelCopyWith<$Res> {
  factory $RoutineCompletionModelCopyWith(RoutineCompletionModel value,
          $Res Function(RoutineCompletionModel) then) =
      _$RoutineCompletionModelCopyWithImpl<$Res, RoutineCompletionModel>;
  @useResult
  $Res call(
      {String id,
      String routineId,
      String userId,
      DateTime completedAt,
      String? note});
}

/// @nodoc
class _$RoutineCompletionModelCopyWithImpl<$Res,
        $Val extends RoutineCompletionModel>
    implements $RoutineCompletionModelCopyWith<$Res> {
  _$RoutineCompletionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routineId = null,
    Object? userId = null,
    Object? completedAt = null,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      routineId: null == routineId
          ? _value.routineId
          : routineId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoutineCompletionModelImplCopyWith<$Res>
    implements $RoutineCompletionModelCopyWith<$Res> {
  factory _$$RoutineCompletionModelImplCopyWith(
          _$RoutineCompletionModelImpl value,
          $Res Function(_$RoutineCompletionModelImpl) then) =
      __$$RoutineCompletionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String routineId,
      String userId,
      DateTime completedAt,
      String? note});
}

/// @nodoc
class __$$RoutineCompletionModelImplCopyWithImpl<$Res>
    extends _$RoutineCompletionModelCopyWithImpl<$Res,
        _$RoutineCompletionModelImpl>
    implements _$$RoutineCompletionModelImplCopyWith<$Res> {
  __$$RoutineCompletionModelImplCopyWithImpl(
      _$RoutineCompletionModelImpl _value,
      $Res Function(_$RoutineCompletionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routineId = null,
    Object? userId = null,
    Object? completedAt = null,
    Object? note = freezed,
  }) {
    return _then(_$RoutineCompletionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      routineId: null == routineId
          ? _value.routineId
          : routineId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutineCompletionModelImpl extends _RoutineCompletionModel {
  const _$RoutineCompletionModelImpl(
      {required this.id,
      required this.routineId,
      required this.userId,
      required this.completedAt,
      this.note})
      : super._();

  factory _$RoutineCompletionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoutineCompletionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String routineId;
  @override
  final String userId;
  @override
  final DateTime completedAt;
  @override
  final String? note;

  @override
  String toString() {
    return 'RoutineCompletionModel(id: $id, routineId: $routineId, userId: $userId, completedAt: $completedAt, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutineCompletionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.routineId, routineId) ||
                other.routineId == routineId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, routineId, userId, completedAt, note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutineCompletionModelImplCopyWith<_$RoutineCompletionModelImpl>
      get copyWith => __$$RoutineCompletionModelImplCopyWithImpl<
          _$RoutineCompletionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutineCompletionModelImplToJson(
      this,
    );
  }
}

abstract class _RoutineCompletionModel extends RoutineCompletionModel {
  const factory _RoutineCompletionModel(
      {required final String id,
      required final String routineId,
      required final String userId,
      required final DateTime completedAt,
      final String? note}) = _$RoutineCompletionModelImpl;
  const _RoutineCompletionModel._() : super._();

  factory _RoutineCompletionModel.fromJson(Map<String, dynamic> json) =
      _$RoutineCompletionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get routineId;
  @override
  String get userId;
  @override
  DateTime get completedAt;
  @override
  String? get note;
  @override
  @JsonKey(ignore: true)
  _$$RoutineCompletionModelImplCopyWith<_$RoutineCompletionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
