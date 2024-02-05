// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:orders_accountant/domain/models/order.dart';
import 'package:orders_accountant/domain/models/product.dart';
import 'package:orders_accountant/domain/repositories/orders_repository.dart';

class EditOrderCubit extends Cubit<EditOrderState> {
  final OrdersRepository orderRepository;
  EditOrderCubit(this.orderRepository)
      : super(EditOrderState(isLoading: false));

  addProduct(Product product) {
    final order = state.order;
    if (order != null) {
      final products = order.products ?? [];
      products.add(product.id);
      Map<int, Map<String, dynamic>>? productsDetailed = order.productsDetailed;
      productsDetailed ??= {};

      productsDetailed[product.id] = product.toJson();
      productsDetailed[product.id]!['quantity'] = 1;

      emit(state.copyWith(order: order.copyWith(products: products)));
    }
  }

  increaseQuantity(Product product) {
    final order = state.order;
    if (order != null) {
      Map<int, Map<String, dynamic>>? productsDetailed = order.productsDetailed;
      productsDetailed ??= {};

      productsDetailed[product.id]!['quantity'] += 1;

      emit(state.copyWith(
          order: order.copyWith(productsDetailed: productsDetailed)));
    }
  }

  decreaseQuantity(Product product) {
    final order = state.order;
    if (order != null) {
      Map<int, Map<String, dynamic>>? productsDetailed = order.productsDetailed;
      productsDetailed ??= {};

      productsDetailed[product.id]!['quantity'] -= 1;
      if (productsDetailed[product.id]!['quantity'] == 0) {
        productsDetailed.remove(product.id);
      }

      emit(state.copyWith(
          order: order.copyWith(productsDetailed: productsDetailed)));
    }
  }
}

class EditOrderState {
  final Order? order;
  final bool isLoading;

  EditOrderState({this.order, required this.isLoading});

  EditOrderState copyWith({
    Order? order,
    bool? isLoading,
  }) {
    return EditOrderState(
      order: order ?? this.order,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
