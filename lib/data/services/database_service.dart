import 'package:cuckoo_starter_kit/core/resources/supabase_tables.dart';
import 'package:cuckoo_starter_kit/data/dto/app_user_dto.dart';
import 'package:cuckoo_starter_kit/domain/models/app_user.dart';
import 'package:cuckoo_starter_kit/domain/services/idatabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService implements IDatabaseService {
  DatabaseService({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  static const profileTable = UserTable();

  @override
  Future<AppUser> getUser() async {
    try {
      final (Map<String, dynamic> data) = await _supabaseClient
          .from(profileTable.tableName)
          .select()
          .eq('id', _supabaseClient.auth.currentUser?.id)
          .single();
      return AppUserDto.fromMap(data);
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<void> updateUser({required AppUser user}) async {
    try {
      final newUser = user.copyWith(id: _supabaseClient.auth.currentUser?.id);
      await _supabaseClient.from(profileTable.tableName).upsert(newUser);
    } catch (error, stackTrace) {
      throw Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
