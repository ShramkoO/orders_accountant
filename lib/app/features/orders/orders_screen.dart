import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/orders/cubit/orders_cubit.dart';
import 'package:orders_accountant/app/features/orders/edit_order_screen.dart';
import 'package:orders_accountant/app/features/orders/widgets/date_selector.dart';
import 'package:orders_accountant/app/features/orders/widgets/orders_list.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  // Every Screen should have a routeName, for safe access in the router
  static const String routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(styles.insets.body),
              child: Column(
                children: [
                  const DateSelector(),
                  const Gap(16),
                  if (state.isLoading)
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(colors.accent1),
                        ),
                      ),
                    )
                  else
                    OrdersList(orders: state.orders)
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                onPressed: () {
                  showEditOrderBottomSheet(context);
                },
                //label: const Text('Add'),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      },
    );
  }
}
