/// Conversation entity (coaching chat session)
class Conversation {
  final String id;
  final String userId;
  final String title;
  final String? lastMessage;
  final int messageCount;
  final bool hasReport;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Conversation({
    required this.id,
    required this.userId,
    required this.title,
    this.lastMessage,
    this.messageCount = 0,
    this.hasReport = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Conversation copyWith({
    String? id,
    String? userId,
    String? title,
    String? lastMessage,
    int? messageCount,
    bool? hasReport,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Conversation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      lastMessage: lastMessage ?? this.lastMessage,
      messageCount: messageCount ?? this.messageCount,
      hasReport: hasReport ?? this.hasReport,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Conversation &&
        other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.lastMessage == lastMessage &&
        other.messageCount == messageCount &&
        other.hasReport == hasReport &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        lastMessage.hashCode ^
        messageCount.hashCode ^
        hasReport.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
