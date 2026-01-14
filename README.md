# God Life App 🙏

신앙 기반 습관 관리 및 AI 코칭 앱

## 📱 주요 기능

- **테마 전환**: Faith(신앙 기반) / Universal(일반) 테마 선택
- **루틴 관리**: 최대 5개 활성 루틴, 연속 달성 추적
- **AI 코칭**: 개인화된 대화형 코칭 (F/T 성향 기반)
- **리포트**: 주간/월간 성장 분석 및 인사이트
- **알림**: 루틴 리마인더 및 푸시 알림

## 🏗️ 아키텍처

Clean Architecture 기반 3-Layer 구조:

- **Presentation**: UI 및 상태 관리 (Riverpod)
- **Domain**: 비즈니스 로직 (Use Cases, Entities)
- **Data**: 데이터 소스 (API, Local DB)

## 🛠️ 기술 스택

- **Framework**: Flutter 3.9+
- **State Management**: Riverpod 2.5+
- **Network**: Dio + Retrofit
- **Local DB**: Drift (SQLite)
- **Routing**: GoRouter
- **Code Generation**: Freezed, JsonSerializable

## 🚀 시작하기

### 1. 의존성 설치

```bash
flutter pub get
```

### 2. 코드 생성

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Firebase 설정

```bash
flutterfire configure
```

### 4. 앱 실행

```bash
flutter run
```

## 📚 문서

- [개발 가이드](docs/DEVELOPMENT_GUIDE.md)
- [프로젝트 구조](docs/PROJECT_STRUCTURE.md)
- [PRD](docs/prd.md)

## 📂 프로젝트 구조

```
lib/
├── core/           # 공통 레이어 (상수, 테마, 유틸)
├── data/           # 데이터 레이어 (API, DB, Repository 구현)
├── domain/         # 도메인 레이어 (Entity, Use Case)
└── presentation/   # UI 레이어 (Screen, Widget, Provider)
```

## 🧪 테스트

```bash
# 단위 테스트
flutter test

# 통합 테스트
flutter test integration_test/
```

## 📝 커밋 컨벤션

```
<type>: <subject>

예시:
feat: 루틴 생성 기능 추가
fix: 연속 달성 계산 버그 수정
docs: README 업데이트
```

## 📄 라이선스

Private Project
