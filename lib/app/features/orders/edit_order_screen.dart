import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/orders/cubit/edit_order_cubit.dart';
import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/app/features/products/widgets/product_select_popup.dart';
import 'package:orders_accountant/app/widgets/app_dropdown.dart';
import 'package:orders_accountant/app/widgets/app_text_field.dart';
import 'package:orders_accountant/app/widgets/controls/buttons.dart';
import 'package:orders_accountant/app/widgets/progress_bar.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/domain/models/order.dart';
import 'package:orders_accountant/domain/models/product.dart';

Future<void> showEditOrderBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    builder: (_) => FractionallySizedBox(
        heightFactor: 0.93,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: EditOrderScreen())),
  );
}

class EditOrderScreen extends StatelessWidget {
  static const routeName = '/edit-order';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditOrderCubit, EditOrderState>(
        builder: (context, state) {
      return Container(
          child: Column(
        children: [
          Container(
            height: 103,
            color: colors.steelGrey,
            child: Column(
              children: [
                const Gap(13),
                Text('Замовлення №____',
                    style: textStyles.body.bold.c(colors.greyMedium)),
                const Gap(12),
                Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    AppButton.filled(
                      text: 'Відхилити',
                      textStyle: textStyles.body.bold.c(colors.steelGrey),
                      bgColor: colors.periwinkleBlue,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Gap(20),
                    AppButton.filled(
                      text: 'Зберегти',
                      bgColor: colors.lavenderGrey,
                      textStyle: textStyles.body.bold.c(colors.steelGrey),
                      onPressed: () async {
                        final savedContext = context;
                        if (await context.read<EditOrderCubit>().saveOrder()) {
                          Navigator.of(savedContext).pop();
                        }
                      },
                    ),
                    const Gap(16),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
                  color: colors.greyMedium,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Gap(16),
                        const Label('Замовник'),
                        AppTextField(
                          onChanged: (value) {
                            context
                                .read<EditOrderCubit>()
                                .customerChanged(value);
                          },
                          error: state.customerError ?? '',
                        ),
                        const Gap(16),
                        const Label('Стан замовлення'),
                        AppDropdown(
                          items: OrderStatusExtension.names,
                          selectedValue: state.order?.status.name ?? '',
                          nameToDisplayName:
                              OrderStatusExtension.nameToDisplayName,
                          onChanged: (value) {
                            context
                                .read<EditOrderCubit>()
                                .statusChanged(value ?? '');
                          },
                        ),
                        const Gap(12),
                        const Label('Товари:'),
                        ProductsListCard(
                          productIds: state.order?.products ?? [],
                          productType: kProduct,
                          highlightErrorEmtyList:
                              state.productsError == 'Products are required',
                        ),
                        const Gap(12),
                        Label('Пакування:', color: colors.oliveDrab),
                        ProductsListCard(
                          productIds: state.order?.products ?? [],
                          productType: kPackaging,
                        ),
                        const Gap(12),
                        Label('Подарунки:', color: colors.dustyPurple),
                        ProductsListCard(
                          productIds: state.order?.products ?? [],
                          productType: kGift,
                        ),
                        const Gap(20),
                        _buildSum(state.order!),
                        const Gap(100),
                      ],
                    ),
                  )))
        ],
      ));
    });
  }

  _buildSum(Order order) {
    double sum = 0;
    double selfCost = 0;
    double revenue = 0;

    if (order.products != null) {
      for (int i = 0; i < order.products!.length; i++) {
        final productId = order.products![i];
        sum += order.productsDetailed![productId.toString()]!['price'] *
            order.productsDetailed![productId.toString()]!['quantity'];
        selfCost +=
            order.productsDetailed![productId.toString()]!['cost_price'] *
                order.productsDetailed![productId.toString()]!['quantity'];
      }
    }
    revenue = sum - selfCost;

    print('sum: $sum, revenue: $revenue');

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'До сплати: ',
                    style: textStyles.bodySmall.semiBold.c(colors.steelGrey),
                  ),
                ),
                Text(
                  ' ${sum.toStringAsFixed(2)} грн',
                  style: textStyles.body.semiBold.c(colors.steelGrey),
                ),
              ],
            ),
            Container(height: 4),
            Container(height: 1, color: colors.steelGrey.withOpacity(0.5)),
            Container(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Собівартість:',
                    style: textStyles.bodySmall.semiBold.c(colors.steelGrey),
                  ),
                ),
                Text(
                  '${selfCost.toStringAsFixed(2)} грн',
                  style: textStyles.bodySmall.semiBold.c(colors.steelGrey),
                ),
              ],
            ),
            Container(height: 4),
            Container(height: 1, color: colors.steelGrey.withOpacity(0.5)),
            Container(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Прибуок:',
                    style: textStyles.bodySmall.semiBold.c(colors.steelGrey),
                  ),
                ),
                Text(
                  '${revenue.toStringAsFixed(2)} грн',
                  style: textStyles.bodySmall.semiBold.c(colors.steelGrey),
                ),
              ],
            ),
            Container(height: 4),
            Container(height: 1, color: colors.steelGrey.withOpacity(0.5)),
            Container(height: 12),
          ],
        ));
  }
}

class Label extends StatelessWidget {
  const Label(this.labelText, {Key? key, this.color}) : super(key: key);

  final String labelText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 32, bottom: 4),
          child: Text(
            labelText,
            style: textStyles.body.semiBold.c(color ?? colors.steelGrey),
          ),
        ),
      ],
    );
  }
}

class ProductsListCard extends StatelessWidget {
  const ProductsListCard({
    super.key,
    required this.productIds,
    required this.productType,
    this.highlightErrorEmtyList = false,
  });

  final List<int> productIds;
  final int productType;
  final bool highlightErrorEmtyList;

  @override
  Widget build(BuildContext context) {
    late Color paintColor;
    switch (productType) {
      case kProduct: //tovar
        paintColor = colors.periwinkleBlue;
        break;
      case kPackaging: //packaging
        paintColor = colors.oliveDrab;
        break;
      case kGift: //gift
        paintColor = colors.dustyPurple;
        break;
      default:
        paintColor = colors.lavenderGrey;
    }

    //find max price to build percentages

    final EditOrderCubit editOrderCubit = context.read<EditOrderCubit>();

    List<Product> products = productIds
        .map((id) => context.read<ProductsCubit>().getProductById(id))
        .toList();

    products =
        products.where((element) => element.type == productType).toList();

    final length = products.length;

    products.sort((a, b) => (a.createdAt.compareTo(b.createdAt)));

    double maxPrice = 0;
    for (int i = 0; i < products.length; i++) {
      if (editOrderCubit.getProductPrice(products[i]) > maxPrice) {
        maxPrice = editOrderCubit.getProductPrice(products[i]);
      }
    }
    if (maxPrice == 0) {
      maxPrice = 1;
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colors.steelGrey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 12,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        //height: 332,
        width: double.infinity,
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                //height: double.infinity,
                decoration: BoxDecoration(
                    color: colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(color: colors.greyMedium, width: 1)),
                child: Column(
                  children: [
                    Container(
                      height: 52,
                    ),
                    if (length == 0)
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.topLeft,
                          height: 80,
                          padding: const EdgeInsets.only(top: 29, left: 39),
                          child: Text('...список пустий',
                              style: textStyles.body.c(highlightErrorEmtyList
                                  ? colors.red
                                  : colors.greyMedium))),
                    const Gap(8),
                    for (int i = 0; i < products.length; i++)
                      ProductItem(
                        product: products.elementAt(i),
                        progress: (editOrderCubit.getProductPrice(
                                  products.elementAt(i),
                                ) /
                                maxPrice) *
                            100,
                        quantity:
                            editOrderCubit.getQuantity(products.elementAt(i)),
                      ),
                    Container(height: 24)
                  ],
                ),
              ),
              Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: paintColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      final editOrderCubit = context.read<EditOrderCubit>();
                      final selectionResult = await showProductSelectPopup(
                          context,
                          filterProductType: productType);
                      if (selectionResult != null) {
                        editOrderCubit.addProduct(selectionResult);
                      }
                    },
                    child: Row(
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Text(
                          'Додати',
                          style: textStyles.body.bold.c(colors.lavenderGrey),
                        ),
                        const Gap(8),
                        Icon(
                          Icons.add_circle_outline_rounded,
                          color: colors.white,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.progress,
    required this.quantity,
  });

  final Product product;
  final double progress;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (product.type) {
      case kProduct: //tovar
        color = colors.steelGrey;
        break;
      case kPackaging: //packaging
        color = colors.oliveDrab;
        break;
      case kGift: //gift
        color = colors.dustyPurple;
        break;
      default:
        colors.lavenderGrey;
    }

    final double displayPrice = product.type == kProduct
        ? product.price
        : product.costPrice; //if product is not a tovar, display total price

    return Container(
      //height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          Container(
            //height: 42.25,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Text(
                    product.displayName[0],
                    style: textStyles.body.bold.c(color),
                  ),
                ),
                const Gap(7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.displayName,
                        style: textStyles.body.semiBold.c(color),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          if (quantity > 1) ...[
                            Text(
                              displayPrice.toStringAsFixed(2),
                              style: textStyles.bodySmall.c(color),
                            ),
                            Transform.translate(
                                offset: const Offset(0, 2),
                                child: Text(' грн',
                                    style: textStyles.captionSmall.c(color))),
                            Text(
                              ' x $quantity = ',
                              style: textStyles.bodySmall.c(color),
                            ),
                            const Gap(4),
                          ],
                          Text(
                            (displayPrice * quantity).toStringAsFixed(2),
                            style: textStyles.bodySmall.bold.c(color),
                          ),
                          Transform.translate(
                              offset: const Offset(0, 2),
                              child: Text(' грн',
                                  style:
                                      textStyles.captionSmall.bold.c(color))),
                        ],
                      )
                    ],
                  ),
                ),
                const Gap(4),
                //minus, count and plus
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<EditOrderCubit>()
                            .decreaseQuantity(product);
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          size: 16,
                          color: colors.steelGrey,
                        ),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      quantity.toString(),
                      style: textStyles.body.c(color),
                    ),
                    const Gap(8),
                    InkWell(
                      onTap: () {
                        context
                            .read<EditOrderCubit>()
                            .increaseQuantity(product);
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: colors.steelGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(8),
          ProgressBar(
              maxPoints: 100,
              livePoints: progress,
              color: color,
              secondColor: colors.greyMedium,
              width: 1.75),
          const Gap(12),
        ],
      ),
    );
  }
}
