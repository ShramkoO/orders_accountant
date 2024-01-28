import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_accountant/domain/models/category.dart';
import 'package:orders_accountant/domain/models/product.dart';
import 'package:orders_accountant/domain/repositories/categories_repository.dart';
import 'package:orders_accountant/domain/repositories/products_repository.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({
    required this.categoriesRepository,
    required this.productsRepository,
  }) : super(ProductsLoading()) {
    init();
  }

  Future<void> init() async {
    setLoading();

    final results = await Future.wait([
      categoriesRepository.getCategories(),
      productsRepository.getProducts(),
    ]);

    final List<Category> categories = results[0] as List<Category>;
    final List<Product> products = results[1] as List<Product>;

    emit(ProductsLoaded(categories: categories, products: products));
  }

  final CategoriesRepository categoriesRepository;
  final ProductsRepository productsRepository;

  void setLoading() {
    emit(ProductsLoading());
  }
}

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Category> categories;
  final List<Product> products;

  ProductsLoaded({required this.categories, required this.products});
}