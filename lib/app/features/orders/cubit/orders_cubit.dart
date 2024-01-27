import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersLoaded());

  void setLoading() {
    emit(OrdersLoading());
  }

  void setLoaded() {
    emit(OrdersLoaded());
  }
}

abstract class OrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrdersLoading extends OrdersState {}

class OrdersError extends OrdersState {}

class OrdersLoaded extends OrdersState {}
