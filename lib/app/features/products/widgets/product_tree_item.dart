import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/products/product_edit.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/core/di/locator.dart';
import 'package:orders_accountant/data/services/supabase_service.dart';
import 'package:orders_accountant/domain/models/product.dart';

class ProductTreeItem extends StatelessWidget {
  final Product product;
  final bool isSelected;
  final bool isEditable;

  const ProductTreeItem({
    Key? key,
    required this.product,
    required this.isSelected,
    required this.isEditable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSelected) print('(selected product: ${product.displayName})');

    Color baseColor = colors.steelGrey;
    if (product.type == kPackaging) {
      baseColor = colors.oliveDrab;
    } else if (product.type == kGift) {
      baseColor = colors.dustyPurple;
    }
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        //height: isSelected ? 128 : 50,

        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 150 - 32,
        ),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected ? colors.white : colors.white.withOpacity(0.764),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: baseColor.withOpacity(0.5), width: 0.5),
        ),
        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 8),
        clipBehavior: Clip.none,
        child: AnimatedSize(
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductTreeItemCollapsedPart(
                product: product,
                baseColor: baseColor,
              ),
              if (isSelected)
                ProductTreeItemExpandedPart(
                  product: product,
                  baseColor: baseColor,
                  isEditable: isEditable,
                ),
            ],
          ),
        ));
  }
}

class ProductTreeItemCollapsedPart extends StatelessWidget {
  const ProductTreeItemCollapsedPart(
      {super.key, required this.product, required this.baseColor});

  final Product product;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    //resolve image url
    String resolvedImageUrl = '';
    if (product.imageUrl.isNotEmpty) {
      resolvedImageUrl =
          locator<SupabaseService>().getImageUrl(product.imageUrl);
    }

    String productQuantityText = '${product.quantity}';
    if (product.quantityOrdered != 0) {
      productQuantityText +=
          ' / (${product.quantity - product.quantityOrdered})';
    }
    productQuantityText += ' шт';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (resolvedImageUrl.isNotEmpty)
          Container(
            height: 35,
            //padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colors.slateGrey,
              border: Border.all(color: baseColor, width: 1.5),
            ),
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.5),
              child: Image.network(
                resolvedImageUrl,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                cacheHeight: 128,
                cacheWidth: 128,
              ),
            ),
          )
        else
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: baseColor,
              border: Border.all(color: baseColor),
            ),
            alignment: Alignment.center,
            child: Text(
              product.displayName[0],
              style: textStyles.body.bold.c(colors.white),
            ),
          ),
        const Gap(8),
        Expanded(
          child: Text(product.displayName,
              style: textStyles.bodyCompactHeight.semiBold
                  .c(colors.periwinkleBlue)),
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${product.price} грн',
                style: textStyles.bodyCompactHeight.semiBold
                    .c(colors.periwinkleBlue)),
            const Gap(1),
            Text(productQuantityText,
                style: textStyles.bodySmall.semiBold
                    .c(baseColor.withOpacity(0.64)))
          ],
        )
      ],
    );
  }
}

class ProductTreeItemExpandedPart extends StatelessWidget {
  const ProductTreeItemExpandedPart({
    super.key,
    required this.product,
    required this.baseColor,
    required this.isEditable,
  });

  final Product product;
  final Color baseColor;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 1, width: double.infinity),
              Text('Ціна закупки: ${product.costPrice} грн',
                  style: textStyles.bodySmall.semiBold.c(baseColor)),
              const Gap(1),
              Text('Категорія: ${product.category}',
                  style: textStyles.bodySmall.semiBold.c(baseColor)),
              const Gap(1),
              Text('Тип: ${product.getProductTypeName()}',
                  style: textStyles.bodySmall.semiBold.c(baseColor)),
              const Gap(1),
              Text('Деталі: ${product.details}',
                  style: textStyles.bodySmall.semiBold.c(baseColor)),
            ],
          ),
          if (isEditable)
            Positioned(
              bottom: 2,
              right: 4,
              child:
                  // ignore: deprecated_member_use
                  Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: baseColor.withOpacity(0.24),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print('edit button pressed');
                      showEditProductPopup(context, product: product);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit,
                            size: 16, color: colors.periwinkleBlue),
                        const Gap(4),
                        Text('Редагувати',
                            style: TextStyle(
                                color: colors.periwinkleBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
