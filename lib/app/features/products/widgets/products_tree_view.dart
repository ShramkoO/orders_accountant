import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:orders_accountant/app/features/products/cubit/products_cubit.dart';
import 'package:orders_accountant/core/constants/common_libs.dart';
import 'package:orders_accountant/core/di/locator.dart';
import 'package:orders_accountant/data/services/supabase_service.dart';
import 'package:orders_accountant/domain/models/category.dart';
import 'package:orders_accountant/domain/models/product.dart';

class ProductsTreeView extends StatefulWidget {
  const ProductsTreeView({Key? key}) : super(key: key);

  @override
  State<ProductsTreeView> createState() => _ProductsTreeViewState();
}

class _ProductsTreeViewState extends State<ProductsTreeView> {
  late TreeViewController? _controller;

  final TreeNode<CustomTreeNode> productsTree = TreeNode.root();
  bool treeIsBuilt = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
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
                    _controller = controller;
                    //if (true) controller.expandAllChildren(productsTree);
                  },
                  tree: productsTree,
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
    print('building tree nodes');

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

    for (Product product in state.products) {
      List<String> categoryPath = product.category.split('/');
      Node current = productsTree;

      for (String node in categoryPath) {
        if (node.isEmpty) continue;
        current = current.children[node]!;
      }

      // Now 'current' is the node corresponding to the product's category
      // You can associate the product with this node as needed
      print(
          'adding product ${product.name} to ${current.key}, key: ${product.id.toString()}');
      current.add(TreeNode<Product>(
        key: product.id.toString(),
        data: state.products.where((e) => e.id == product.id).first,
      ));
    }
  }

  _buildCategoryNode(Category category) {
    //resolve image url
    String resolvedImageUrl = '';
    if (category.imageUrl.isNotEmpty) {
      resolvedImageUrl =
          locator<SupabaseService>().getImageUrl(category.imageUrl);
    }

    print('building category node ${category.displayText}');
    return Container(
      padding:
          category.id == 'stickers/' ? const EdgeInsets.only(top: 16) : null,
      child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: colors.slateGrey),
          width: 240,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              if (resolvedImageUrl.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colors.slateGrey,
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
                  style: textStyles.body.semiBold.c(colors.lavenderGrey)),
            ],
          )),
    );
  }

  _buildProductNode(Product product) {
    print('building product node ${product.name}');

    //resolve image url
    String resolvedImageUrl = '';
    if (product.imageUrl.isNotEmpty) {
      resolvedImageUrl =
          locator<SupabaseService>().getImageUrl(product.imageUrl);
    }

    return Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 150 - 32,
        ),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.periwinkleBlue, width: 1.5)),
        padding: const EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (resolvedImageUrl.isNotEmpty)
              Container(
                //padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colors.slateGrey,
                  border: Border.all(color: colors.periwinkleBlue, width: 1.5),
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
                  color: colors.darkSlateBlue,
                  border: Border.all(color: colors.midnightBlue),
                ),
              ),
            const Gap(8),
            Text(product.displayName,
                style: textStyles.body.semiBold.c(colors.periwinkleBlue)),
          ],
        ));
  }
}
