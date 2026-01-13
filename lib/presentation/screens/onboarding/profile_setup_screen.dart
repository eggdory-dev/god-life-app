import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../widgets/common/app_text_field.dart';

/// Onboarding Step 3: Profile Setup
class ProfileSetupScreen extends ConsumerStatefulWidget {
  final AppTheme theme;
  final PersonalityType personality;

  const ProfileSetupScreen({
    super.key,
    required this.theme,
    required this.personality,
  });

  @override
  ConsumerState<ProfileSetupScreen> createState() =>
      _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 설정'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),

                Text(
                  '어떻게 불러드릴까요?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),

                Text(
                  '이름 또는 닉네임을 입력해주세요',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),

                const SizedBox(height: 48),

                AppTextField(
                  controller: _nameController,
                  label: '이름',
                  hint: '예: 홍길동',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '이름을 입력해주세요';
                    }
                    if (value.trim().length < 2) {
                      return '이름은 2자 이상이어야 합니다';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                ),

                const Spacer(),

                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(
                        '/onboarding/notification',
                        extra: {
                          'theme': widget.theme,
                          'personality': widget.personality,
                          'name': _nameController.text.trim(),
                        },
                      );
                    }
                  },
                  child: const Text('다음'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
