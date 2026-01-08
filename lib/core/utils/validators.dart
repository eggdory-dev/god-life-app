class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return '올바른 이메일 형식이 아닙니다';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }

    if (value.length < 8) {
      return '비밀번호는 8자 이상이어야 합니다';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return '비밀번호는 대문자를 포함해야 합니다';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return '비밀번호는 소문자를 포함해야 합니다';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return '비밀번호는 숫자를 포함해야 합니다';
    }

    return null;
  }

  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? '필수 항목'}을(를) 입력해주세요';
    }
    return null;
  }

  static String? validateMinLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? '입력값'}을(를) 입력해주세요';
    }

    if (value.length < minLength) {
      return '${fieldName ?? '입력값'}은(는) 최소 $minLength자 이상이어야 합니다';
    }

    return null;
  }

  static String? validateMaxLength(String? value, int maxLength, {String? fieldName}) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? '입력값'}은(는) 최대 $maxLength자까지 입력 가능합니다';
    }

    return null;
  }

  static String? validateRoutineName(String? value) {
    final required = validateRequired(value, fieldName: '루틴 이름');
    if (required != null) return required;

    return validateMaxLength(value, 50, fieldName: '루틴 이름');
  }

  static String? validateRoutineDescription(String? value) {
    if (value != null && value.isNotEmpty) {
      return validateMaxLength(value, 200, fieldName: '루틴 설명');
    }
    return null;
  }

  static String? validateMessageLength(String? value) {
    final required = validateRequired(value, fieldName: '메시지');
    if (required != null) return required;

    return validateMaxLength(value, 500, fieldName: '메시지');
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return '전화번호를 입력해주세요';
    }

    final phoneRegex = RegExp(r'^01[0-9]-?[0-9]{3,4}-?[0-9]{4}$');

    if (!phoneRegex.hasMatch(value)) {
      return '올바른 전화번호 형식이 아닙니다';
    }

    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return '올바른 URL 형식이 아닙니다';
    }

    return null;
  }
}
