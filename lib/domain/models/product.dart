import 'package:orders_accountant/domain/models/category.dart';

class Product extends CustomTreeNode {
  final int id;
  final DateTime createdAt;
  final String name;
  final String displayName;
  final double price;
  final double costPrice;
  final int type;
  final Map<String, dynamic> details;
  final String category;
  final String imageUrl;

  const Product({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.displayName,
    required this.price,
    required this.costPrice,
    required this.type,
    required this.details,
    required this.category,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'] ?? '!!no name',
      displayName: json['display_name'] ?? '!!no name',
      price: (json['price'] ?? 0.0) / 1,
      costPrice: (json['cost_price'] ?? 0.0) / 1,
      type: json['type'] ?? 0,
      details: (json['details'] ?? <String, dynamic>{}) as Map<String, dynamic>,
      category: json['category'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'display_name': displayName,
      'price': price,
      'cost_price': costPrice,
      'type': type,
      'details': details,
      'category': category,
      'image_url': imageUrl,
    };
  }
}
