import 'package:orders_accountant/domain/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsRepository {
  const ProductsRepository({required supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<Product>> getProducts() async {
    final List<Map<String, dynamic>> data =
        await _supabaseClient.from('products').select();
    print(data);
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
