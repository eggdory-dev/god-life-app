/// Supabase 설정
class SupabaseConfig {
  /// Supabase 프로젝트 URL
  static const String supabaseUrl = 'https://igqnshzqeabezhyeawvx.supabase.co';

  /// Supabase Anon Key (공개 키)
  /// Dashboard > Settings > API에서 확인 가능
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlncW5zaHpxZWFiZXpoeWVhd3Z4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY1MTY1NDksImV4cCI6MjA1MjA5MjU0OX0.oLOg1UGPh7nHU9RUqNdPv0OXQEh7hAQm6K6IfVqDaBQ';

  /// Functions URL
  static const String functionsUrl = 'https://igqnshzqeabezhyeawvx.supabase.co/functions/v1';

  /// Edge Functions 엔드포인트 빌더
  static String getFunctionUrl(String functionName) => '$functionsUrl/$functionName';
}
