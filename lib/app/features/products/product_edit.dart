import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/app/features/user_info/cubit/user_info_cubit.dart';
import 'package:orders_accountant/app/widgets/app_fullscreen_modal.dart';
import 'package:orders_accountant/app/widgets/app_text_field.dart';
import 'package:orders_accountant/app/widgets/controls/buttons.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/domain/models/product.dart';

Future<Product?> showEditProductPopup(
  BuildContext context, {
  required Product product,
}) async {
  Product? result;

  result = await showAdaptiveDialog(
      context: context,
      builder: (_) => ProductEdit(
            product: product,
          ));

  print('result: $result, ${result?.displayName}');

  return result;
}

class ProductEdit extends StatefulWidget {
  final Product product;

  const ProductEdit({super.key, required this.product});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  int newQuantity = 0;
  bool hasError = false;

  @override
  void initState() {
    newQuantity = widget.product.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Color baseColor;
    switch (widget.product.type) {
      case kPackaging:
        baseColor = colors.oliveDrab;
        break;
      case kGift:
        baseColor = colors.dustyPurple;
        break;
      default:
        baseColor = colors.steelGrey;
    }

    return AppFullscreenModal(
        child: Column(
      children: [
        const Gap(4),
        Row(
          children: [
            Container(width: 44),
            Expanded(
              child: Text(
                'Редагування товару',
                style: textStyles.title2.semiBold.c(colors.steelGrey),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: SizedBox(
                width: 44,
                child: Icon(Icons.close, color: colors.steelGrey),
              ),
            ),
          ],
        ),
        const Gap(32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          //color: colors.greyLight,
          decoration: BoxDecoration(
            color: colors.greyLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: baseColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(8),
              Text(
                widget.product.displayName,
                style: textStyles.title2.c(baseColor),
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: Text('Ціна закупки: ${widget.product.costPrice} грн',
                        style: textStyles.bodySmall.semiBold.c(baseColor)),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text('Ціна продажу: ${widget.product.price} грн',
                        style: textStyles.bodySmall.semiBold.c(baseColor)),
                  ),
                ],
              ),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: Text('Категорія: ${widget.product.category}',
                        style: textStyles.bodySmall.semiBold.c(baseColor)),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Row(
                      children: [
                        Text('Кількість:',
                            style: textStyles.bodySmall.semiBold.c(baseColor)),
                        SizedBox(
                          width: 80,
                          child: AppTextField(
                            keyboardType: TextInputType.number,
                            initialValue: widget.product.quantity.toString(),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            onChanged: (value) {
                              final int? result = int.tryParse(value);
                              if (result != null && result >= 0) {
                                hasError = false;
                                newQuantity = result;
                              } else {
                                hasError = true;
                              }
                              newQuantity = int.tryParse(value) ?? 0;
                            },
                          ),
                        ),
                        Text('шт',
                            style: textStyles.bodySmall.semiBold.c(baseColor)),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: Text('Тип: ${widget.product.type}',
                        style: textStyles.bodySmall.semiBold.c(baseColor)),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text('Код: ${widget.product.id}',
                        style: textStyles.bodySmall.semiBold.c(baseColor)),
                  ),
                ],
              ),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: Text('Деталі: ${widget.product.details}',
                        style: textStyles.bodySmall.semiBold.c(baseColor)),
                  ),
                ],
              ),
              const Gap(60),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        const Gap(32),
        AppButton.filled(
          text: 'Зберегти',
          onPressed: () {
            if (hasError) {
              userInfoCubit.showSnackbar(
                message:
                    'Некоректно введена кількість товару. Введіть ціле число',
                severity: MessageSeverity.warning,
              );
              return;
            }
            print('saving newQuantity: $newQuantity');
            context
                .read<ProductsCubit>()
                .updateProductQuantity(widget.product.id, newQuantity);
            context.pop();
          },
        ),
        const Gap(16),
      ],
    ));
  }
}
