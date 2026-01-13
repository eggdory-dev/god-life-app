/// Message entity (chat message)
class Message {
  final String id;
  final String conversationId;
  final MessageRole role;
  final String content;
  final bool isStreaming;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    this.isStreaming = false,
    required this.timestamp,
  });

  Message copyWith({
    String? id,
    String? conversationId,
    MessageRole? role,
    String? content,
    bool? isStreaming,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      isStreaming: isStreaming ?? this.isStreaming,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.conversationId == conversationId &&
        other.role == role &&
        other.content == content &&
        other.isStreaming == isStreaming &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        conversationId.hashCode ^
        role.hashCode ^
        content.hashCode ^
        isStreaming.hashCode ^
        timestamp.hashCode;
  }
}

/// Message role (user or AI assistant)
enum MessageRole {
  user,
  assistant,
}

extension MessageRoleX on MessageRole {
  String get displayName {
    switch (this) {
      case MessageRole.user:
        return '나';
      case MessageRole.assistant:
        return 'AI 코치';
    }
  }
}
