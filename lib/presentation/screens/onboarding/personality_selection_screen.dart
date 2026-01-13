import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';

/// Onboarding Step 2: Personality Selection (F/T)
class PersonalitySelectionScreen extends ConsumerStatefulWidget {
  final AppTheme theme;

  const PersonalitySelectionScreen({
    super.key,
    required this.theme,
  });

  @override
  ConsumerState<PersonalitySelectionScreen> createState() =>
      _PersonalitySelectionScreenState();
}

class _PersonalitySelectionScreenState
    extends ConsumerState<PersonalitySelectionScreen> {
  PersonalityType? selectedPersonality;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('코칭 스타일 선택'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              Text(
                '어떤 코칭 스타일을\n선호하시나요?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              Text(
                'AI 코칭의 대화 스타일을 결정합니다',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),

              const SizedBox(height: 48),

              _PersonalityCard(
                personality: PersonalityType.feeling,
                isSelected: selectedPersonality == PersonalityType.feeling,
                onTap: () =>
                    setState(() => selectedPersonality = PersonalityType.feeling),
              ),

              const SizedBox(height: 16),

              _PersonalityCard(
                personality: PersonalityType.thinking,
                isSelected: selectedPersonality == PersonalityType.thinking,
                onTap: () => setState(
                    () => selectedPersonality = PersonalityType.thinking),
              ),

              const Spacer(),

              FilledButton(
                onPressed: selectedPersonality == null
                    ? null
                    : () {
                        context.push(
                          '/onboarding/profile',
                          extra: {
                            'theme': widget.theme,
                            'personality': selectedPersonality,
                          },
                        );
                      },
                child: const Text('다음'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonalityCard extends StatelessWidget {
  final PersonalityType personality;
  final bool isSelected;
  final VoidCallback onTap;

  const _PersonalityCard({
    required this.personality,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFeeling = personality == PersonalityType.feeling;

    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isFeeling ? 'F (감정형)' : 'T (사고형)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                    ),
                  ),
                  const Spacer(),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                personality.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(
                isFeeling
                    ? '예: "많이 힘드시겠어요. 충분히 이해됩니다. 하나씩 천천히 해보면 어떨까요?"'
                    : '예: "구체적으로 어떤 부분이 어려우신가요? 문제를 나눠서 해결해봅시다."',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
