import '../../../data/models/routine_model.dart';

/// Mock routine data for development
class MockRoutines {
  static const String mockUserId = 'user_001';

  /// Active routines (5 items - max limit)
  static final List<RoutineModel> activeRoutines = [
    RoutineModel(
      id: 'routine_001',
      userId: mockUserId,
      name: '아침 묵상',
      description: '하루를 시작하는 말씀 묵상',
      category: 'spiritual',
      schedule: const RoutineScheduleModel(
        frequency: 'daily',
        days: [1, 2, 3, 4, 5, 6, 7],
        time: '06:30',
        reminderEnabled: true,
        reminderMinutesBefore: 10,
      ),
      streak: 14,
      maxStreak: 30,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    RoutineModel(
      id: 'routine_002',
      userId: mockUserId,
      name: '성경 읽기',
      description: '매일 한 장씩 성경 읽기',
      category: 'spiritual',
      schedule: const RoutineScheduleModel(
        frequency: 'daily',
        days: [1, 2, 3, 4, 5, 6, 7],
        time: '07:00',
        reminderEnabled: true,
        reminderMinutesBefore: 15,
      ),
      streak: 21,
      maxStreak: 45,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      updatedAt: DateTime.now(),
    ),
    RoutineModel(
      id: 'routine_003',
      userId: mockUserId,
      name: '운동',
      description: '30분 이상 운동하기',
      category: 'health',
      schedule: const RoutineScheduleModel(
        frequency: 'weekly',
        days: [1, 2, 3, 4, 5], // 주중만
        time: '18:00',
        reminderEnabled: true,
        reminderMinutesBefore: 30,
      ),
      streak: 7,
      maxStreak: 12,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    RoutineModel(
      id: 'routine_004',
      userId: mockUserId,
      name: '저녁 감사 일기',
      description: '하루를 돌아보며 감사한 일 3가지 기록',
      category: 'spiritual',
      schedule: const RoutineScheduleModel(
        frequency: 'daily',
        days: [1, 2, 3, 4, 5, 6, 7],
        time: '22:00',
        reminderEnabled: true,
        reminderMinutesBefore: 10,
      ),
      streak: 5,
      maxStreak: 10,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
    ),
    RoutineModel(
      id: 'routine_005',
      userId: mockUserId,
      name: '물 2L 마시기',
      description: '하루 물 섭취량 채우기',
      category: 'health',
      schedule: const RoutineScheduleModel(
        frequency: 'daily',
        days: [1, 2, 3, 4, 5, 6, 7],
        time: '20:00',
        reminderEnabled: false,
        reminderMinutesBefore: 0,
      ),
      streak: 3,
      maxStreak: 8,
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now(),
    ),
  ];

  /// Archived routines (3 items for testing)
  static final List<RoutineModel> archivedRoutines = [
    RoutineModel(
      id: 'routine_101',
      userId: mockUserId,
      name: '새벽 기도',
      description: '새벽 5시 기도',
      category: 'spiritual',
      schedule: const RoutineScheduleModel(
        frequency: 'daily',
        days: [1, 2, 3, 4, 5, 6, 7],
        time: '05:00',
        reminderEnabled: true,
        reminderMinutesBefore: 10,
      ),
      streak: 0,
      maxStreak: 60,
      status: 'archived',
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
      updatedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    RoutineModel(
      id: 'routine_102',
      userId: mockUserId,
      name: '아침 조깅',
      description: '아침 30분 조깅',
      category: 'health',
      schedule: const RoutineScheduleModel(
        frequency: 'weekly',
        days: [2, 4, 6], // 화목토
        time: '06:00',
        reminderEnabled: true,
        reminderMinutesBefore: 15,
      ),
      streak: 0,
      maxStreak: 25,
      status: 'archived',
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      updatedAt: DateTime.now().subtract(const Duration(days: 45)),
    ),
    RoutineModel(
      id: 'routine_103',
      userId: mockUserId,
      name: '책 읽기',
      description: '30분 독서',
      category: 'growth',
      schedule: const RoutineScheduleModel(
        frequency: 'daily',
        days: [1, 2, 3, 4, 5, 6, 7],
        time: '21:00',
        reminderEnabled: false,
        reminderMinutesBefore: 0,
      ),
      streak: 0,
      maxStreak: 18,
      status: 'archived',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      updatedAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ];

  /// Get all routines (active + archived)
  static List<RoutineModel> get allRoutines => [
        ...activeRoutines,
        ...archivedRoutines,
      ];

  /// Get a single routine by ID
  static RoutineModel? getById(String id) {
    try {
      return allRoutines.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }
}
