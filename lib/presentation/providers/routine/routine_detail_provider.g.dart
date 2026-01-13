// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routineDetailHash() => r'07978dfc44af27914bc34bd0c2535959c850d56b';

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

/// Provider for a single routine detail
///
/// Copied from [routineDetail].
@ProviderFor(routineDetail)
const routineDetailProvider = RoutineDetailFamily();

/// Provider for a single routine detail
///
/// Copied from [routineDetail].
class RoutineDetailFamily extends Family<AsyncValue<Routine>> {
  /// Provider for a single routine detail
  ///
  /// Copied from [routineDetail].
  const RoutineDetailFamily();

  /// Provider for a single routine detail
  ///
  /// Copied from [routineDetail].
  RoutineDetailProvider call(
    String routineId,
  ) {
    return RoutineDetailProvider(
      routineId,
    );
  }

  @override
  RoutineDetailProvider getProviderOverride(
    covariant RoutineDetailProvider provider,
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
  String? get name => r'routineDetailProvider';
}

/// Provider for a single routine detail
///
/// Copied from [routineDetail].
class RoutineDetailProvider extends AutoDisposeFutureProvider<Routine> {
  /// Provider for a single routine detail
  ///
  /// Copied from [routineDetail].
  RoutineDetailProvider(
    String routineId,
  ) : this._internal(
          (ref) => routineDetail(
            ref as RoutineDetailRef,
            routineId,
          ),
          from: routineDetailProvider,
          name: r'routineDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$routineDetailHash,
          dependencies: RoutineDetailFamily._dependencies,
          allTransitiveDependencies:
              RoutineDetailFamily._allTransitiveDependencies,
          routineId: routineId,
        );

  RoutineDetailProvider._internal(
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
    FutureOr<Routine> Function(RoutineDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RoutineDetailProvider._internal(
        (ref) => create(ref as RoutineDetailRef),
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
  AutoDisposeFutureProviderElement<Routine> createElement() {
    return _RoutineDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineDetailProvider && other.routineId == routineId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, routineId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RoutineDetailRef on AutoDisposeFutureProviderRef<Routine> {
  /// The parameter `routineId` of this provider.
  String get routineId;
}

class _RoutineDetailProviderElement
    extends AutoDisposeFutureProviderElement<Routine> with RoutineDetailRef {
  _RoutineDetailProviderElement(super.provider);

  @override
  String get routineId => (origin as RoutineDetailProvider).routineId;
}

String _$routineStatsHash() => r'9e7da430beb58f60b99582a3ec4f9d695db6df0d';

/// Provider for routine statistics
///
/// Copied from [routineStats].
@ProviderFor(routineStats)
const routineStatsProvider = RoutineStatsFamily();

/// Provider for routine statistics
///
/// Copied from [routineStats].
class RoutineStatsFamily extends Family<AsyncValue<RoutineStats>> {
  /// Provider for routine statistics
  ///
  /// Copied from [routineStats].
  const RoutineStatsFamily();

  /// Provider for routine statistics
  ///
  /// Copied from [routineStats].
  RoutineStatsProvider call(
    String routineId, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return RoutineStatsProvider(
      routineId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  RoutineStatsProvider getProviderOverride(
    covariant RoutineStatsProvider provider,
  ) {
    return call(
      provider.routineId,
      startDate: provider.startDate,
      endDate: provider.endDate,
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
  String? get name => r'routineStatsProvider';
}

/// Provider for routine statistics
///
/// Copied from [routineStats].
class RoutineStatsProvider extends AutoDisposeFutureProvider<RoutineStats> {
  /// Provider for routine statistics
  ///
  /// Copied from [routineStats].
  RoutineStatsProvider(
    String routineId, {
    DateTime? startDate,
    DateTime? endDate,
  }) : this._internal(
          (ref) => routineStats(
            ref as RoutineStatsRef,
            routineId,
            startDate: startDate,
            endDate: endDate,
          ),
          from: routineStatsProvider,
          name: r'routineStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$routineStatsHash,
          dependencies: RoutineStatsFamily._dependencies,
          allTransitiveDependencies:
              RoutineStatsFamily._allTransitiveDependencies,
          routineId: routineId,
          startDate: startDate,
          endDate: endDate,
        );

  RoutineStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.routineId,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final String routineId;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Override overrideWith(
    FutureOr<RoutineStats> Function(RoutineStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RoutineStatsProvider._internal(
        (ref) => create(ref as RoutineStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        routineId: routineId,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<RoutineStats> createElement() {
    return _RoutineStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineStatsProvider &&
        other.routineId == routineId &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, routineId.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RoutineStatsRef on AutoDisposeFutureProviderRef<RoutineStats> {
  /// The parameter `routineId` of this provider.
  String get routineId;

  /// The parameter `startDate` of this provider.
  DateTime? get startDate;

  /// The parameter `endDate` of this provider.
  DateTime? get endDate;
}

class _RoutineStatsProviderElement
    extends AutoDisposeFutureProviderElement<RoutineStats>
    with RoutineStatsRef {
  _RoutineStatsProviderElement(super.provider);

  @override
  String get routineId => (origin as RoutineStatsProvider).routineId;
  @override
  DateTime? get startDate => (origin as RoutineStatsProvider).startDate;
  @override
  DateTime? get endDate => (origin as RoutineStatsProvider).endDate;
}

String _$routineCompletionsHash() =>
    r'9e2887de5c882c48770f2bd739e682cc2c5e0a82';

/// Provider for routine completions
///
/// Copied from [routineCompletions].
@ProviderFor(routineCompletions)
const routineCompletionsProvider = RoutineCompletionsFamily();

/// Provider for routine completions
///
/// Copied from [routineCompletions].
class RoutineCompletionsFamily
    extends Family<AsyncValue<List<RoutineCompletion>>> {
  /// Provider for routine completions
  ///
  /// Copied from [routineCompletions].
  const RoutineCompletionsFamily();

  /// Provider for routine completions
  ///
  /// Copied from [routineCompletions].
  RoutineCompletionsProvider call(
    String routineId, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return RoutineCompletionsProvider(
      routineId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  RoutineCompletionsProvider getProviderOverride(
    covariant RoutineCompletionsProvider provider,
  ) {
    return call(
      provider.routineId,
      startDate: provider.startDate,
      endDate: provider.endDate,
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
  String? get name => r'routineCompletionsProvider';
}

/// Provider for routine completions
///
/// Copied from [routineCompletions].
class RoutineCompletionsProvider
    extends AutoDisposeFutureProvider<List<RoutineCompletion>> {
  /// Provider for routine completions
  ///
  /// Copied from [routineCompletions].
  RoutineCompletionsProvider(
    String routineId, {
    DateTime? startDate,
    DateTime? endDate,
  }) : this._internal(
          (ref) => routineCompletions(
            ref as RoutineCompletionsRef,
            routineId,
            startDate: startDate,
            endDate: endDate,
          ),
          from: routineCompletionsProvider,
          name: r'routineCompletionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$routineCompletionsHash,
          dependencies: RoutineCompletionsFamily._dependencies,
          allTransitiveDependencies:
              RoutineCompletionsFamily._allTransitiveDependencies,
          routineId: routineId,
          startDate: startDate,
          endDate: endDate,
        );

  RoutineCompletionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.routineId,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final String routineId;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Override overrideWith(
    FutureOr<List<RoutineCompletion>> Function(RoutineCompletionsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RoutineCompletionsProvider._internal(
        (ref) => create(ref as RoutineCompletionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        routineId: routineId,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RoutineCompletion>> createElement() {
    return _RoutineCompletionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutineCompletionsProvider &&
        other.routineId == routineId &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, routineId.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RoutineCompletionsRef
    on AutoDisposeFutureProviderRef<List<RoutineCompletion>> {
  /// The parameter `routineId` of this provider.
  String get routineId;

  /// The parameter `startDate` of this provider.
  DateTime? get startDate;

  /// The parameter `endDate` of this provider.
  DateTime? get endDate;
}

class _RoutineCompletionsProviderElement
    extends AutoDisposeFutureProviderElement<List<RoutineCompletion>>
    with RoutineCompletionsRef {
  _RoutineCompletionsProviderElement(super.provider);

  @override
  String get routineId => (origin as RoutineCompletionsProvider).routineId;
  @override
  DateTime? get startDate => (origin as RoutineCompletionsProvider).startDate;
  @override
  DateTime? get endDate => (origin as RoutineCompletionsProvider).endDate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
