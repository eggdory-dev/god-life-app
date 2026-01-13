// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayInsightHash() => r'50dca7cba5bb195e449b6bbab3a3d5d469555d13';

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

/// Provides today's insight based on user's theme
///
/// Copied from [todayInsight].
@ProviderFor(todayInsight)
const todayInsightProvider = TodayInsightFamily();

/// Provides today's insight based on user's theme
///
/// Copied from [todayInsight].
class TodayInsightFamily extends Family<AsyncValue<Insight>> {
  /// Provides today's insight based on user's theme
  ///
  /// Copied from [todayInsight].
  const TodayInsightFamily();

  /// Provides today's insight based on user's theme
  ///
  /// Copied from [todayInsight].
  TodayInsightProvider call({
    DateTime? date,
  }) {
    return TodayInsightProvider(
      date: date,
    );
  }

  @override
  TodayInsightProvider getProviderOverride(
    covariant TodayInsightProvider provider,
  ) {
    return call(
      date: provider.date,
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
  String? get name => r'todayInsightProvider';
}

/// Provides today's insight based on user's theme
///
/// Copied from [todayInsight].
class TodayInsightProvider extends AutoDisposeFutureProvider<Insight> {
  /// Provides today's insight based on user's theme
  ///
  /// Copied from [todayInsight].
  TodayInsightProvider({
    DateTime? date,
  }) : this._internal(
          (ref) => todayInsight(
            ref as TodayInsightRef,
            date: date,
          ),
          from: todayInsightProvider,
          name: r'todayInsightProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todayInsightHash,
          dependencies: TodayInsightFamily._dependencies,
          allTransitiveDependencies:
              TodayInsightFamily._allTransitiveDependencies,
          date: date,
        );

  TodayInsightProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime? date;

  @override
  Override overrideWith(
    FutureOr<Insight> Function(TodayInsightRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TodayInsightProvider._internal(
        (ref) => create(ref as TodayInsightRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Insight> createElement() {
    return _TodayInsightProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodayInsightProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodayInsightRef on AutoDisposeFutureProviderRef<Insight> {
  /// The parameter `date` of this provider.
  DateTime? get date;
}

class _TodayInsightProviderElement
    extends AutoDisposeFutureProviderElement<Insight> with TodayInsightRef {
  _TodayInsightProviderElement(super.provider);

  @override
  DateTime? get date => (origin as TodayInsightProvider).date;
}

String _$homeDataHash() => r'93012fa51a8576d844945ce6876cf4be572aff64';

/// Provides aggregated home data
///
/// Copied from [homeData].
@ProviderFor(homeData)
const homeDataProvider = HomeDataFamily();

/// Provides aggregated home data
///
/// Copied from [homeData].
class HomeDataFamily extends Family<AsyncValue<HomeData>> {
  /// Provides aggregated home data
  ///
  /// Copied from [homeData].
  const HomeDataFamily();

  /// Provides aggregated home data
  ///
  /// Copied from [homeData].
  HomeDataProvider call({
    DateTime? date,
  }) {
    return HomeDataProvider(
      date: date,
    );
  }

  @override
  HomeDataProvider getProviderOverride(
    covariant HomeDataProvider provider,
  ) {
    return call(
      date: provider.date,
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
  String? get name => r'homeDataProvider';
}

/// Provides aggregated home data
///
/// Copied from [homeData].
class HomeDataProvider extends AutoDisposeFutureProvider<HomeData> {
  /// Provides aggregated home data
  ///
  /// Copied from [homeData].
  HomeDataProvider({
    DateTime? date,
  }) : this._internal(
          (ref) => homeData(
            ref as HomeDataRef,
            date: date,
          ),
          from: homeDataProvider,
          name: r'homeDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$homeDataHash,
          dependencies: HomeDataFamily._dependencies,
          allTransitiveDependencies: HomeDataFamily._allTransitiveDependencies,
          date: date,
        );

  HomeDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime? date;

  @override
  Override overrideWith(
    FutureOr<HomeData> Function(HomeDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HomeDataProvider._internal(
        (ref) => create(ref as HomeDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<HomeData> createElement() {
    return _HomeDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeDataProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HomeDataRef on AutoDisposeFutureProviderRef<HomeData> {
  /// The parameter `date` of this provider.
  DateTime? get date;
}

class _HomeDataProviderElement
    extends AutoDisposeFutureProviderElement<HomeData> with HomeDataRef {
  _HomeDataProviderElement(super.provider);

  @override
  DateTime? get date => (origin as HomeDataProvider).date;
}

String _$weeklyStatsHash() => r'e3977e77620aa73217aa5913115f73ac2a58fb01';

/// Provides weekly statistics
///
/// Copied from [weeklyStats].
@ProviderFor(weeklyStats)
const weeklyStatsProvider = WeeklyStatsFamily();

/// Provides weekly statistics
///
/// Copied from [weeklyStats].
class WeeklyStatsFamily extends Family<AsyncValue<WeeklyStats>> {
  /// Provides weekly statistics
  ///
  /// Copied from [weeklyStats].
  const WeeklyStatsFamily();

  /// Provides weekly statistics
  ///
  /// Copied from [weeklyStats].
  WeeklyStatsProvider call({
    DateTime? date,
  }) {
    return WeeklyStatsProvider(
      date: date,
    );
  }

  @override
  WeeklyStatsProvider getProviderOverride(
    covariant WeeklyStatsProvider provider,
  ) {
    return call(
      date: provider.date,
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
  String? get name => r'weeklyStatsProvider';
}

/// Provides weekly statistics
///
/// Copied from [weeklyStats].
class WeeklyStatsProvider extends AutoDisposeFutureProvider<WeeklyStats> {
  /// Provides weekly statistics
  ///
  /// Copied from [weeklyStats].
  WeeklyStatsProvider({
    DateTime? date,
  }) : this._internal(
          (ref) => weeklyStats(
            ref as WeeklyStatsRef,
            date: date,
          ),
          from: weeklyStatsProvider,
          name: r'weeklyStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weeklyStatsHash,
          dependencies: WeeklyStatsFamily._dependencies,
          allTransitiveDependencies:
              WeeklyStatsFamily._allTransitiveDependencies,
          date: date,
        );

  WeeklyStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime? date;

  @override
  Override overrideWith(
    FutureOr<WeeklyStats> Function(WeeklyStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeeklyStatsProvider._internal(
        (ref) => create(ref as WeeklyStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WeeklyStats> createElement() {
    return _WeeklyStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklyStatsProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WeeklyStatsRef on AutoDisposeFutureProviderRef<WeeklyStats> {
  /// The parameter `date` of this provider.
  DateTime? get date;
}

class _WeeklyStatsProviderElement
    extends AutoDisposeFutureProviderElement<WeeklyStats> with WeeklyStatsRef {
  _WeeklyStatsProviderElement(super.provider);

  @override
  DateTime? get date => (origin as WeeklyStatsProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
