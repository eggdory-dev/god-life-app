import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers/core_providers.dart';
import '../../../domain/entities/coaching_usage.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';

part 'coaching_provider.g.dart';

const _uuid = Uuid();

/// Provides list of conversations
@riverpod
Future<List<Conversation>> conversationList(ConversationListRef ref) async {
  final repo = ref.watch(coachingRepositoryProvider);
  final result = await repo.getConversations();
  return result.fold(
    (failure) => throw failure,
    (conversations) => conversations,
  );
}

/// Provides messages for a specific conversation
@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  Future<List<Message>> build(String conversationId) async {
    final repo = ref.watch(coachingRepositoryProvider);
    final result = await repo.getMessages(conversationId);
    return result.fold(
      (failure) => throw failure,
      (messages) => messages,
    );
  }

  /// Send a user message and receive AI response (streaming)
  Future<void> sendMessage(String content) async {
    final repo = ref.read(coachingRepositoryProvider);

    // Check usage limit first
    final usageResult = await repo.getUsage();
    await usageResult.fold(
      (failure) async => throw failure,
      (usage) async {
        if (usage.isLimitReached) {
          throw Exception('오늘의 무료 이용권을 모두 사용했습니다');
        }

        // Add user message immediately
        final userMessage = Message(
          id: _uuid.v4(),
          conversationId: conversationId,
          role: MessageRole.user,
          content: content,
          timestamp: DateTime.now(),
        );

        state = state.whenData((messages) => [...messages, userMessage]);

        // Prepare AI message (empty, will be filled during streaming)
        final aiMessageId = _uuid.v4();
        final aiMessage = Message(
          id: aiMessageId,
          conversationId: conversationId,
          role: MessageRole.assistant,
          content: '',
          isStreaming: true,
          timestamp: DateTime.now(),
        );

        state = state.whenData((messages) => [...messages, aiMessage]);

        // Stream AI response
        try {
          final stream = repo.sendMessageStream(
            conversationId: conversationId,
            content: content,
          );

          await for (final chunk in stream) {
            state = state.whenData((messages) {
              final lastIndex = messages.length - 1;
              final updatedMessage = messages[lastIndex].copyWith(
                content: messages[lastIndex].content + chunk,
              );
              return [
                ...messages.sublist(0, lastIndex),
                updatedMessage,
              ];
            });
          }

          // Mark streaming as complete
          state = state.whenData((messages) {
            final lastIndex = messages.length - 1;
            return [
              ...messages.sublist(0, lastIndex),
              messages[lastIndex].copyWith(isStreaming: false),
            ];
          });

          // Increment usage count
          await repo.incrementUsage();

          // Invalidate usage provider to reflect new count
          ref.invalidate(coachingUsageProvider);

          // Invalidate conversation list to update last message
          ref.invalidate(conversationListProvider);
        } catch (e) {
          // Remove AI message on error
          state = state.whenData((messages) {
            return messages
                .where((m) => m.id != aiMessageId)
                .toList();
          });
          rethrow;
        }
      },
    );
  }
}

/// Provides coaching usage information
@riverpod
Future<CoachingUsage> coachingUsage(CoachingUsageRef ref) async {
  final repo = ref.watch(coachingRepositoryProvider);
  final result = await repo.getUsage();
  return result.fold(
    (failure) => throw failure,
    (usage) => usage,
  );
}

/// Creates a new conversation
@riverpod
Future<Conversation> createConversation(
  CreateConversationRef ref, {
  required String title,
}) async {
  final repo = ref.read(coachingRepositoryProvider);
  final result = await repo.createConversation(title: title);

  return result.fold(
    (failure) => throw failure,
    (conversation) {
      // Invalidate conversation list to include new conversation
      ref.invalidate(conversationListProvider);
      return conversation;
    },
  );
}

/// Deletes a conversation
@riverpod
Future<void> deleteConversation(
  DeleteConversationRef ref,
  String conversationId,
) async {
  final repo = ref.read(coachingRepositoryProvider);
  final result = await repo.deleteConversation(conversationId);

  return result.fold(
    (failure) => throw failure,
    (_) {
      // Invalidate conversation list to remove deleted conversation
      ref.invalidate(conversationListProvider);
    },
  );
}
