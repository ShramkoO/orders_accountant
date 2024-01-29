import 'package:orders_accountant/domain/models/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoriesRepository {
  const CategoriesRepository({required supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<Category>> getCategories() async {
    final List<Map<String, dynamic>> data =
        await _supabaseClient.from('categories').select();
    print('categiories received');
    print(data);
    return data.map((e) => Category.fromJson(e)).toList();
  }
}
