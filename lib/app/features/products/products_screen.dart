import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:orders_accountant/app/widgets/app_modals.dart';
import 'package:orders_accountant/app/widgets/controls/buttons.dart';
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
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(styles.insets.body),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton.filled(
                    onPressed: () {
                      userInfoCubit.showSnackbar(
                        message: 'This is a snackbar',
                        severity: MessageSeverity.info,
                      );
                    },
                    text: 'show snackbar',
                  ),
                  Gap(styles.insets.sm),
                  AppButton.from(
                    onPressed: () async {
                      await widgets.createPopup().show(
                            context: context,
                            title: 'Popup',
                            msg: 'This is a popup',
                          );
                    },
                    text: 'show popup',
                  ),
                  Gap(styles.insets.sm),
                  AppButton.from(
                    onPressed: () async {
                      await showModal(
                        context,
                        child: const OkCancelModal(
                          title: 'Modal',
                          msg: 'This is a modal',
                        ),
                      );
                    },
                    expand: true,
                    text: 'show modal',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
