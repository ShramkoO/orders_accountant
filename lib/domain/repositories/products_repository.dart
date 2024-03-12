import 'package:orders_accountant/domain/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsRepository {
  const ProductsRepository({required supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<Product>> getProducts() async {
    final List<Map<String, dynamic>> data = await _supabaseClient
        .from('products')
        .select()
        .order('display_name', ascending: true);
    print(data);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  Future<bool> updateProduct(Product product) async {
    final response = await _supabaseClient
        .from('products')
        .update(product.toJson())
        .eq('id', product.id);

    return true;
  }
}
