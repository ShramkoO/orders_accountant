import 'dart:io';
import 'dart:ui';

import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/products/widgets/products_tree_view.dart';
import 'package:orders_accountant/app/widgets/app_fullscreen_modal.dart';
import 'package:orders_accountant/app/widgets/app_text_field.dart';
import 'package:orders_accountant/app/widgets/controls/buttons.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/domain/models/product.dart';

Future<Product?> showProductSelectPopup(
  BuildContext context, {
  int? filterProductType,
}) async {
  Product? result;

  result = await showAdaptiveDialog(
      context: context,
      builder: (_) => ProductSelectPopup(
            filterProductType: filterProductType,
          ));

  print('result: $result, ${result?.displayName}');

  return result;
}

const debounceTimeMs = 1000;
const debounceTime = Duration(milliseconds: debounceTimeMs);
const debounceCheckTime = Duration(milliseconds: debounceTimeMs - 2);

class ProductSelectPopup extends StatefulWidget {
  const ProductSelectPopup({super.key, this.filterProductType});

  final int? filterProductType;

  @override
  State<ProductSelectPopup> createState() => _ProductSelectPopupState();
}

class _ProductSelectPopupState extends State<ProductSelectPopup> {
  Product? _selectedProduct;

  String searchWord = '';
  String _searchWordDebounced = '';
  DateTime lastSearchChange = DateTime.now();

  final bool enableBlur = Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return AppFullscreenModal(
      child: GestureDetector(
        onTap: () {
          print('empty space tapped');
          if (_selectedProduct != null) {
            setState(() {
              _selectedProduct = null;
            });
          }
        },
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Text(
                    'Оберіть товар',
                    textAlign: TextAlign.center,
                    style: textStyles.title2.semiBold.c(colors.steelGrey),
                  ),
                ),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: colors.steelGrey,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(4),
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
            const Gap(16),
            Expanded(
              child: ProductsTreeView(
                searchWord: _searchWordDebounced,
                selectedProduct: _selectedProduct,
                onProductSelected: (productSelected) {
                  setState(() {
                    _selectedProduct = productSelected;
                  });
                },
                onProductDoubleTap: (productSelected) {
                  context.pop(_selectedProduct);
                },
                filterProductType: widget.filterProductType,
                productsEditable: false,
              ),
            ),
            const Gap(16),
            AppButton.filled(
                onPressed: _selectedProduct != null
                    ? () {
                        context.pop(_selectedProduct);
                      }
                    : null,
                text: 'Додати товар'),
          ],
        ),
      ),
    );
  }
}
