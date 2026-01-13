/// Daily insight (Bible verse for Faith theme, Quote for Universal theme)
class Insight {
  final String id;
  final InsightType type;
  final String content;
  final String source;
  final String? reflection;

  const Insight({
    required this.id,
    required this.type,
    required this.content,
    required this.source,
    this.reflection,
  });

  Insight copyWith({
    String? id,
    InsightType? type,
    String? content,
    String? source,
    String? reflection,
  }) {
    return Insight(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      source: source ?? this.source,
      reflection: reflection ?? this.reflection,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Insight &&
        other.id == id &&
        other.type == type &&
        other.content == content &&
        other.source == source &&
        other.reflection == reflection;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        content.hashCode ^
        source.hashCode ^
        reflection.hashCode;
  }
}

/// Type of insight
enum InsightType {
  verse, // Bible verse (Faith theme)
  quote, // Inspirational quote (Universal theme)
}

extension InsightTypeX on InsightType {
  String get displayName {
    switch (this) {
      case InsightType.verse:
        return '말씀';
      case InsightType.quote:
        return '명언';
    }
  }

  String get emoji {
    switch (this) {
      case InsightType.verse:
        return '📖';
      case InsightType.quote:
        return '💡';
    }
  }
}
