enum AppTheme {
  faith,
  universal;

  String get displayName {
    switch (this) {
      case AppTheme.faith:
        return '신앙 기반';
      case AppTheme.universal:
        return '일반';
    }
  }
}

enum PersonalityType {
  feeling,
  thinking;

  String get displayName {
    switch (this) {
      case PersonalityType.feeling:
        return 'F (감정형)';
      case PersonalityType.thinking:
        return 'T (사고형)';
    }
  }

  String get description {
    switch (this) {
      case PersonalityType.feeling:
        return '공감과 격려를 선호하는 스타일';
      case PersonalityType.thinking:
        return '논리적이고 분석적인 스타일';
    }
  }
}

enum RoutineStatus {
  active,
  archived,
  deleted;
}

enum RoutineFrequency {
  daily,
  weekly,
  custom;

  String get displayName {
    switch (this) {
      case RoutineFrequency.daily:
        return '매일';
      case RoutineFrequency.weekly:
        return '주간';
      case RoutineFrequency.custom:
        return '커스텀';
    }
  }
}

enum CoachingSessionStatus {
  active,
  completed,
  expired;
}

enum ReportType {
  daily,
  weekly,
  monthly;

  String get displayName {
    switch (this) {
      case ReportType.daily:
        return '일일 리포트';
      case ReportType.weekly:
        return '주간 리포트';
      case ReportType.monthly:
        return '월간 리포트';
    }
  }
}

enum SubscriptionTier {
  free,
  pro;

  String get displayName {
    switch (this) {
      case SubscriptionTier.free:
        return '무료';
      case SubscriptionTier.pro:
        return 'Pro';
    }
  }
}

enum NotificationType {
  routineReminder,
  coachingAvailable,
  reportReady,
  streakMilestone;
}
