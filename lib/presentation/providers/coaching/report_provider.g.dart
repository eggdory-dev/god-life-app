// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportListHash() => r'84ad3300cc4a04b02e93bb6b700dcb649b217e58';

/// Provider for getting all reports
///
/// Copied from [reportList].
@ProviderFor(reportList)
final reportListProvider =
    AutoDisposeFutureProvider<List<CoachingReport>>.internal(
  reportList,
  name: r'reportListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$reportListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReportListRef = AutoDisposeFutureProviderRef<List<CoachingReport>>;
String _$reportHash() => r'4272911ea286183d6cdac9659eb1a3a9bd4d75b6';

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

/// Provider for getting a single report by ID
///
/// Copied from [report].
@ProviderFor(report)
const reportProvider = ReportFamily();

/// Provider for getting a single report by ID
///
/// Copied from [report].
class ReportFamily extends Family<AsyncValue<CoachingReport>> {
  /// Provider for getting a single report by ID
  ///
  /// Copied from [report].
  const ReportFamily();

  /// Provider for getting a single report by ID
  ///
  /// Copied from [report].
  ReportProvider call(
    String reportId,
  ) {
    return ReportProvider(
      reportId,
    );
  }

  @override
  ReportProvider getProviderOverride(
    covariant ReportProvider provider,
  ) {
    return call(
      provider.reportId,
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
  String? get name => r'reportProvider';
}

/// Provider for getting a single report by ID
///
/// Copied from [report].
class ReportProvider extends AutoDisposeFutureProvider<CoachingReport> {
  /// Provider for getting a single report by ID
  ///
  /// Copied from [report].
  ReportProvider(
    String reportId,
  ) : this._internal(
          (ref) => report(
            ref as ReportRef,
            reportId,
          ),
          from: reportProvider,
          name: r'reportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reportHash,
          dependencies: ReportFamily._dependencies,
          allTransitiveDependencies: ReportFamily._allTransitiveDependencies,
          reportId: reportId,
        );

  ReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reportId,
  }) : super.internal();

  final String reportId;

  @override
  Override overrideWith(
    FutureOr<CoachingReport> Function(ReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReportProvider._internal(
        (ref) => create(ref as ReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reportId: reportId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CoachingReport> createElement() {
    return _ReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportProvider && other.reportId == reportId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReportRef on AutoDisposeFutureProviderRef<CoachingReport> {
  /// The parameter `reportId` of this provider.
  String get reportId;
}

class _ReportProviderElement
    extends AutoDisposeFutureProviderElement<CoachingReport> with ReportRef {
  _ReportProviderElement(super.provider);

  @override
  String get reportId => (origin as ReportProvider).reportId;
}

String _$generateReportHash() => r'a05c0317a534354430563305eef0cae9daab2592';

/// Provider for generating a report from a conversation
///
/// Copied from [generateReport].
@ProviderFor(generateReport)
const generateReportProvider = GenerateReportFamily();

/// Provider for generating a report from a conversation
///
/// Copied from [generateReport].
class GenerateReportFamily extends Family<AsyncValue<CoachingReport>> {
  /// Provider for generating a report from a conversation
  ///
  /// Copied from [generateReport].
  const GenerateReportFamily();

  /// Provider for generating a report from a conversation
  ///
  /// Copied from [generateReport].
  GenerateReportProvider call({
    required String conversationId,
  }) {
    return GenerateReportProvider(
      conversationId: conversationId,
    );
  }

  @override
  GenerateReportProvider getProviderOverride(
    covariant GenerateReportProvider provider,
  ) {
    return call(
      conversationId: provider.conversationId,
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
  String? get name => r'generateReportProvider';
}

/// Provider for generating a report from a conversation
///
/// Copied from [generateReport].
class GenerateReportProvider extends AutoDisposeFutureProvider<CoachingReport> {
  /// Provider for generating a report from a conversation
  ///
  /// Copied from [generateReport].
  GenerateReportProvider({
    required String conversationId,
  }) : this._internal(
          (ref) => generateReport(
            ref as GenerateReportRef,
            conversationId: conversationId,
          ),
          from: generateReportProvider,
          name: r'generateReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$generateReportHash,
          dependencies: GenerateReportFamily._dependencies,
          allTransitiveDependencies:
              GenerateReportFamily._allTransitiveDependencies,
          conversationId: conversationId,
        );

  GenerateReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.conversationId,
  }) : super.internal();

  final String conversationId;

  @override
  Override overrideWith(
    FutureOr<CoachingReport> Function(GenerateReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GenerateReportProvider._internal(
        (ref) => create(ref as GenerateReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        conversationId: conversationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CoachingReport> createElement() {
    return _GenerateReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GenerateReportProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GenerateReportRef on AutoDisposeFutureProviderRef<CoachingReport> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _GenerateReportProviderElement
    extends AutoDisposeFutureProviderElement<CoachingReport>
    with GenerateReportRef {
  _GenerateReportProviderElement(super.provider);

  @override
  String get conversationId =>
      (origin as GenerateReportProvider).conversationId;
}

String _$deleteReportHash() => r'5ec80ff003f684914364212a53ca638a6e77ed37';

/// Provider for deleting a report
///
/// Copied from [deleteReport].
@ProviderFor(deleteReport)
const deleteReportProvider = DeleteReportFamily();

/// Provider for deleting a report
///
/// Copied from [deleteReport].
class DeleteReportFamily extends Family<AsyncValue<void>> {
  /// Provider for deleting a report
  ///
  /// Copied from [deleteReport].
  const DeleteReportFamily();

  /// Provider for deleting a report
  ///
  /// Copied from [deleteReport].
  DeleteReportProvider call({
    required String reportId,
  }) {
    return DeleteReportProvider(
      reportId: reportId,
    );
  }

  @override
  DeleteReportProvider getProviderOverride(
    covariant DeleteReportProvider provider,
  ) {
    return call(
      reportId: provider.reportId,
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
  String? get name => r'deleteReportProvider';
}

/// Provider for deleting a report
///
/// Copied from [deleteReport].
class DeleteReportProvider extends AutoDisposeFutureProvider<void> {
  /// Provider for deleting a report
  ///
  /// Copied from [deleteReport].
  DeleteReportProvider({
    required String reportId,
  }) : this._internal(
          (ref) => deleteReport(
            ref as DeleteReportRef,
            reportId: reportId,
          ),
          from: deleteReportProvider,
          name: r'deleteReportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteReportHash,
          dependencies: DeleteReportFamily._dependencies,
          allTransitiveDependencies:
              DeleteReportFamily._allTransitiveDependencies,
          reportId: reportId,
        );

  DeleteReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reportId,
  }) : super.internal();

  final String reportId;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteReportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteReportProvider._internal(
        (ref) => create(ref as DeleteReportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reportId: reportId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteReportProvider && other.reportId == reportId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteReportRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `reportId` of this provider.
  String get reportId;
}

class _DeleteReportProviderElement
    extends AutoDisposeFutureProviderElement<void> with DeleteReportRef {
  _DeleteReportProviderElement(super.provider);

  @override
  String get reportId => (origin as DeleteReportProvider).reportId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
