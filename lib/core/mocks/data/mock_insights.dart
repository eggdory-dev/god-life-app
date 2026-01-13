import '../../../domain/entities/insight.dart';
import '../../../core/constants/enums.dart';

/// Mock insights data for both Faith and Universal themes
class MockInsights {
  /// Faith theme insights (Bible verses)
  static final List<Insight> faithInsights = [
    const Insight(
      id: 'faith_001',
      type: InsightType.verse,
      content: '항상 기뻐하라 쉬지 말고 기도하라 범사에 감사하라',
      source: '데살로니가전서 5:16-18',
      reflection: '매일 감사의 마음으로 하루를 시작하고, 기도로 하나님과 교제하세요.',
    ),
    const Insight(
      id: 'faith_002',
      type: InsightType.verse,
      content: '내게 능력 주시는 자 안에서 내가 모든 것을 할 수 있느니라',
      source: '빌립보서 4:13',
      reflection: '오늘도 하나님의 능력으로 모든 도전을 이겨낼 수 있습니다.',
    ),
    const Insight(
      id: 'faith_003',
      type: InsightType.verse,
      content: '너희는 먼저 그의 나라와 그의 의를 구하라 그리하면 이 모든 것을 너희에게 더하시리라',
      source: '마태복음 6:33',
      reflection: '하나님을 먼저 구할 때, 필요한 모든 것이 채워집니다.',
    ),
    const Insight(
      id: 'faith_004',
      type: InsightType.verse,
      content: '여호와를 기뻐하는 것이 너희의 힘이니라',
      source: '느헤미야 8:10',
      reflection: '주님 안에서 기쁨을 찾을 때, 진정한 힘이 생깁니다.',
    ),
    const Insight(
      id: 'faith_005',
      type: InsightType.verse,
      content: '주께서 네게 복을 주시고 너를 지키시기를 원하며',
      source: '민수기 6:24',
      reflection: '하나님의 보호하심과 축복하심을 믿고 나아가세요.',
    ),
    const Insight(
      id: 'faith_006',
      type: InsightType.verse,
      content: '우리가 알거니와 하나님을 사랑하는 자 곧 그의 뜻대로 부르심을 입은 자들에게는 모든 것이 합력하여 선을 이루느니라',
      source: '로마서 8:28',
      reflection: '모든 상황 속에서 하나님의 선한 계획을 신뢰하세요.',
    ),
    const Insight(
      id: 'faith_007',
      type: InsightType.verse,
      content: '너는 마음을 다하여 여호와를 신뢰하고 네 명철을 의지하지 말라',
      source: '잠언 3:5',
      reflection: '내 생각이 아닌 하나님의 지혜를 따라가세요.',
    ),
    const Insight(
      id: 'faith_008',
      type: InsightType.verse,
      content: '수고하고 무거운 짐 진 자들아 다 내게로 오라 내가 너희를 쉬게 하리라',
      source: '마태복음 11:28',
      reflection: '힘들 때 주님께 나아가 참된 쉼을 얻으세요.',
    ),
    const Insight(
      id: 'faith_009',
      type: InsightType.verse,
      content: '아무 것도 염려하지 말고 다만 모든 일에 기도와 간구로 너희 구할 것을 감사함으로 하나님께 아뢰라',
      source: '빌립보서 4:6',
      reflection: '염려 대신 기도로, 불안 대신 감사로 하나님께 나아가세요.',
    ),
    const Insight(
      id: 'faith_010',
      type: InsightType.verse,
      content: '새 힘을 얻으리니 독수리가 날개치며 올라감 같을 것이요',
      source: '이사야 40:31',
      reflection: '주님을 기다리는 자는 새 힘을 얻어 높이 날 것입니다.',
    ),
  ];

  /// Universal theme insights (Inspirational quotes)
  static final List<Insight> universalInsights = [
    const Insight(
      id: 'universal_001',
      type: InsightType.quote,
      content: '위대한 일을 이루기 위해서는 행동하는 것뿐만 아니라 꿈을 꾸는 것도 필요하다',
      source: '아나톨 프랑스',
      reflection: '오늘 당신의 꿈을 향해 작은 행동을 시작해보세요.',
    ),
    const Insight(
      id: 'universal_002',
      type: InsightType.quote,
      content: '작은 것이 모여 큰 것을 이룬다',
      source: '아리스토텔레스',
      reflection: '매일의 작은 실천이 모여 큰 변화를 만듭니다.',
    ),
    const Insight(
      id: 'universal_003',
      type: InsightType.quote,
      content: '성공은 매일 반복한 작은 노력들의 합이다',
      source: '로버트 콜리어',
      reflection: '오늘도 꾸준히 나아가는 것이 성공의 비결입니다.',
    ),
    const Insight(
      id: 'universal_004',
      type: InsightType.quote,
      content: '할 수 있다고 믿으면 이미 절반은 이룬 것이다',
      source: '시어도어 루스벨트',
      reflection: '자신을 믿고 도전하는 용기를 가지세요.',
    ),
    const Insight(
      id: 'universal_005',
      type: InsightType.quote,
      content: '미래는 현재 우리가 무엇을 하는가에 달려있다',
      source: '마하트마 간디',
      reflection: '지금 이 순간의 선택이 미래를 만듭니다.',
    ),
    const Insight(
      id: 'universal_006',
      type: InsightType.quote,
      content: '천 리 길도 한 걸음부터',
      source: '노자',
      reflection: '긴 여정도 오늘 한 걸음에서 시작됩니다.',
    ),
    const Insight(
      id: 'universal_007',
      type: InsightType.quote,
      content: '실패는 성공의 어머니다',
      source: '토머스 에디슨',
      reflection: '실수를 두려워하지 말고 그로부터 배우세요.',
    ),
    const Insight(
      id: 'universal_008',
      type: InsightType.quote,
      content: '행복은 습관이다. 그것을 몸에 지니라',
      source: '허버드',
      reflection: '매일 작은 행복을 찾고 감사하는 습관을 만드세요.',
    ),
    const Insight(
      id: 'universal_009',
      type: InsightType.quote,
      content: '오늘이 인생의 첫날이라고 생각하라',
      source: '파울로 코엘료',
      reflection: '매일을 새로운 시작으로 받아들이세요.',
    ),
    const Insight(
      id: 'universal_010',
      type: InsightType.quote,
      content: '자신을 변화시키는 것이 세상을 변화시키는 첫걸음이다',
      source: '마하트마 간디',
      reflection: '내면의 변화가 외적인 변화를 이끕니다.',
    ),
  ];

  /// Get today's insight based on app theme
  /// Uses date-based rotation to show different insight each day
  static Insight getTodayInsight(AppTheme theme, {DateTime? date}) {
    final today = date ?? DateTime.now();
    final insights = theme == AppTheme.faith ? faithInsights : universalInsights;

    // Use day of year for rotation (1-365/366)
    final dayOfYear = int.parse(
      '${today.difference(DateTime(today.year, 1, 1)).inDays + 1}',
    );
    final index = (dayOfYear - 1) % insights.length;

    return insights[index];
  }

  /// Get insight by ID
  static Insight? getInsightById(String id) {
    try {
      return [...faithInsights, ...universalInsights]
          .firstWhere((insight) => insight.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get random insight by theme
  static Insight getRandomInsight(AppTheme theme) {
    final insights = theme == AppTheme.faith ? faithInsights : universalInsights;
    final randomIndex = DateTime.now().millisecondsSinceEpoch % insights.length;
    return insights[randomIndex];
  }
}
