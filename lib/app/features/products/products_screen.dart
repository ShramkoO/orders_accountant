import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/app/features/products/widgets/products_tree_view.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductsScreen extends StatefulWidget {
  // Every Screen should have a routeName, for safe access in the router
  static const String routeName = '/products';
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
          child: Column(
            children: [
              Container(
                height: 46,
                decoration: BoxDecoration(
                  color: colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colors.periwinkleBlue, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(left: 8),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: colors.periwinkleBlue,
                  weight: 0.4,
                ),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ProductsTreeView(),
              )),
            ],
          ),
        );
      },
    );
  }
}
