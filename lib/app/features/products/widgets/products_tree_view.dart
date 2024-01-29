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

          return TreeView.simpleTyped<CustomTreeNode, TreeNode<CustomTreeNode>>(
            showRootNode: false,
            expansionIndicatorBuilder: (context, node) =>
                ChevronIndicator.rightDown(
              tree: node,
              color: Colors.blue[700],
              padding: const EdgeInsets.all(8),
            ),
            indentation: const Indentation(
                style: IndentStyle.roundJoint, thickness: 1.5),
            expansionBehavior: ExpansionBehavior.collapseOthersAndSnapToTop,
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
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colors.darkSlateBlue),
        width: 200,
        padding: const EdgeInsets.all(12),
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
                  ),
                ),
              )
            else
              const Gap(32),
            const Gap(8),
            Text(category.displayText),
          ],
        ));
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
        width: 200,
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: colors.slateGrey),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            if (resolvedImageUrl.isNotEmpty)
              Image.network(
                resolvedImageUrl,
                width: 32,
                height: 32,
              )
            else
              const Gap(32),
            const Gap(8),
            Text(product.name),
          ],
        ));
  }
}
