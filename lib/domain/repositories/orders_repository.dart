import 'package:orders_accountant/domain/models/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersRepository {
  const OrdersRepository({required supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;
  Future<List<Order>> getOrders(DateTime date) async {
    final String from =
        DateTime(date.year, date.month, date.day).toIso8601String();
    final String to =
        DateTime(date.year, date.month, date.day, 23, 59, 59).toIso8601String();
    final List<Map<String, dynamic>> data = await _supabaseClient
        .from('orders')
        .select()
        .gte('created_at', from)
        .lte('created_at', to);
    print(data);
    return data.map((e) => Order.fromJson(e)).toList();
  }

  Future<bool> upsertOrder(Order order) async {
    await _supabaseClient.from('orders').upsert(order.toJson());
    return true;
  }
}
