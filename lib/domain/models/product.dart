class Product {
  final BigInt id;
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
      id: BigInt.parse(json['id'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'] as String,
      displayName: json['display_name'] as String,
      price: json['price'].toDouble(),
      costPrice: json['cost_price'].toDouble(),
      type: json['type'] as int,
      details: json['details'] as Map<String, dynamic>,
      category: json['category'] as String,
      imageUrl: json['image_url'] as String,
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
