import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  static Future<SupabaseService> init() async {
    print(dotenv.env['SUPABASE_URL']);
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
      // authFlowType: AuthFlowType.pkce,
    );

    return SupabaseService();
  }
}
