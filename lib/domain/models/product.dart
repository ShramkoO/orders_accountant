import 'package:orders_accountant/domain/models/category.dart';

const kProduct = 0;
const kPackaging = 1;
const kGift = 2;

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
  final int quantity;
  final int quantityOrdered;

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
    required this.quantity,
    required this.quantityOrdered,
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
      quantity: json['quantity'] ?? 0,
      quantityOrdered: json['quantity_ordered'] ?? 0,
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
      'quantity': quantity,
      'quantity_ordered': quantityOrdered,
    };
  }

  //in Ukrainian
  String getProductTypeName() {
    switch (type) {
      case kProduct:
        return 'Товар';
      case kPackaging:
        return 'Упаковка';
      case kGift:
        return 'Подарунок';
      default:
        return 'Товар';
    }
  }

  Product copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? displayName,
    double? price,
    double? costPrice,
    int? type,
    Map<String, dynamic>? details,
    String? category,
    String? imageUrl,
    int? quantity,
    int? quantityOrdered,
  }) {
    return Product(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      type: type ?? this.type,
      details: details ?? this.details,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      quantityOrdered: quantityOrdered ?? this.quantityOrdered,
    );
  }
}
