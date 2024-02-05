class Order {
  final int id;
  final DateTime createdAt;
  final String? state;
  final List<int>? products;
  final Map<int, Map<String, dynamic>>? productsDetailed;
  final double price;
  final double costPrice;
  final String customer;
  final Map<String, dynamic>? details;

  const Order({
    required this.id,
    required this.createdAt,
    this.state,
    this.products,
    this.productsDetailed,
    required this.price,
    required this.costPrice,
    required this.customer,
    this.details,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      state: json['state'] as String?,
      products: json['products'] as List<int>,
      productsDetailed:
          json['products_detailed'] as Map<int, Map<String, dynamic>>?,
      price: json['price']?.toDouble(),
      costPrice: json['cost_price']?.toDouble(),
      customer: json['customer'] ?? '',
      details: json['details'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'created_at': createdAt.toIso8601String(),
      'state': state,
      'products': products?.map((item) => item.toString()).toList(),
      'products_detailed': productsDetailed,
      'price': price,
      'cost_price': costPrice,
      'customer': customer.toString(),
      'details': details,
    };
  }

  double get revenue => (price) - (costPrice);

  Order copyWith({
    int? id,
    DateTime? createdAt,
    String? state,
    List<int>? products,
    Map<int, Map<String, dynamic>>? productsDetailed,
    double? price,
    double? costPrice,
    String? customer,
    Map<String, dynamic>? details,
  }) {
    return Order(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      state: state ?? this.state,
      products: products ?? this.products,
      productsDetailed: productsDetailed ?? this.productsDetailed,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      customer: customer ?? this.customer,
      details: details ?? this.details,
    );
  }
}
