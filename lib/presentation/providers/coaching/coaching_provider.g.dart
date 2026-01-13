// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coaching_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conversationListHash() => r'c304be8e3522c010caf35ce6369a6f311360a551';

/// Provides list of conversations
///
/// Copied from [conversationList].
@ProviderFor(conversationList)
final conversationListProvider =
    AutoDisposeFutureProvider<List<Conversation>>.internal(
  conversationList,
  name: r'conversationListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$conversationListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConversationListRef = AutoDisposeFutureProviderRef<List<Conversation>>;
String _$coachingUsageHash() => r'c92819544002c74737e2bce4d787a45fc8df3f4d';

/// Provides coaching usage information
///
/// Copied from [coachingUsage].
@ProviderFor(coachingUsage)
final coachingUsageProvider = AutoDisposeFutureProvider<CoachingUsage>.internal(
  coachingUsage,
  name: r'coachingUsageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coachingUsageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CoachingUsageRef = AutoDisposeFutureProviderRef<CoachingUsage>;
String _$createConversationHash() =>
    r'95e90756e04683838ab61e96f9f9c0fa74e7a8ed';

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

/// Creates a new conversation
///
/// Copied from [createConversation].
@ProviderFor(createConversation)
const createConversationProvider = CreateConversationFamily();

/// Creates a new conversation
///
/// Copied from [createConversation].
class CreateConversationFamily extends Family<AsyncValue<Conversation>> {
  /// Creates a new conversation
  ///
  /// Copied from [createConversation].
  const CreateConversationFamily();

  /// Creates a new conversation
  ///
  /// Copied from [createConversation].
  CreateConversationProvider call({
    required String title,
  }) {
    return CreateConversationProvider(
      title: title,
    );
  }

  @override
  CreateConversationProvider getProviderOverride(
    covariant CreateConversationProvider provider,
  ) {
    return call(
      title: provider.title,
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
  String? get name => r'createConversationProvider';
}

/// Creates a new conversation
///
/// Copied from [createConversation].
class CreateConversationProvider
    extends AutoDisposeFutureProvider<Conversation> {
  /// Creates a new conversation
  ///
  /// Copied from [createConversation].
  CreateConversationProvider({
    required String title,
  }) : this._internal(
          (ref) => createConversation(
            ref as CreateConversationRef,
            title: title,
          ),
          from: createConversationProvider,
          name: r'createConversationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createConversationHash,
          dependencies: CreateConversationFamily._dependencies,
          allTransitiveDependencies:
              CreateConversationFamily._allTransitiveDependencies,
          title: title,
        );

  CreateConversationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.title,
  }) : super.internal();

  final String title;

  @override
  Override overrideWith(
    FutureOr<Conversation> Function(CreateConversationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateConversationProvider._internal(
        (ref) => create(ref as CreateConversationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        title: title,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Conversation> createElement() {
    return _CreateConversationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateConversationProvider && other.title == title;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, title.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateConversationRef on AutoDisposeFutureProviderRef<Conversation> {
  /// The parameter `title` of this provider.
  String get title;
}

class _CreateConversationProviderElement
    extends AutoDisposeFutureProviderElement<Conversation>
    with CreateConversationRef {
  _CreateConversationProviderElement(super.provider);

  @override
  String get title => (origin as CreateConversationProvider).title;
}

String _$deleteConversationHash() =>
    r'2fc40bb6ec65c97b82f7aac45fe175ea0d7af472';

/// Deletes a conversation
///
/// Copied from [deleteConversation].
@ProviderFor(deleteConversation)
const deleteConversationProvider = DeleteConversationFamily();

/// Deletes a conversation
///
/// Copied from [deleteConversation].
class DeleteConversationFamily extends Family<AsyncValue<void>> {
  /// Deletes a conversation
  ///
  /// Copied from [deleteConversation].
  const DeleteConversationFamily();

  /// Deletes a conversation
  ///
  /// Copied from [deleteConversation].
  DeleteConversationProvider call(
    String conversationId,
  ) {
    return DeleteConversationProvider(
      conversationId,
    );
  }

  @override
  DeleteConversationProvider getProviderOverride(
    covariant DeleteConversationProvider provider,
  ) {
    return call(
      provider.conversationId,
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
  String? get name => r'deleteConversationProvider';
}

/// Deletes a conversation
///
/// Copied from [deleteConversation].
class DeleteConversationProvider extends AutoDisposeFutureProvider<void> {
  /// Deletes a conversation
  ///
  /// Copied from [deleteConversation].
  DeleteConversationProvider(
    String conversationId,
  ) : this._internal(
          (ref) => deleteConversation(
            ref as DeleteConversationRef,
            conversationId,
          ),
          from: deleteConversationProvider,
          name: r'deleteConversationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteConversationHash,
          dependencies: DeleteConversationFamily._dependencies,
          allTransitiveDependencies:
              DeleteConversationFamily._allTransitiveDependencies,
          conversationId: conversationId,
        );

  DeleteConversationProvider._internal(
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
    FutureOr<void> Function(DeleteConversationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteConversationProvider._internal(
        (ref) => create(ref as DeleteConversationRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteConversationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteConversationProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteConversationRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _DeleteConversationProviderElement
    extends AutoDisposeFutureProviderElement<void> with DeleteConversationRef {
  _DeleteConversationProviderElement(super.provider);

  @override
  String get conversationId =>
      (origin as DeleteConversationProvider).conversationId;
}

String _$chatMessagesHash() => r'8ef4557f720f52351fc936090a535fab3e0990dc';

abstract class _$ChatMessages
    extends BuildlessAutoDisposeAsyncNotifier<List<Message>> {
  late final String conversationId;

  FutureOr<List<Message>> build(
    String conversationId,
  );
}

/// Provides messages for a specific conversation
///
/// Copied from [ChatMessages].
@ProviderFor(ChatMessages)
const chatMessagesProvider = ChatMessagesFamily();

/// Provides messages for a specific conversation
///
/// Copied from [ChatMessages].
class ChatMessagesFamily extends Family<AsyncValue<List<Message>>> {
  /// Provides messages for a specific conversation
  ///
  /// Copied from [ChatMessages].
  const ChatMessagesFamily();

  /// Provides messages for a specific conversation
  ///
  /// Copied from [ChatMessages].
  ChatMessagesProvider call(
    String conversationId,
  ) {
    return ChatMessagesProvider(
      conversationId,
    );
  }

  @override
  ChatMessagesProvider getProviderOverride(
    covariant ChatMessagesProvider provider,
  ) {
    return call(
      provider.conversationId,
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
  String? get name => r'chatMessagesProvider';
}

/// Provides messages for a specific conversation
///
/// Copied from [ChatMessages].
class ChatMessagesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChatMessages, List<Message>> {
  /// Provides messages for a specific conversation
  ///
  /// Copied from [ChatMessages].
  ChatMessagesProvider(
    String conversationId,
  ) : this._internal(
          () => ChatMessages()..conversationId = conversationId,
          from: chatMessagesProvider,
          name: r'chatMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatMessagesHash,
          dependencies: ChatMessagesFamily._dependencies,
          allTransitiveDependencies:
              ChatMessagesFamily._allTransitiveDependencies,
          conversationId: conversationId,
        );

  ChatMessagesProvider._internal(
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
  FutureOr<List<Message>> runNotifierBuild(
    covariant ChatMessages notifier,
  ) {
    return notifier.build(
      conversationId,
    );
  }

  @override
  Override overrideWith(ChatMessages Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatMessagesProvider._internal(
        () => create()..conversationId = conversationId,
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
  AutoDisposeAsyncNotifierProviderElement<ChatMessages, List<Message>>
      createElement() {
    return _ChatMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider &&
        other.conversationId == conversationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, conversationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatMessagesRef on AutoDisposeAsyncNotifierProviderRef<List<Message>> {
  /// The parameter `conversationId` of this provider.
  String get conversationId;
}

class _ChatMessagesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatMessages, List<Message>>
    with ChatMessagesRef {
  _ChatMessagesProviderElement(super.provider);

  @override
  String get conversationId => (origin as ChatMessagesProvider).conversationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
