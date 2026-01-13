import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enums.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/coaching_report.dart';
import '../../../domain/entities/coaching_usage.dart';
import '../../../domain/entities/conversation.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/entities/routine.dart';
import '../../../domain/repositories/coaching_repository.dart';

/// Mock implementation of CoachingRepository
/// Generates responses based on user's personality type (F or T)
class MockCoachingRepository implements CoachingRepository {
  final SharedPreferences _prefs;
  final _uuid = const Uuid();

  // In-memory storage for conversations and messages
  final List<Conversation> _conversations = [];
  final Map<String, List<Message>> _messages = {};
  final List<CoachingReport> _reports = [];

  // Storage keys
  static const String _usageCountKey = 'coaching_usage_count';
  static const String _usageDateKey = 'coaching_usage_date';
  static const int _dailyLimit = 3; // Free tier limit

  MockCoachingRepository(this._prefs) {
    _initializeMockData();
  }

  void _initializeMockData() {
    // Initialize with one sample conversation
    final sampleConversation = Conversation(
      id: 'conv_001',
      userId: 'user_001',
      title: '루틴 관리 상담',
      lastMessage: '화이팅! 함께 해보아요.',
      messageCount: 4,
      hasReport: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    );

    _conversations.add(sampleConversation);

    _messages[sampleConversation.id] = [
      Message(
        id: 'msg_001',
        conversationId: sampleConversation.id,
        role: MessageRole.user,
        content: '루틴을 지키기가 힘들어요',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Message(
        id: 'msg_002',
        conversationId: sampleConversation.id,
        role: MessageRole.assistant,
        content: '많이 힘드시겠어요. 충분히 이해됩니다. 어떤 부분이 특히 어려우신가요?',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Message(
        id: 'msg_003',
        conversationId: sampleConversation.id,
        role: MessageRole.user,
        content: '아침에 일찍 일어나는 게 힘들어요',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Message(
        id: 'msg_004',
        conversationId: sampleConversation.id,
        role: MessageRole.assistant,
        content: '아침에 일찍 일어나는 것은 정말 어려운 도전이에요. 작은 것부터 시작해보면 어떨까요? 화이팅! 함께 해보아요.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  @override
  Future<Either<Failure, List<Conversation>>> getConversations() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Sort by most recent first
      final sorted = _conversations.toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return Right(sorted);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Conversation>> getConversation(
    String conversationId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final conversation = _conversations.firstWhere(
        (c) => c.id == conversationId,
        orElse: () => throw Exception('Conversation not found'),
      );
      return Right(conversation);
    } catch (e) {
      return Left(Failure.notFound(message: '대화를 찾을 수 없습니다'));
    }
  }

  @override
  Future<Either<Failure, Conversation>> createConversation({
    required String title,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final conversation = Conversation(
        id: _uuid.v4(),
        userId: 'user_001', // Mock user ID
        title: title,
        messageCount: 0,
        hasReport: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      _conversations.add(conversation);
      _messages[conversation.id] = [];

      return Right(conversation);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteConversation(
    String conversationId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      _conversations.removeWhere((c) => c.id == conversationId);
      _messages.remove(conversationId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages(
    String conversationId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final messages = _messages[conversationId] ?? [];
      return Right(messages);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Stream<String> sendMessageStream({
    required String conversationId,
    required String content,
  }) async* {
    // Add user message
    final userMessage = Message(
      id: _uuid.v4(),
      conversationId: conversationId,
      role: MessageRole.user,
      content: content,
      timestamp: DateTime.now(),
    );

    _messages[conversationId]?.add(userMessage);

    // Update conversation
    final convIndex = _conversations.indexWhere((c) => c.id == conversationId);
    if (convIndex != -1) {
      _conversations[convIndex] = _conversations[convIndex].copyWith(
        lastMessage: content,
        messageCount: _conversations[convIndex].messageCount + 1,
        updatedAt: DateTime.now(),
      );
    }

    // Simulate delay before response
    await Future.delayed(const Duration(milliseconds: 500));

    // Get personality type (mock - in real app, get from auth provider)
    // For now, randomly choose F or T for demonstration
    final personalityType = DateTime.now().second % 2 == 0
        ? PersonalityType.feeling
        : PersonalityType.thinking;

    // Generate response based on personality type
    final response = _generateResponse(content, personalityType);

    // Add assistant message (will be populated during streaming)
    final assistantMessage = Message(
      id: _uuid.v4(),
      conversationId: conversationId,
      role: MessageRole.assistant,
      content: '', // Will be built during streaming
      isStreaming: true,
      timestamp: DateTime.now(),
    );

    _messages[conversationId]?.add(assistantMessage);

    // Split response into words and stream them
    final words = response.split(' ');

    for (int i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      final word = words[i];
      yield i == words.length - 1 ? word : '$word ';

      // Update message content in storage
      final messageIndex = _messages[conversationId]!
          .indexWhere((m) => m.id == assistantMessage.id);
      if (messageIndex != -1) {
        final currentContent =
            _messages[conversationId]![messageIndex].content;
        _messages[conversationId]![messageIndex] = _messages[conversationId]![
                messageIndex]
            .copyWith(
          content: i == words.length - 1
              ? '$currentContent$word'
              : '$currentContent$word ',
        );
      }
    }

    // Mark streaming as complete
    final messageIndex = _messages[conversationId]!
        .indexWhere((m) => m.id == assistantMessage.id);
    if (messageIndex != -1) {
      _messages[conversationId]![messageIndex] =
          _messages[conversationId]![messageIndex].copyWith(
        isStreaming: false,
      );
    }

    // Update conversation with last message
    if (convIndex != -1) {
      _conversations[convIndex] = _conversations[convIndex].copyWith(
        lastMessage: response,
        messageCount: _conversations[convIndex].messageCount + 1,
        updatedAt: DateTime.now(),
      );
    }
  }

  /// Generate response based on personality type and message content
  String _generateResponse(String message, PersonalityType personalityType) {
    final messageLower = message.toLowerCase();

    if (personalityType == PersonalityType.feeling) {
      // F type: Empathetic and supportive
      if (messageLower.contains('힘들') ||
          messageLower.contains('어렵') ||
          messageLower.contains('못하겠')) {
        return '많이 힘드시겠어요. 충분히 이해됩니다. 하나씩 천천히 해보면 어떨까요? 저도 함께할게요.';
      } else if (messageLower.contains('잘') ||
          messageLower.contains('성공') ||
          messageLower.contains('했어요')) {
        return '정말 잘하고 계세요! 스스로 대견하게 여기셔도 좋을 것 같아요. 어떤 점이 특히 뿌듯하셨나요?';
      } else if (messageLower.contains('방법') || messageLower.contains('어떻게')) {
        return '좋은 질문이에요! 제 생각에는 작은 목표부터 시작하는 게 좋을 것 같아요. 함께 계획을 세워볼까요?';
      } else if (messageLower.contains('포기') || messageLower.contains('그만')) {
        return '포기하고 싶은 마음 충분히 이해해요. 하지만 여기까지 오신 것만으로도 대단하다고 생각해요. 잠시 쉬어가는 건 어떨까요?';
      } else {
        return '더 자세히 말씀해주시겠어요? 어떤 부분에서 도움이 필요하신지 알려주시면 함께 생각해볼게요.';
      }
    } else {
      // T type: Analytical and solution-focused
      if (messageLower.contains('힘들') ||
          messageLower.contains('어렵') ||
          messageLower.contains('못하겠')) {
        return '구체적으로 어떤 부분이 어려우신가요? 문제를 작게 나눠서 하나씩 해결해봅시다.';
      } else if (messageLower.contains('잘') ||
          messageLower.contains('성공') ||
          messageLower.contains('했어요')) {
        return '좋은 성과네요. 어떤 전략이 효과적이었는지 분석해보면 다음에도 활용할 수 있을 거예요.';
      } else if (messageLower.contains('방법') || messageLower.contains('어떻게')) {
        return '목표를 구체적으로 정의하고, 실행 가능한 단계로 나눠보세요. 각 단계마다 명확한 기준을 설정하면 도움이 될 거예요.';
      } else if (messageLower.contains('포기') || messageLower.contains('그만')) {
        return '현재 접근 방식이 효과적이지 않다면, 다른 방법을 시도해볼 필요가 있어요. 어떤 부분을 개선하면 좋을지 분석해봅시다.';
      } else {
        return '상황을 더 정확히 파악하기 위해 추가 정보가 필요해요. 구체적으로 어떤 도움을 원하시나요?';
      }
    }
  }

  @override
  Future<Either<Failure, CoachingUsage>> getUsage() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final today = DateTime.now();
      final savedDate = _prefs.getString(_usageDateKey);
      final savedCount = _prefs.getInt(_usageCountKey) ?? 0;

      // Check if saved date is today
      final isToday = savedDate == _formatDate(today);

      final usage = CoachingUsage(
        date: today,
        dailyCount: isToday ? savedCount : 0,
        dailyLimit: _dailyLimit,
        resetAt: _getNextMidnight(today),
      );

      // Reset if new day
      if (!isToday) {
        await _prefs.setString(_usageDateKey, _formatDate(today));
        await _prefs.setInt(_usageCountKey, 0);
      }

      return Right(usage);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoachingUsage>> incrementUsage() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final today = DateTime.now();
      final savedCount = _prefs.getInt(_usageCountKey) ?? 0;
      final newCount = savedCount + 1;

      await _prefs.setString(_usageDateKey, _formatDate(today));
      await _prefs.setInt(_usageCountKey, newCount);

      final usage = CoachingUsage(
        date: today,
        dailyCount: newCount,
        dailyLimit: _dailyLimit,
        resetAt: _getNextMidnight(today),
      );

      return Right(usage);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetDailyUsage() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final today = DateTime.now();
      await _prefs.setString(_usageDateKey, _formatDate(today));
      await _prefs.setInt(_usageCountKey, 0);

      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  DateTime _getNextMidnight(DateTime date) {
    return DateTime(date.year, date.month, date.day + 1);
  }

  @override
  Future<Either<Failure, CoachingReport>> generateReport(
    String conversationId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));

      // Get conversation messages
      final messagesResult = await getMessages(conversationId);
      final messages = messagesResult.fold(
        (failure) => throw failure,
        (messages) => messages,
      );

      if (messages.length < 4) {
        return Left(Failure.validation(
          message: '리포트 생성을 위해서는 최소 4개 이상의 메시지가 필요합니다',
        ));
      }

      // Analyze messages to extract keywords
      final userMessages = messages
          .where((m) => m.role == MessageRole.user)
          .map((m) => m.content)
          .join(' ');

      final keywords = _extractKeywords(userMessages);

      // Create diagnosis
      final diagnosis = ReportDiagnosis(
        summary: keywords['struggle'] != null
            ? '최근 ${keywords['struggle']}에 대해 고민하고 계시네요. ${keywords['insight']}'
            : '루틴 실천에 대한 고민과 성찰을 나누셨습니다.',
        keyPoints: [
          if (keywords['frequency'] != null)
            '${keywords['frequency']} 패턴을 보이고 있습니다',
          if (keywords['emotion'] != null)
            '${keywords['emotion']}의 감정을 자주 표현하셨어요',
          '${messages.length ~/ 2}번의 대화를 통해 깊이 있는 성찰을 하셨습니다',
        ],
        strengths: [
          '자기 성찰적인 태도',
          '꾸준한 실천 의지',
          if (keywords['positive'] != null) '긍정적인 마인드',
        ],
        areasToImprove: [
          if (keywords['perfectionism']) '완벽주의 성향 조절',
          if (keywords['selfCriticism']) '자기 비판 완화',
          '작은 성공 경험 쌓기',
        ],
      );

      // Generate recommendations based on keywords
      final recommendations = _generateRecommendations(keywords);

      final report = CoachingReport(
        id: _uuid.v4(),
        conversationId: conversationId,
        diagnosis: diagnosis,
        recommendations: recommendations,
        generatedAt: DateTime.now(),
      );

      _reports.add(report);

      // Update conversation to mark it has report
      final convIndex =
          _conversations.indexWhere((c) => c.id == conversationId);
      if (convIndex != -1) {
        _conversations[convIndex] =
            _conversations[convIndex].copyWith(hasReport: true);
      }

      return Right(report);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CoachingReport>>> getReports() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      // Sort by most recent first
      final sorted = _reports.toList()
        ..sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
      return Right(sorted);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoachingReport>> getReport(String reportId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      final report = _reports.firstWhere(
        (r) => r.id == reportId,
        orElse: () => throw Exception('Report not found'),
      );
      return Right(report);
    } catch (e) {
      return Left(Failure.notFound(message: '리포트를 찾을 수 없습니다'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReport(String reportId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      _reports.removeWhere((r) => r.id == reportId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }

  /// Extract keywords from user messages for report generation
  Map<String, dynamic> _extractKeywords(String text) {
    final lower = text.toLowerCase();
    final keywords = <String, dynamic>{};

    // Identify struggle area
    if (lower.contains('루틴') || lower.contains('습관')) {
      keywords['struggle'] = '루틴 유지';
    } else if (lower.contains('일찍') || lower.contains('아침')) {
      keywords['struggle'] = '아침 시간 관리';
    } else if (lower.contains('운동') || lower.contains('건강')) {
      keywords['struggle'] = '건강 관리';
    } else if (lower.contains('기도') || lower.contains('묵상')) {
      keywords['struggle'] = '영적 성장';
    }

    // Identify frequency pattern
    if (lower.contains('매일') || lower.contains('항상')) {
      keywords['frequency'] = '매일 실천하려는';
    } else if (lower.contains('가끔') || lower.contains('때때로')) {
      keywords['frequency'] = '간헐적인';
    } else if (lower.contains('자주') || lower.contains('종종')) {
      keywords['frequency'] = '자주 시도하는';
    }

    // Identify emotions
    if (lower.contains('힘들') || lower.contains('어렵')) {
      keywords['emotion'] = '어려움과 좌절감';
    } else if (lower.contains('잘') || lower.contains('성공')) {
      keywords['emotion'] = '성취감과 기쁨';
      keywords['positive'] = true;
    } else if (lower.contains('포기') || lower.contains('그만')) {
      keywords['emotion'] = '포기하고 싶은 마음';
    }

    // Identify personality traits
    keywords['perfectionism'] = lower.contains('완벽') || lower.contains('제대로');
    keywords['selfCriticism'] = lower.contains('못') || lower.contains('안 돼');

    // Generate insight
    if (keywords['emotion'] == '어려움과 좌절감') {
      keywords['insight'] = '작은 것부터 시작하면 충분히 해낼 수 있어요.';
    } else if (keywords['positive'] == true) {
      keywords['insight'] = '이미 좋은 변화를 만들어가고 계시네요.';
    } else {
      keywords['insight'] = '함께 방법을 찾아가면 돼요.';
    }

    return keywords;
  }

  /// Generate recommendations based on extracted keywords
  List<Recommendation> _generateRecommendations(Map<String, dynamic> keywords) {
    final recommendations = <Recommendation>[];

    // High priority: Morning routine
    if (keywords['struggle'] == '아침 시간 관리' ||
        keywords['struggle'] == '루틴 유지') {
      recommendations.add(
        Recommendation(
          id: _uuid.v4(),
          title: '아침 감사 일기',
          description:
              '하루를 긍정적으로 시작하는 습관입니다. 매일 아침 감사한 일 3가지를 적어보세요. 작은 것부터 시작하면 아침 루틴이 자연스럽게 자리 잡힐 거예요.',
          suggestedRoutine: RoutineCreateRequest(
            name: '감사 일기 3줄',
            description: '오늘 감사한 일 3가지 적기',
            category: '영성',
            schedule: RoutineSchedule(
              frequency: RoutineFrequency.daily,
              days: [1, 2, 3, 4, 5, 6, 7],
              time: '07:00',
              reminderEnabled: true,
              reminderMinutesBefore: 0,
            ),
          ),
          priority: RecommendationPriority.high,
        ),
      );
    }

    // Medium priority: Evening reflection
    if (keywords['selfCriticism'] == true ||
        keywords['perfectionism'] == true) {
      recommendations.add(
        Recommendation(
          id: _uuid.v4(),
          title: '저녁 성찰 시간',
          description:
              '하루를 돌아보며 스스로를 격려하는 시간입니다. 완벽하지 않아도 괜찮아요. 오늘 잘한 일 하나만 떠올려보세요.',
          suggestedRoutine: RoutineCreateRequest(
            name: '저녁 성찰 5분',
            description: '오늘 잘한 일 1가지 떠올리기',
            category: '성장',
            schedule: RoutineSchedule(
              frequency: RoutineFrequency.daily,
              days: [1, 2, 3, 4, 5, 6, 7],
              time: '21:00',
              reminderEnabled: true,
              reminderMinutesBefore: 10,
            ),
          ),
          priority: RecommendationPriority.medium,
        ),
      );
    }

    // Low priority: Weekly review
    recommendations.add(
      Recommendation(
        id: _uuid.v4(),
        title: '주간 돌아보기',
        description:
            '일주일에 한 번, 전체적인 흐름을 돌아보는 시간입니다. 성공과 실패 모두에서 배울 점을 찾아보세요.',
        suggestedRoutine: RoutineCreateRequest(
          name: '주간 회고',
          description: '일주일 동안의 루틴 실천 돌아보기',
          category: '성장',
          schedule: RoutineSchedule(
            frequency: RoutineFrequency.weekly,
            days: [7], // Sunday
            time: '20:00',
            reminderEnabled: true,
            reminderMinutesBefore: 30,
          ),
        ),
        priority: RecommendationPriority.low,
      ),
    );

    return recommendations;
  }
}
