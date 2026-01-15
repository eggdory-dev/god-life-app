// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'806c78b874d68f4213314049ca7003d2db817b9d';

/// Auth repository provider
/// Uses real Supabase implementation
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$authStateChangesHash() => r'ee5567fe7cf0509d3d1cca2850cfe375f6567759';

/// Stream provider for auth state changes
///
/// Copied from [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider = AutoDisposeStreamProvider<User?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = AutoDisposeStreamProviderRef<User?>;
String _$currentUserStreamHash() => r'54888efaeba20ee23e8337097c64cd7661f2289e';

/// Current user stream provider
///
/// Copied from [currentUserStream].
@ProviderFor(currentUserStream)
final currentUserStreamProvider = AutoDisposeStreamProvider<User?>.internal(
  currentUserStream,
  name: r'currentUserStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserStreamRef = AutoDisposeStreamProviderRef<User?>;
String _$isAuthenticatedHash() => r'62702a4a8e880feb041cdf459d2a91a7446fd407';

/// Is authenticated provider
///
/// Copied from [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$currentProfileHash() => r'd8abfe21ed42f52150c2e6f4efded4c35e940e03';

/// Current profile provider
///
/// Copied from [currentProfile].
@ProviderFor(currentProfile)
final currentProfileProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>?>.internal(
  currentProfile,
  name: r'currentProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentProfileRef = AutoDisposeFutureProviderRef<Map<String, dynamic>?>;
String _$onboardingCompletedHash() =>
    r'8407b90138263a5bbc347907a1748d42b4e643f5';

/// Onboarding completed provider
///
/// Copied from [onboardingCompleted].
@ProviderFor(onboardingCompleted)
final onboardingCompletedProvider = AutoDisposeFutureProvider<bool>.internal(
  onboardingCompleted,
  name: r'onboardingCompletedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingCompletedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OnboardingCompletedRef = AutoDisposeFutureProviderRef<bool>;
String _$authHash() => r'790ed5d35cd370d895d41c7f98360df5b80cb316';

/// Auth state provider
/// Manages current user authentication state
///
/// Copied from [Auth].
@ProviderFor(Auth)
final authProvider = AutoDisposeAsyncNotifierProvider<Auth, User?>.internal(
  Auth.new,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Auth = AutoDisposeAsyncNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
