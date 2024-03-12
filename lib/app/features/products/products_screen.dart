import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/app/features/products/widgets/products_tree_view.dart';
import 'package:orders_accountant/app/widgets/app_text_field.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_accountant/domain/models/product.dart';

class ProductsScreen extends StatefulWidget {
  // Every Screen should have a routeName, for safe access in the router
  static const String routeName = '/products';
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

const debounceTimeMs = 1000;
const debounceTime = Duration(milliseconds: debounceTimeMs);
const debounceCheckTime = Duration(milliseconds: debounceTimeMs - 2);

class _ProductsScreenState extends State<ProductsScreen> {
  Product? _selectedProduct;

  String searchWord = '';
  String _searchWordDebounced = '';
  DateTime lastSearchChange = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return GestureDetector(
          onTap: () {
            print('empty space tapped');
            if (_selectedProduct != null) {
              setState(() {
                _selectedProduct = null;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Column(
              children: [
                AppTextField(
                  prefixIcon: Icon(
                    Icons.search,
                    color: colors.lavenderGrey,
                  ),
                  onChanged: (value) {
                    searchWord = value;
                    lastSearchChange = DateTime.now();
                    Future.delayed(debounceTime, () {
                      if (DateTime.now().difference(lastSearchChange) >
                          debounceCheckTime) {
                        setState(() {
                          _searchWordDebounced = searchWord;
                        });
                      }
                    });
                  },
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ProductsTreeView(
                    searchWord: _searchWordDebounced,
                    selectedProduct: _selectedProduct,
                    onProductSelected: (productSelected) {
                      setState(() {
                        _selectedProduct = productSelected;
                      });
                    },
                    productsEditable: true,
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
