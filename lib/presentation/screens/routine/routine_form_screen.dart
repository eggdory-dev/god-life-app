import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enums.dart';
import '../../../domain/entities/routine.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/routine/routine_list_provider.dart';
import '../../widgets/common/app_text_field.dart';

/// Routine form screen for creating or editing a routine
class RoutineFormScreen extends ConsumerStatefulWidget {
  final Routine? routine; // null for create, non-null for edit

  const RoutineFormScreen({
    super.key,
    this.routine,
  });

  @override
  ConsumerState<RoutineFormScreen> createState() => _RoutineFormScreenState();
}

class _RoutineFormScreenState extends ConsumerState<RoutineFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _uuid = const Uuid();

  String? _selectedCategory;
  RoutineFrequency _frequency = RoutineFrequency.daily;
  Set<int> _selectedDays = {1, 2, 3, 4, 5, 6, 7}; // All days by default
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  bool _reminderEnabled = true;
  int _reminderMinutesBefore = 10;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.routine != null) {
      _initializeFromRoutine(widget.routine!);
    }
  }

  void _initializeFromRoutine(Routine routine) {
    _nameController.text = routine.name;
    _descriptionController.text = routine.description ?? '';
    _selectedCategory = routine.category;
    _frequency = routine.schedule.frequency;
    _selectedDays = routine.schedule.days.toSet();
    _selectedTime = TimeOfDay(
      hour: int.parse(routine.schedule.time.split(':')[0]),
      minute: int.parse(routine.schedule.time.split(':')[1]),
    );
    _reminderEnabled = routine.schedule.reminderEnabled;
    _reminderMinutesBefore = routine.schedule.reminderMinutesBefore;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.routine != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '루틴 수정' : '루틴 만들기'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Name
            AppTextField(
              controller: _nameController,
              label: '루틴 이름',
              hint: '예: 아침 묵상',
              prefixIcon: Icons.event_note,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '루틴 이름을 입력해주세요';
                }
                if (value.trim().length < 2) {
                  return '루틴 이름은 2자 이상이어야 합니다';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description
            AppTextField.multiline(
              controller: _descriptionController,
              label: '설명 (선택)',
              hint: '루틴에 대한 설명을 입력하세요',
              prefixIcon: Icons.description,
            ),
            const SizedBox(height: 16),

            // Category
            _buildCategorySection(),
            const SizedBox(height: 24),

            // Frequency
            _buildFrequencySection(),
            const SizedBox(height: 16),

            // Days (if weekly)
            if (_frequency != RoutineFrequency.daily) ...[
              _buildDaysSection(),
              const SizedBox(height: 16),
            ],

            // Time
            _buildTimeSection(),
            const SizedBox(height: 24),

            // Reminder
            _buildReminderSection(),
            const SizedBox(height: 32),

            // Submit button
            FilledButton(
              onPressed: _isLoading ? null : _handleSubmit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(isEdit ? '수정하기' : '만들기'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    final categories = [
      {'value': 'spiritual', 'label': '영성', 'icon': Icons.church},
      {'value': 'health', 'label': '건강', 'icon': Icons.fitness_center},
      {'value': 'growth', 'label': '성장', 'icon': Icons.trending_up},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '카테고리',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((cat) {
            final isSelected = _selectedCategory == cat['value'];
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    size: 18,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(cat['label'] as String),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? cat['value'] as String : null;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFrequencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '반복 주기',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        SegmentedButton<RoutineFrequency>(
          segments: [
            ButtonSegment(
              value: RoutineFrequency.daily,
              label: Text('매일'),
              icon: Icon(Icons.today),
            ),
            ButtonSegment(
              value: RoutineFrequency.weekly,
              label: Text('주간'),
              icon: Icon(Icons.calendar_view_week),
            ),
          ],
          selected: {_frequency},
          onSelectionChanged: (Set<RoutineFrequency> newSelection) {
            setState(() {
              _frequency = newSelection.first;
              if (_frequency == RoutineFrequency.daily) {
                _selectedDays = {1, 2, 3, 4, 5, 6, 7};
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildDaysSection() {
    final days = [
      {'value': 1, 'label': '월'},
      {'value': 2, 'label': '화'},
      {'value': 3, 'label': '수'},
      {'value': 4, 'label': '목'},
      {'value': 5, 'label': '금'},
      {'value': 6, 'label': '토'},
      {'value': 7, 'label': '일'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '반복 요일',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: days.map((day) {
            final dayValue = day['value'] as int;
            final isSelected = _selectedDays.contains(dayValue);
            return FilterChip(
              label: Text(day['label'] as String),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedDays.add(dayValue);
                  } else {
                    _selectedDays.remove(dayValue);
                  }
                });
              },
            );
          }).toList(),
        ),
        if (_selectedDays.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '최소 1개의 요일을 선택해주세요',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _buildTimeSection() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.access_time),
      title: const Text('시간'),
      subtitle: Text(_selectedTime.format(context)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
        );
        if (time != null) {
          setState(() {
            _selectedTime = time;
          });
        }
      },
    );
  }

  Widget _buildReminderSection() {
    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('알림'),
          subtitle: _reminderEnabled
              ? Text('$_reminderMinutesBefore분 전에 알림')
              : const Text('알림 없음'),
          value: _reminderEnabled,
          onChanged: (value) {
            setState(() {
              _reminderEnabled = value;
            });
          },
        ),
        if (_reminderEnabled) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '알림 시간: $_reminderMinutesBefore분 전',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Slider(
                      value: _reminderMinutesBefore.toDouble(),
                      min: 5,
                      max: 60,
                      divisions: 11,
                      label: '$_reminderMinutesBefore분',
                      onChanged: (value) {
                        setState(() {
                          _reminderMinutesBefore = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_frequency != RoutineFrequency.daily && _selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('최소 1개의 요일을 선택해주세요')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = ref.read(authProvider).value;
      if (user == null) {
        throw Exception('로그인이 필요합니다');
      }

      final schedule = RoutineSchedule(
        frequency: _frequency,
        days: _selectedDays.toList()..sort(),
        time: '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
        reminderEnabled: _reminderEnabled,
        reminderMinutesBefore: _reminderMinutesBefore,
      );

      final routine = Routine(
        id: widget.routine?.id ?? _uuid.v4(),
        userId: user.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        category: _selectedCategory,
        schedule: schedule,
        streak: widget.routine?.streak ?? 0,
        maxStreak: widget.routine?.maxStreak ?? 0,
        status: widget.routine?.status ?? RoutineStatus.active,
        createdAt: widget.routine?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.routine == null) {
        // Create
        await ref
            .read(routineListProvider(status: RoutineStatus.active).notifier)
            .createRoutine(routine);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('루틴이 생성되었습니다')),
          );
          context.pop();
        }
      } else {
        // Update
        await ref
            .read(routineListProvider(status: RoutineStatus.active).notifier)
            .updateRoutine(routine);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('루틴이 수정되었습니다')),
          );
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
