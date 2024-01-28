class Order {
  final BigInt id;
  final DateTime createdAt;
  final String? state;
  final List<BigInt>? products;
  final Map<String, dynamic>? productsDetailed;
  final double? price;
  final double? costPrice;
  final BigInt? customer;
  final Map<String, dynamic>? details;

  const Order({
    required this.id,
    required this.createdAt,
    this.state,
    this.products,
    this.productsDetailed,
    this.price,
    this.costPrice,
    this.customer,
    this.details,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: BigInt.parse(json['id'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      state: json['state'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((item) => BigInt.parse(item.toString()))
          .toList(),
      productsDetailed: json['products_detailed'] as Map<String, dynamic>?,
      price: json['price']?.toDouble(),
      costPrice: json['cost_price']?.toDouble(),
      customer: json['customer'] != null
          ? BigInt.parse(json['customer'].toString())
          : null,
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
      'customer': customer?.toString(),
      'details': details,
    };
  }
}
