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

  DateTime selectedDate = DateTime.now();

  Future<void> init() async {
    setLoading();

    final List<Order> orders = await ordersRepository.getOrders(DateTime.now());

    emit(state.update(orders: orders, isLoading: false));
  }

  dateSelected(DateTime date) async {
    selectedDate = date;
    setLoading();

    final List<Order> orders = await ordersRepository.getOrders(date);

    emit(state.update(orders: orders, isLoading: false));
  }

  refreshCurrentSelectedDateOrders() {
    dateSelected(selectedDate);
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
