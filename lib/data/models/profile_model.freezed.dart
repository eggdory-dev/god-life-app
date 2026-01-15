// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  List<String>? get interests => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_faith_user')
  bool? get isFaithUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'coaching_style')
  String? get coachingStyle => throw _privateConstructorUsedError;
  @JsonKey(name: 'theme_mode')
  String? get themeMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'onboarding_completed')
  bool? get onboardingCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login_at')
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) then) =
      _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      @JsonKey(name: 'profile_image_url') String? profileImageUrl,
      String? provider,
      List<String>? interests,
      @JsonKey(name: 'is_faith_user') bool? isFaithUser,
      @JsonKey(name: 'coaching_style') String? coachingStyle,
      @JsonKey(name: 'theme_mode') String? themeMode,
      @JsonKey(name: 'onboarding_completed') bool? onboardingCompleted,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_login_at') DateTime? lastLoginAt});
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? profileImageUrl = freezed,
    Object? provider = freezed,
    Object? interests = freezed,
    Object? isFaithUser = freezed,
    Object? coachingStyle = freezed,
    Object? themeMode = freezed,
    Object? onboardingCompleted = freezed,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: freezed == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFaithUser: freezed == isFaithUser
          ? _value.isFaithUser
          : isFaithUser // ignore: cast_nullable_to_non_nullable
              as bool?,
      coachingStyle: freezed == coachingStyle
          ? _value.coachingStyle
          : coachingStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      themeMode: freezed == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String?,
      onboardingCompleted: freezed == onboardingCompleted
          ? _value.onboardingCompleted
          : onboardingCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
          _$ProfileModelImpl value, $Res Function(_$ProfileModelImpl) then) =
      __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      @JsonKey(name: 'profile_image_url') String? profileImageUrl,
      String? provider,
      List<String>? interests,
      @JsonKey(name: 'is_faith_user') bool? isFaithUser,
      @JsonKey(name: 'coaching_style') String? coachingStyle,
      @JsonKey(name: 'theme_mode') String? themeMode,
      @JsonKey(name: 'onboarding_completed') bool? onboardingCompleted,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'last_login_at') DateTime? lastLoginAt});
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
      _$ProfileModelImpl _value, $Res Function(_$ProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? profileImageUrl = freezed,
    Object? provider = freezed,
    Object? interests = freezed,
    Object? isFaithUser = freezed,
    Object? coachingStyle = freezed,
    Object? themeMode = freezed,
    Object? onboardingCompleted = freezed,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_$ProfileModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: freezed == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isFaithUser: freezed == isFaithUser
          ? _value.isFaithUser
          : isFaithUser // ignore: cast_nullable_to_non_nullable
              as bool?,
      coachingStyle: freezed == coachingStyle
          ? _value.coachingStyle
          : coachingStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      themeMode: freezed == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String?,
      onboardingCompleted: freezed == onboardingCompleted
          ? _value.onboardingCompleted
          : onboardingCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl extends _ProfileModel {
  const _$ProfileModelImpl(
      {required this.id,
      required this.email,
      required this.name,
      @JsonKey(name: 'profile_image_url') this.profileImageUrl,
      this.provider,
      final List<String>? interests,
      @JsonKey(name: 'is_faith_user') this.isFaithUser,
      @JsonKey(name: 'coaching_style') this.coachingStyle,
      @JsonKey(name: 'theme_mode') this.themeMode,
      @JsonKey(name: 'onboarding_completed') this.onboardingCompleted,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'last_login_at') this.lastLoginAt})
      : _interests = interests,
        super._();

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  @override
  final String? provider;
  final List<String>? _interests;
  @override
  List<String>? get interests {
    final value = _interests;
    if (value == null) return null;
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_faith_user')
  final bool? isFaithUser;
  @override
  @JsonKey(name: 'coaching_style')
  final String? coachingStyle;
  @override
  @JsonKey(name: 'theme_mode')
  final String? themeMode;
  @override
  @JsonKey(name: 'onboarding_completed')
  final bool? onboardingCompleted;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'last_login_at')
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'ProfileModel(id: $id, email: $email, name: $name, profileImageUrl: $profileImageUrl, provider: $provider, interests: $interests, isFaithUser: $isFaithUser, coachingStyle: $coachingStyle, themeMode: $themeMode, onboardingCompleted: $onboardingCompleted, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            (identical(other.isFaithUser, isFaithUser) ||
                other.isFaithUser == isFaithUser) &&
            (identical(other.coachingStyle, coachingStyle) ||
                other.coachingStyle == coachingStyle) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      profileImageUrl,
      provider,
      const DeepCollectionEquality().hash(_interests),
      isFaithUser,
      coachingStyle,
      themeMode,
      onboardingCompleted,
      createdAt,
      lastLoginAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(
      this,
    );
  }
}

abstract class _ProfileModel extends ProfileModel {
  const factory _ProfileModel(
      {required final String id,
      required final String email,
      required final String name,
      @JsonKey(name: 'profile_image_url') final String? profileImageUrl,
      final String? provider,
      final List<String>? interests,
      @JsonKey(name: 'is_faith_user') final bool? isFaithUser,
      @JsonKey(name: 'coaching_style') final String? coachingStyle,
      @JsonKey(name: 'theme_mode') final String? themeMode,
      @JsonKey(name: 'onboarding_completed') final bool? onboardingCompleted,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'last_login_at')
      final DateTime? lastLoginAt}) = _$ProfileModelImpl;
  const _ProfileModel._() : super._();

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get name;
  @override
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl;
  @override
  String? get provider;
  @override
  List<String>? get interests;
  @override
  @JsonKey(name: 'is_faith_user')
  bool? get isFaithUser;
  @override
  @JsonKey(name: 'coaching_style')
  String? get coachingStyle;
  @override
  @JsonKey(name: 'theme_mode')
  String? get themeMode;
  @override
  @JsonKey(name: 'onboarding_completed')
  bool? get onboardingCompleted;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'last_login_at')
  DateTime? get lastLoginAt;
  @override
  @JsonKey(ignore: true)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
