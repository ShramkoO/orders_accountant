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

  Product getProductById(int id) {
    final state = this.state;
    if (state is ProductsLoaded) {
      return state.products.firstWhere((element) => element.id == id);
    }
    throw Exception('Products not loaded');
  }

  updateProductQuantity(int id, int quantity) async {
    final state = this.state;
    if (state is ProductsLoaded) {
      final Product product =
          state.products.firstWhere((element) => element.id == id);
      final updatedProduct = product.copyWith(quantity: quantity);
      final updatedProducts = state.products.map((e) {
        if (e.id == id) {
          print('updating product: $updatedProduct');
          print('updated product quantity: ${updatedProduct.quantity}');
          return updatedProduct;
        }
        return e;
      }).toList();
      print('emitting updated products: $updatedProducts');
      await productsRepository.updateProduct(updatedProduct);
      emit(ProductsLoaded(
          categories: state.categories, products: updatedProducts));
    }
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

  @override
  List<Object?> get props => [categories, products];
}
