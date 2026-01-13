import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/coaching_report.dart';
import '../entities/coaching_usage.dart';
import '../entities/conversation.dart';
import '../entities/message.dart';

/// Repository interface for coaching/AI chat
abstract class CoachingRepository {
  /// Get all conversations for current user
  Future<Either<Failure, List<Conversation>>> getConversations();

  /// Get a single conversation by ID
  Future<Either<Failure, Conversation>> getConversation(String conversationId);

  /// Create a new conversation
  Future<Either<Failure, Conversation>> createConversation({
    required String title,
  });

  /// Delete a conversation
  Future<Either<Failure, void>> deleteConversation(String conversationId);

  /// Get all messages in a conversation
  Future<Either<Failure, List<Message>>> getMessages(String conversationId);

  /// Send a message and get streaming response
  /// Returns a stream of response chunks (word by word)
  Stream<String> sendMessageStream({
    required String conversationId,
    required String content,
  });

  /// Get current coaching usage
  Future<Either<Failure, CoachingUsage>> getUsage();

  /// Increment usage count (called after successful message)
  Future<Either<Failure, CoachingUsage>> incrementUsage();

  /// Reset daily usage (called at midnight)
  Future<Either<Failure, void>> resetDailyUsage();

  /// Generate a report from conversation
  Future<Either<Failure, CoachingReport>> generateReport(String conversationId);

  /// Get all reports for current user
  Future<Either<Failure, List<CoachingReport>>> getReports();

  /// Get a specific report by ID
  Future<Either<Failure, CoachingReport>> getReport(String reportId);

  /// Delete a report
  Future<Either<Failure, void>> deleteReport(String reportId);
}
