import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoaded());

  void setLoading() {
    emit(ProductsLoading());
  }

  void setLoaded() {
    emit(ProductsLoaded());
  }
}

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {}

class ProductsLoaded extends ProductsState {}
