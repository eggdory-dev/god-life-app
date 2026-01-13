// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayCompletedRoutineIdsHash() =>
    r'bca99d858991fe96eb0f02d00a426254d0994315';

/// Provider for today's completions
///
/// Copied from [todayCompletedRoutineIds].
@ProviderFor(todayCompletedRoutineIds)
final todayCompletedRoutineIdsProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
  todayCompletedRoutineIds,
  name: r'todayCompletedRoutineIdsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayCompletedRoutineIdsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodayCompletedRoutineIdsRef
    = AutoDisposeFutureProviderRef<List<String>>;
String _$isRoutineCompletedTodayHash() =>
    r'f8be96a2e6c078a10b24d438adf3f3fbbe32d73d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for checking if a routine is completed today
///
/// Copied from [isRoutineCompletedToday].
@ProviderFor(isRoutineCompletedToday)
const isRoutineCompletedTodayProvider = IsRoutineCompletedTodayFamily();

/// Provider for checking if a routine is completed today
///
/// Copied from [isRoutineCompletedToday].
class IsRoutineCompletedTodayFamily extends Family<AsyncValue<bool>> {
  /// Provider for checking if a routine is completed today
  ///
  /// Copied from [isRoutineCompletedToday].
  const IsRoutineCompletedTodayFamily();

  /// Provider for checking if a routine is completed today
  ///
  /// Copied from [isRoutineCompletedToday].
  IsRoutineCompletedTodayProvider call(
    String routineId,
  ) {
    return IsRoutineCompletedTodayProvider(
      routineId,
    );
  }

  @override
  IsRoutineCompletedTodayProvider getProviderOverride(
    covariant IsRoutineCompletedTodayProvider provider,
  ) {
    return call(
      provider.routineId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isRoutineCompletedTodayProvider';
}

/// Provider for checking if a routine is completed today
///
/// Copied from [isRoutineCompletedToday].
class IsRoutineCompletedTodayProvider extends AutoDisposeFutureProvider<bool> {
  /// Provider for checking if a routine is completed today
  ///
  /// Copied from [isRoutineCompletedToday].
  IsRoutineCompletedTodayProvider(
    String routineId,
  ) : this._internal(
          (ref) => isRoutineCompletedToday(
            ref as IsRoutineCompletedTodayRef,
            routineId,
          ),
          from: isRoutineCompletedTodayProvider,
          name: r'isRoutineCompletedTodayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isRoutineCompletedTodayHash,
          dependencies: IsRoutineCompletedTodayFamily._dependencies,
          allTransitiveDependencies:
              IsRoutineCompletedTodayFamily._allTransitiveDependencies,
          routineId: routineId,
        );

  IsRoutineCompletedTodayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.routineId,
  }) : super.internal();

  final String routineId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(IsRoutineCompletedTodayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsRoutineCompletedTodayProvider._internal(
        (ref) => create(ref as IsRoutineCompletedTodayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        routineId: routineId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsRoutineCompletedTodayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsRoutineCompletedTodayProvider &&
        other.routineId == routineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, routineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsRoutineCompletedTodayRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `routineId` of this provider.
  String get routineId;
}

class _IsRoutineCompletedTodayProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with IsRoutineCompletedTodayRef {
  _IsRoutineCompletedTodayProviderElement(super.provider);

  @override
  String get routineId => (origin as IsRoutineCompletedTodayProvider).routineId;
}

String _$routineListHash() => r'e3af8f5cb1b431954bda6f5fb23e6a3dccdc2250';

abstract class _$RoutineList
    extends BuildlessAutoDisposeAsyncNotifier<List<Routine>> {
  late final RoutineStatus? status;

  FutureOr<List<Routine>> build({
    RoutineStatus? status,
  });
}

/// Provider for routine list
/// Supports filtering by status (active/archived)
///
/// Copied from [RoutineList].
@ProviderFor(RoutineList)
const routineListProvider = RoutineListFamily();

/// Provider for routine list
/// Supports filtering by status (active/archived)
///
/// Copied from [RoutineList].
class RoutineListFamily extends Family<AsyncValue<List<Routine>>> {
  /// Provider for routine list
  /// Supports filtering by status (active/archived)
  ///
  /// Copied from [RoutineList].
  const RoutineListFamily();

  /// Provider for routine list
  /// Supports filtering by status (active/archived)
  ///
  /// Copied from [RoutineList].
  RoutineListProvider call({
    RoutineStatus? status,
  }) {
    return RoutineListProvider(
      status: status,
    );
  }

  @override
  RoutineListProvider getProviderOverride(
    covariant RoutineListProvider provider,
  ) {
    return call(
      status: provider.status,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'routineListProvider';
}

/// Provider for routine list
/// Supports filtering by status (active/archived)
///
/// Copied from [RoutineList].
class RoutineListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RoutineList, List<Routine>> {
  /// Provider for routine list
  /// Supports filtering by status (active/archived)
  ///
  /// Copied from [RoutineList].
  RoutineListProvider({
    RoutineStatus? status,
  }) : this._internal(
          () => RoutineList()..status = status,
          from: routineListProvider,
          name: r'routineListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$routineListHash,
          dependencies: RoutineListFamily._dependencies,
          allTransitiveDependencies:
              RoutineListFamily._allTransitiveDependencies,
          status: status,
        );

  RoutineListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final RoutineStatus? status;

  @override
  FutureOr<List<Routine>> runNotifierBuild(
    covariant RoutineList notifier,
  ) {
    return notifier.build(
      status: status,
    );
  }

  @override
  Override overrideWith(RoutineList Function() create) {
    return ProviderOverride(
      origin: this,
      override: RoutineListProvider._internal(
        () => create()..status = status,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RoutineList, List<Routine>>
      createElement() {
    return _RoutineListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineListProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RoutineListRef on AutoDisposeAsyncNotifierProviderRef<List<Routine>> {
  /// The parameter `status` of this provider.
  RoutineStatus? get status;
}

class _RoutineListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RoutineList, List<Routine>>
    with RoutineListRef {
  _RoutineListProviderElement(super.provider);

  @override
  RoutineStatus? get status => (origin as RoutineListProvider).status;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
