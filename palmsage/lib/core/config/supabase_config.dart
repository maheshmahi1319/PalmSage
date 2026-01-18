import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static String? _supabaseUrl;
  static String? _supabaseAnonKey;
  
  static String get supabaseUrl => _supabaseUrl ?? '';
  static String get supabaseAnonKey => _supabaseAnonKey ?? '';

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    
    _supabaseUrl = dotenv.env['SUPABASE_URL'];
    _supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (_supabaseUrl == null || _supabaseAnonKey == null) {
      throw Exception('Supabase URL and Anon Key must be provided in .env file');
    }

    await Supabase.initialize(
      url: _supabaseUrl!,
      anonKey: _supabaseAnonKey!,
      authFlowType: AuthFlowType.pkce,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
  static GoTrueClient get auth => Supabase.instance.client.auth;
  static SupabaseQueryBuilder get from => Supabase.instance.client.from;
}
