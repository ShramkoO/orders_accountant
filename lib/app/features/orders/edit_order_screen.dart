import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/orders/cubit/orders_cubit.dart';
import 'package:orders_accountant/app/widgets/app_text_field.dart';
import 'package:orders_accountant/app/widgets/controls/buttons.dart';
import 'package:orders_accountant/app/widgets/progress_bar.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
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
                    onPressed: () {},
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
                          context.read<OrdersCubit>().customerChanged(value);
                        },
                      ),
                      const Gap(12),
                      const Label('Товари:'),
                      ProductsListCard(
                        products: [],
                        productType: kProduct,
                      ),
                      const Gap(12),
                      Label('Пакування:', color: colors.oliveDrab),
                      ProductsListCard(
                        products: [],
                        productType: kPackaging,
                      ),
                      const Gap(12),
                      Label('Подарунки:', color: colors.dustyPurple),
                      ProductsListCard(
                        products: [],
                        productType: kGift,
                      ),
                      const Gap(100)
                    ],
                  ),
                )))
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
    required this.products,
    required this.productType,
  });

  final List<Product> products;
  final int productType;

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

    final length = products.length;

    //find max price to build percentages

    products.sort((a, b) => (a.createdAt.compareTo(b.createdAt)));

    double maxPrice = 0;
    for (int i = 0; i < products.length; i++) {
      if (products[i].price > maxPrice) maxPrice = products[i].price;
    }

    return RepaintBoundary(
      child: Container(
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
                        Container(
                            alignment: Alignment.topLeft,
                            height: 80,
                            padding: const EdgeInsets.only(top: 29, left: 39),
                            child: Text('...список пустий',
                                style: textStyles.body)),
                      for (int i = 0; i < products.length; i++)
                        ProductItem(
                            product: products.elementAt(i),
                            progress:
                                (products.elementAt(i).price / maxPrice) * 100),
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
                ),
              ],
            ),
          )),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.progress,
  });

  final Product product;
  final double progress;

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

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            height: 42.25,
            child: Row(
              children: [
                Text(product.displayName, style: textStyles.body.c(color)),
                Expanded(child: Container()),
                Text(
                  '${product.price} грн',
                  style: textStyles.body,
                )
              ],
            ),
          ),
          ProgressBar(
              maxPoints: 100,
              livePoints: progress,
              color: color,
              secondColor: colors.greyMedium,
              width: 1.75),
        ],
      ),
    );
  }
}
