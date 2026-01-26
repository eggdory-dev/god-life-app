# Supabase 설정 가이드

## 🚀 빠른 시작 (복사-붙여넣기)

Supabase Dashboard → SQL Editor로 이동하여 아래 스크립트를 **순서대로** 실행하세요.

---

## Step 1: Profiles 테이블 생성 및 RLS 설정

**이 스크립트를 복사하여 SQL Editor에 붙여넣고 실행하세요:**

```sql
-- profiles 테이블 생성
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text not null,
  name text not null,
  provider text not null,
  profile_image_url text,
  interests text[],
  is_faith_user boolean default false,
  coaching_style text,
  theme_mode text,
  onboarding_completed boolean default false,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- RLS 활성화
alter table public.profiles enable row level security;

-- 기존 정책 삭제 (있을 경우)
drop policy if exists "Users can view own profile" on public.profiles;
drop policy if exists "Users can insert own profile" on public.profiles;
drop policy if exists "Users can update own profile" on public.profiles;

-- 정책 1: 사용자는 자신의 프로필을 읽을 수 있음
create policy "Users can view own profile"
  on public.profiles for select
  using (auth.uid() = id);

-- 정책 2: 사용자는 자신의 프로필을 생성할 수 있음
create policy "Users can insert own profile"
  on public.profiles for insert
  with check (auth.uid() = id);

-- 정책 3: 사용자는 자신의 프로필을 수정할 수 있음
create policy "Users can update own profile"
  on public.profiles for update
  using (auth.uid() = id);
```

---

## Step 2: 자동 프로필 생성 트리거 설정 (권장)

**이 스크립트를 복사하여 SQL Editor에 붙여넣고 실행하세요:**

```sql
-- 기존 트리거 및 함수 삭제 (있을 경우)
drop trigger if exists on_auth_user_created on auth.users;
drop function if exists public.handle_new_user();

-- 새 사용자 생성 시 프로필 자동 생성 함수
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, email, name, provider, onboarding_completed)
  values (
    new.id,
    new.email,
    coalesce(
      new.raw_user_meta_data->>'full_name',
      new.raw_user_meta_data->>'name',
      split_part(new.email, '@', 1)
    ),
    coalesce(new.raw_app_meta_data->>'provider', 'email'),
    false
  );
  return new;
end;
$$;

-- 트리거 생성
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
```

---

## Step 3: Updated_at 자동 업데이트 트리거 설정

**이 스크립트를 복사하여 SQL Editor에 붙여넣고 실행하세요:**

```sql
-- 기존 트리거 및 함수 삭제 (있을 경우)
drop trigger if exists handle_profiles_updated_at on public.profiles;
drop function if exists public.handle_updated_at();

-- Updated_at 자동 업데이트 함수
create or replace function public.handle_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- 트리거 생성
create trigger handle_profiles_updated_at
  before update on public.profiles
  for each row execute procedure public.handle_updated_at();
```

---

## ✅ 완료 확인

SQL 실행 후 다음을 확인하세요:

1. **테이블 확인**: Database → Tables → profiles 테이블 존재 확인
2. **RLS 확인**: profiles 테이블 → Policies에서 3개 정책 확인
3. **트리거 확인**: SQL Editor에서 다음 쿼리 실행

```sql
-- 트리거 확인
select
  trigger_name,
  event_manipulation,
  event_object_table
from information_schema.triggers
where trigger_schema = 'public';
```

---

## 📱 Google OAuth 설정

### Supabase Dashboard

1. Authentication → Providers → Google
2. Enable 체크
3. Google Cloud Console에서 받은 Client ID와 Client Secret 입력
4. Authorized redirect URIs:
   ```
   https://<your-project-ref>.supabase.co/auth/v1/callback
   ```

### Google Cloud Console

1. APIs & Services → Credentials → Create OAuth 2.0 Client ID
2. Application type: iOS (또는 Android/Web)
3. Authorized redirect URIs에 Supabase URL 추가
4. iOS Bundle ID: `com.eggdory.godlifeapp`
5. Android Package Name: `com.eggdory.godlifeapp`

---

## 🧪 테스트

1. 앱 실행: `flutter run`
2. Google 로그인 시도
3. 확인:
   - Authentication → Users: 새 사용자 추가됨
   - Database → profiles: 프로필 자동 생성됨

---

## 🔧 문제 해결

### "new row violates row-level security policy" 에러

→ Step 1의 RLS 정책을 다시 실행하세요.

### Profile이 자동 생성되지 않음

→ Step 2의 트리거를 다시 실행하세요.

### 기존 사용자 프로필이 없음

→ Step 4를 실행하세요.
