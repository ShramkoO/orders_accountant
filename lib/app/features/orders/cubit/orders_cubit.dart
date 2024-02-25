// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:orders_accountant/domain/models/order.dart';
import 'package:orders_accountant/domain/repositories/orders_repository.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required this.ordersRepository,
  }) : super(OrdersState()) {
    init();
  }

  Future<void> init() async {
    setLoading();

    final List<Order> orders = await ordersRepository.getOrders(DateTime.now());

    emit(state.update(orders: orders, isLoading: false));
  }

  dateSelected(DateTime date) async {
    setLoading();

    final List<Order> orders = await ordersRepository.getOrders(date);

    await Future.delayed(const Duration(milliseconds: 1000));

    emit(state.update(orders: orders, isLoading: false));
  }

  final OrdersRepository ordersRepository;

  void setLoading() {
    emit(state.update(isLoading: true));
  }
}

class OrdersState {
  final bool isLoading;
  final List<Order> orders;

  //
  final String customerName;

  OrdersState({
    this.isLoading = false,
    this.orders = const [],
    this.customerName = '',
  });

  OrdersState update({
    bool? isLoading,
    List<Order>? orders,
    String? customerName,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      customerName: customerName ?? this.customerName,
    );
  }
}
