import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/app/features/products/widgets/product_tree_item.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/core/di/locator.dart';
import 'package:orders_accountant/data/services/supabase_service.dart';
import 'package:orders_accountant/domain/models/category.dart';
import 'package:orders_accountant/domain/models/product.dart';

class ProductsTreeView extends StatefulWidget {
  const ProductsTreeView({
    Key? key,
    this.onProductSelected,
    this.onProductDoubleTap,
    this.searchWord = '',
    this.selectedProduct,
    this.filterProductType,
    required this.productsEditable,
  }) : super(key: key);

  final Function(Product)? onProductSelected;
  final Function(Product)? onProductDoubleTap;
  final String searchWord;
  final Product? selectedProduct;
  final int? filterProductType;
  final bool productsEditable;

  @override
  State<ProductsTreeView> createState() => _ProductsTreeViewState();
}

class _ProductsTreeViewState extends State<ProductsTreeView> {
  TreeNode<CustomTreeNode> productsTree = TreeNode<CustomTreeNode>.root();
  bool treeIsBuilt = false;

  DateTime lastItemTappedAt = DateTime.now();

  @override
  void didUpdateWidget(covariant ProductsTreeView oldWidget) {
    if (oldWidget.searchWord != widget.searchWord) {
      print('search word changed');
      //search word changed
      //rebuild tree
      treeIsBuilt = false;
      //productsTree.clear();
    }
    if (oldWidget.selectedProduct != widget.selectedProduct) {
      print('selected product changed');
      if (widget.selectedProduct != null) {
        //selectedItemId = widget.selectedProduct!.id.toString();
      } else {
        selectedItemId = '';
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  String oldSearchWord = '';

  String lastSelectedItemId = '';
  String selectedItemId = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listenWhen: (p, c) {
        if (p is ProductsLoaded && c is ProductsLoaded) {
          print('p.products != c.products: ${p.products != c.products}');
        }
        return p is ProductsLoaded &&
            c is ProductsLoaded &&
            p.products != c.products;
      },
      listener: (context, state) => setState(() {
        treeIsBuilt = false;
        productsTree.clear();
        print('products changed');
      }),
      builder: (context, state) {
        print('tree widget builder');
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          //build tree

          if (!treeIsBuilt) {
            _buildTreeNodes(state);
            treeIsBuilt = true;
          }

          return Column(
            children: [
              Expanded(
                child: TreeView.simpleTyped<CustomTreeNode,
                    TreeNode<CustomTreeNode>>(
                  showRootNode: false,
                  expansionIndicatorBuilder: (context, node) =>
                      ChevronIndicator.rightDown(
                    tree: node,
                    color: colors.lavenderGrey,
                    padding: EdgeInsets.only(
                        top: 13.25 + (node.key == 'stickers' ? 16 : 0),
                        right: 6),
                  ),
                  indentation: Indentation(
                    style: IndentStyle.roundJoint,
                    thickness: 1.5,
                    color: colors.periwinkleBlue,
                  ),
                  expansionBehavior: ExpansionBehavior.none,
                  onTreeReady: (controller) {
                    //if (true) controller.expandAllChildren(productsTree);
                  },
                  tree: productsTree,
                  onItemTap: (node) {
                    if (node.data is Product) {
                      if ((selectedItemId ==
                                  (node.data as Product).id.toString() ||
                              lastSelectedItemId ==
                                  (node.data as Product).id.toString()) &&
                          DateTime.now()
                                  .difference(lastItemTappedAt)
                                  .inMilliseconds <
                              500) {
                        print('double tap');
                        widget.onProductDoubleTap?.call(node.data as Product);
                        return;
                      }

                      lastItemTappedAt = DateTime.now();
                      //print('product tapped, id: ${(node.data as Product).id}');
                      widget.onProductSelected?.call(node.data as Product);
                      setState(() {
                        if (selectedItemId ==
                            (node.data as Product).id.toString()) {
                          lastSelectedItemId = selectedItemId;
                          selectedItemId = '';
                        } else {
                          selectedItemId = (node.data as Product).id.toString();
                        }
                        //selectedItemId = (node.data as Product).id.toString();
                      });

                      //detect double tap
                    }
                  },
                  builder: (context, node) {
                    if (node.data is Category) {
                      return _buildCategoryNode(node.data as Category);
                    } else if (node.data is Product) {
                      return _buildProductNode(node.data as Product);
                    } else {
                      return const Center(child: Text('Error'));
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }

  void _buildTreeNodes(ProductsLoaded state) {
    //print('building tree nodes');

    productsTree = TreeNode<CustomTreeNode>.root();

    for (Category category in state.categories) {
      final List<String> path = category.id.split('/');

      Node currentNode = productsTree;

      String assembledPath = '';
      for (final node in path) {
        //check if this node already exists
        if (node.isEmpty) continue;
        if (currentNode.children.containsKey(node)) {
          currentNode = currentNode.children[node]!;
        } else {
          assembledPath += '$node/';
          print(
            'adding node $assembledPath, key: $node',
          );
          currentNode.add(TreeNode<Category>(
              key: node,
              parent: currentNode,
              data:
                  state.categories.where((e) => e.id == assembledPath).first));
          currentNode = currentNode.children[node]!;
        }
      }
    }
    final splittedSearchWords = widget.searchWord.split(' ');

    print(widget.searchWord.toLowerCase());
    final filteredProducts = state.products.where((e) {
      if (widget.filterProductType != null) {
        if (e.type != widget.filterProductType) return false;
      }
      for (final word in splittedSearchWords) {
        if (!e.displayName.toLowerCase().contains(word.toLowerCase())) {
          return false;
        }
      }
      return true;
    }).toList();

    for (Product product in filteredProducts) {
      List<String> categoryPath = product.category.split('/');
      Node current = productsTree;

      for (String node in categoryPath) {
        if (node.isEmpty) continue;
        current = current.children[node]!;
      }

      // Now 'current' is the node corresponding to the product's category
      // You can associate the product with this node as needed
      //print(
      //    'adding product ${product.name} to ${current.key}, key: ${product.id.toString()}');
      current.add(TreeNode<Product>(
        key: product.id.toString(),
        data: state.products.where((e) => e.id == product.id).first,
      ));
    }

    //go throug the tree once again and remove empty categories

    if (widget.filterProductType != null) {
      productsTree.removeWhere((node) {
        final nodeElement = productsTree.elementAt(node.key);

        if (node.children.isEmpty && nodeElement is TreeNode<Category>) {
          return true;
        }
        return false;
      });
    }
  }

  _buildCategoryNode(Category category) {
    //resolve image url
    String resolvedImageUrl = '';
    if (category.imageUrl.isNotEmpty) {
      resolvedImageUrl =
          locator<SupabaseService>().getImageUrl(category.imageUrl);
    }

    //print('building category node ${category.displayText}');
    return Container(
      padding:
          category.id == 'stickers/' ? const EdgeInsets.only(top: 16) : null,
      child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colors.periwinkleBlue),
          width: 240,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              if (resolvedImageUrl.isNotEmpty)
                Container(
                  //padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colors.periwinkleBlue,
                    border: Border.all(color: colors.slateGrey),
                  ),
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
                const Gap(32),
              const Gap(8),
              Text(category.displayText,
                  style: textStyles.body.semiBold.c(colors.white)),
            ],
          )),
    );
  }

  _buildProductNode(Product product) {
    //print('building product node ${product.displayName}');
    final bool isSelected = product.id.toString() == selectedItemId;
    return ProductTreeItem(
      product: product,
      isSelected: isSelected,
      isEditable: widget.productsEditable,
    );
  }
}
