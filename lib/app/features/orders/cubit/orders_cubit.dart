import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_accountant/domain/models/order.dart';
import 'package:orders_accountant/domain/repositories/orders_repository.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required this.ordersRepository,
  }) : super(OrdersLoading()) {
    init();
  }

  Future<void> init() async {
    setLoading();

    final List<Order> orders = await ordersRepository.getOrders(DateTime.now());

    emit(OrdersLoaded(orders: orders));
  }

  final OrdersRepository ordersRepository;

  void setLoading() {
    emit(OrdersLoading());
  }
}

abstract class OrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersLoading extends OrdersState {}

class OrdersError extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> orders;

  OrdersLoaded({required this.orders});
}
