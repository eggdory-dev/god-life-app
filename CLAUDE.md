# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

God Life App is a Flutter mobile application targeting iOS, Android, web, macOS, Windows, and Linux platforms.

## Common Commands

```bash
# Run the app (debug mode)
flutter run

# Run on specific device
flutter run -d ios
flutter run -d android
flutter run -d chrome
flutter run -d macos

# Static analysis
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Get dependencies
flutter pub get

# Build release
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
flutter build macos        # macOS
```

## Architecture

- **lib/** - Dart source code, entry point is `lib/main.dart`
- **test/** - Widget and unit tests
- **android/** - Android platform-specific code (Kotlin)
- **ios/** - iOS platform-specific code (Swift)
- **web/** - Web platform assets
- **macos/** - macOS platform-specific code
- **linux/** - Linux platform-specific code
- **windows/** - Windows platform-specific code

## Configuration

- **pubspec.yaml** - Dependencies, assets, and app metadata
- **analysis_options.yaml** - Dart analyzer and linter rules (uses `flutter_lints`)

## SDK Requirements

- Dart SDK: ^3.9.0

## Git Commit Convention

커밋 메시지는 다음 형식을 따릅니다:

```
<type>: <subject>
```

### Type

- `feat`: 새로운 기능 추가
- `fix`: 버그 수정
- `docs`: 문서 변경
- `style`: 코드 포맷팅, 세미콜론 누락 등 (코드 변경 없음)
- `refactor`: 리팩토링 (기능 변경 없음)
- `test`: 테스트 추가 또는 수정
- `chore`: 빌드, 설정 파일 변경 등

### 규칙

- subject는 한글 또는 영문으로 작성
- 50자 이내로 간결하게 작성
- 마침표 사용하지 않음
- 명령문으로 작성 (예: "추가", "수정", "변경")

### 예시

```
feat: 로그인 화면 추가
fix: 홈 화면 크래시 수정
refactor: 사용자 인증 로직 분리
chore: flutter 버전 업그레이드
```
