import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/core_providers.dart';
import '../../../domain/entities/coaching_report.dart';

part 'report_provider.g.dart';

/// Provider for getting all reports
@riverpod
Future<List<CoachingReport>> reportList(ReportListRef ref) async {
  final repo = ref.watch(coachingRepositoryProvider);
  final result = await repo.getReports();

  return result.fold(
    (failure) => throw failure,
    (reports) => reports,
  );
}

/// Provider for getting a single report by ID
@riverpod
Future<CoachingReport> report(ReportRef ref, String reportId) async {
  final repo = ref.watch(coachingRepositoryProvider);
  final result = await repo.getReport(reportId);

  return result.fold(
    (failure) => throw failure,
    (report) => report,
  );
}

/// Provider for generating a report from a conversation
@riverpod
Future<CoachingReport> generateReport(
  GenerateReportRef ref, {
  required String conversationId,
}) async {
  final repo = ref.watch(coachingRepositoryProvider);
  final result = await repo.generateReport(conversationId);

  return result.fold(
    (failure) => throw failure,
    (report) {
      // Invalidate report list to refresh
      ref.invalidate(reportListProvider);
      return report;
    },
  );
}

/// Provider for deleting a report
@riverpod
Future<void> deleteReport(
  DeleteReportRef ref, {
  required String reportId,
}) async {
  final repo = ref.watch(coachingRepositoryProvider);
  final result = await repo.deleteReport(reportId);

  return result.fold(
    (failure) => throw failure,
    (_) {
      // Invalidate report list to refresh
      ref.invalidate(reportListProvider);
    },
  );
}
