// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:orders_accountant/domain/models/order.dart';
import 'package:orders_accountant/domain/models/product.dart';
import 'package:orders_accountant/domain/repositories/orders_repository.dart';

class EditOrderCubit extends Cubit<EditOrderState> {
  final OrdersRepository ordersRepository;
  EditOrderCubit({required this.ordersRepository})
      : super(EditOrderState(isLoading: false));

  createOrder() async {
    print('createOrder');
    emit(
      state.update(
        order: Order(
          id: 12345,
          status: OrderStatus.pending,
          products: [],
          productsDetailed: {},
          createdAt: DateTime.now(),
          price: 0,
          costPrice: 0,
          customer: '',
        ),
        customerError: '',
        productsError: '',
      ),
    );
  }

  customerChanged(String customer) {
    final order = state.order;

    if (order != null) {
      emit(state.update(order: order.copyWith(customer: customer)));
    }
    if (state.customerError != null && state.customerError!.isNotEmpty) {
      print('customerError: ${state.customerError}');
      print('state.order.customer: ${state.order!.customer}');
      validateInputs();
      print('customerError: ${state.customerError}');
    }
  }

  statusChanged(String orderStatus) {
    final order = state.order;
    if (order != null) {
      emit(state.update(
          order: order.copyWith(
              status: OrderStatusExtension.fromString(orderStatus))));
    }
  }

  addProduct(Product product) {
    print('addProduct: ${product.toJson()}');
    final order = state.order;
    if (order != null) {
      print('product: ${product.toJson()}');
      final products = order.products ?? [];
      products.add(product.id);
      Map<String, Map<String, dynamic>>? productsDetailed =
          order.productsDetailed;
      productsDetailed ??= {};

      productsDetailed[product.id.toString()] = product.toJson();
      productsDetailed[product.id.toString()]!['quantity'] = 1;
      print('productsAdded: ${productsDetailed[product.id.toString()]}');
      emit(state.update(order: order.copyWith(products: products)));
    }
  }

  getQuantity(Product product) {
    final order = state.order;
    if (order != null) {
      Map<String, Map<String, dynamic>>? productsDetailed =
          order.productsDetailed;
      productsDetailed ??= {};

      return productsDetailed[product.id.toString()]!['quantity'];
    }
  }

  getProductPrice(Product product) {
    final order = state.order;
    if (order != null) {
      Map<String, Map<String, dynamic>>? productsDetailed =
          order.productsDetailed;
      productsDetailed ??= {};

      return productsDetailed[product.id.toString()]!['price'] *
          productsDetailed[product.id.toString()]!['quantity'];
    }
  }

  increaseQuantity(Product product) {
    final order = state.order;
    if (order != null) {
      Map<String, Map<String, dynamic>>? productsDetailed =
          order.productsDetailed;
      productsDetailed ??= {};

      productsDetailed[product.id.toString()]!['quantity'] += 1;

      emit(state.update(
          order: order.copyWith(productsDetailed: productsDetailed)));
    }
  }

  decreaseQuantity(Product product) {
    final order = state.order;
    if (order != null) {
      Map<String, Map<String, dynamic>>? productsDetailed =
          order.productsDetailed;
      productsDetailed ??= {};

      List<int> products = order.products ?? [];

      productsDetailed[product.id.toString()]!['quantity'] -= 1;
      if (productsDetailed[product.id.toString()]!['quantity'] == 0) {
        productsDetailed.remove(product.id);
        products.remove(product.id);
      }

      emit(state.update(
          order: order.copyWith(productsDetailed: productsDetailed)));
    }
  }

  Future<bool> saveOrder() async {
    final bool validationResult = validateInputs();

    if (!validationResult) {
      return false;
    }
    emit(state.update(customerError: '', productsError: ''));
    print('saveOrder');
    await ordersRepository.upsertOrder(state.order!);
    return true;
  }

  /// returns true if no errors
  bool validateInputs() {
    bool result = true;
    final Order? order = state.order;
    String cusomerError = '';
    String productsError = '';
    if (order == null) {
      result = false;
      throw Exception('Order is null');
    }
    print('state.order.customer: ${state.order!.customer}');
    print('state.order.customer.isEmpty: ${state.order!.customer.isEmpty}');
    if (order.customer.isEmpty) {
      result = false;
      cusomerError = 'Customer is required';
    }
    if (order.products == null ||
        order.products!.isEmpty ||
        order.productsDetailed!.values.where((p) => p['type'] == 0).isEmpty) {
      productsError = 'Products are required';
      result = false;
    }
    emit(state.update(
        customerError: cusomerError, productsError: productsError));
    return result;
  }
}

class EditOrderState {
  final Order? order;
  final bool isLoading;
  final String? customerError;
  final String? productsError;

  EditOrderState(
      {this.order,
      required this.isLoading,
      this.customerError,
      this.productsError});

  EditOrderState update({
    Order? order,
    bool? isLoading,
    String? customerError,
    String? productsError,
  }) {
    return EditOrderState(
      order: order ?? this.order,
      isLoading: isLoading ?? this.isLoading,
      customerError: customerError ?? this.customerError,
      productsError: productsError ?? this.productsError,
    );
  }
}
