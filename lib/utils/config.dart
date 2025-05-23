class Config {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL',
      defaultValue: 'https://rjbfzpiacnjvdsyzxnow.supabase.co');
  static const String supabaseAnonKey = String.fromEnvironment(
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJqYmZ6cGlhY25qdmRzeXp4bm93Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5ODYwNTUsImV4cCI6MjA2MzU2MjA1NX0.FdU-KHtpOYoG78L4YCr9RaX3ZJX3eoVBvarEvGHq2vE',
      defaultValue:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJqYmZ6cGlhY25qdmRzeXp4bm93Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5ODYwNTUsImV4cCI6MjA2MzU2MjA1NX0.FdU-KHtpOYoG78L4YCr9RaX3ZJX3eoVBvarEvGHq2vE');
}
