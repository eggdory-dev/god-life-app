import 'routine.dart';

/// Coaching report generated from conversation
class CoachingReport {
  final String id;
  final String conversationId;
  final ReportDiagnosis diagnosis;
  final List<Recommendation> recommendations;
  final DateTime generatedAt;

  const CoachingReport({
    required this.id,
    required this.conversationId,
    required this.diagnosis,
    required this.recommendations,
    required this.generatedAt,
  });

  CoachingReport copyWith({
    String? id,
    String? conversationId,
    ReportDiagnosis? diagnosis,
    List<Recommendation>? recommendations,
    DateTime? generatedAt,
  }) {
    return CoachingReport(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      diagnosis: diagnosis ?? this.diagnosis,
      recommendations: recommendations ?? this.recommendations,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoachingReport &&
        other.id == id &&
        other.conversationId == conversationId &&
        other.diagnosis == diagnosis &&
        _listEquals(other.recommendations, recommendations) &&
        other.generatedAt == generatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conversationId.hashCode ^
        diagnosis.hashCode ^
        recommendations.hashCode ^
        generatedAt.hashCode;
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}

/// Report diagnosis (analysis of conversation)
class ReportDiagnosis {
  final String summary;
  final List<String> keyPoints;
  final List<String> strengths;
  final List<String> areasToImprove;

  const ReportDiagnosis({
    required this.summary,
    required this.keyPoints,
    required this.strengths,
    required this.areasToImprove,
  });

  ReportDiagnosis copyWith({
    String? summary,
    List<String>? keyPoints,
    List<String>? strengths,
    List<String>? areasToImprove,
  }) {
    return ReportDiagnosis(
      summary: summary ?? this.summary,
      keyPoints: keyPoints ?? this.keyPoints,
      strengths: strengths ?? this.strengths,
      areasToImprove: areasToImprove ?? this.areasToImprove,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportDiagnosis &&
        other.summary == summary &&
        _listEquals(other.keyPoints, keyPoints) &&
        _listEquals(other.strengths, strengths) &&
        _listEquals(other.areasToImprove, areasToImprove);
  }

  @override
  int get hashCode {
    return summary.hashCode ^
        keyPoints.hashCode ^
        strengths.hashCode ^
        areasToImprove.hashCode;
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}

/// Recommendation for new routine or improvement
class Recommendation {
  final String id;
  final String title;
  final String description;
  final RoutineCreateRequest? suggestedRoutine;
  final RecommendationPriority priority;

  const Recommendation({
    required this.id,
    required this.title,
    required this.description,
    this.suggestedRoutine,
    required this.priority,
  });

  Recommendation copyWith({
    String? id,
    String? title,
    String? description,
    RoutineCreateRequest? suggestedRoutine,
    RecommendationPriority? priority,
  }) {
    return Recommendation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      suggestedRoutine: suggestedRoutine ?? this.suggestedRoutine,
      priority: priority ?? this.priority,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recommendation &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.suggestedRoutine == suggestedRoutine &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        suggestedRoutine.hashCode ^
        priority.hashCode;
  }
}

/// Routine creation request (from recommendation)
class RoutineCreateRequest {
  final String name;
  final String? description;
  final String? category;
  final RoutineSchedule schedule;

  const RoutineCreateRequest({
    required this.name,
    this.description,
    this.category,
    required this.schedule,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoutineCreateRequest &&
        other.name == name &&
        other.description == description &&
        other.category == category &&
        other.schedule == schedule;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        category.hashCode ^
        schedule.hashCode;
  }
}

/// Recommendation priority
enum RecommendationPriority {
  high,
  medium,
  low,
}

extension RecommendationPriorityX on RecommendationPriority {
  String get displayName {
    switch (this) {
      case RecommendationPriority.high:
        return '높음';
      case RecommendationPriority.medium:
        return '보통';
      case RecommendationPriority.low:
        return '낮음';
    }
  }

  String get emoji {
    switch (this) {
      case RecommendationPriority.high:
        return '🔴';
      case RecommendationPriority.medium:
        return '🟡';
      case RecommendationPriority.low:
        return '🟢';
    }
  }
}
