import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/core/resources/supabase_tables.dart';
import 'package:orders_accountant/data/dto/app_user_dto.dart';
import 'package:orders_accountant/domain/models/app_user.dart';
import 'package:orders_accountant/domain/services/idatabase_service.dart';
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
          .eq('id', _supabaseClient.auth.currentUser?.id ?? '')
          .single();
      return AppUserDto.fromMap(data);
    } catch (error, stackTrace) {
      debugPrint('catched');
      debugPrint(stackTrace.toString());

      //in order to get better valuable stacktrace error is thrown a new

      //throw Error.throwWithStackTrace(error, stackTrace);
      throw error.toString();
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
