/// Coaching usage tracking (daily limit)
class CoachingUsage {
  final DateTime date;
  final int dailyCount;
  final int dailyLimit;
  final DateTime resetAt;

  const CoachingUsage({
    required this.date,
    required this.dailyCount,
    required this.dailyLimit,
    required this.resetAt,
  });

  /// Check if user has reached daily limit
  bool get isLimitReached => dailyCount >= dailyLimit;

  /// Get remaining usage count
  int get remaining => dailyLimit - dailyCount;

  CoachingUsage copyWith({
    DateTime? date,
    int? dailyCount,
    int? dailyLimit,
    DateTime? resetAt,
  }) {
    return CoachingUsage(
      date: date ?? this.date,
      dailyCount: dailyCount ?? this.dailyCount,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      resetAt: resetAt ?? this.resetAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoachingUsage &&
        other.date == date &&
        other.dailyCount == dailyCount &&
        other.dailyLimit == dailyLimit &&
        other.resetAt == resetAt;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        dailyCount.hashCode ^
        dailyLimit.hashCode ^
        resetAt.hashCode;
  }
}
