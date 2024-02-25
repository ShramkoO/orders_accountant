//Очікування оплати
//Виконано

enum OrderStatus {
  pending,
  completed,
}

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.completed:
        return 'completed';
    }
  }

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Очікування оплати';
      case OrderStatus.completed:
        return 'Виконано';
    }
  }

  static String nameToDisplayName(String name) {
    switch (name) {
      case 'pending':
        return 'Очікування оплати';
      case 'completed':
        return 'Виконано';
      default:
        return 'Очікування оплати';
    }
  }

  static List<String> get names {
    return OrderStatus.values.map((e) => e.name).toList();
  }

  static OrderStatus fromString(String? state) {
    switch (state) {
      case 'pending':
        return OrderStatus.pending;
      case 'completed':
        return OrderStatus.completed;
      default:
        return OrderStatus.pending;
    }
  }
}

class Order {
  final int id;
  final DateTime createdAt;
  final OrderStatus status;
  final List<int>? products;
  final Map<String, Map<String, dynamic>>? productsDetailed;
  final double price;
  final double costPrice;
  final String customer;
  final Map<String, dynamic>? details;

  const Order({
    required this.id,
    required this.createdAt,
    required this.status,
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
      status: OrderStatusExtension.fromString(json['state']),
      products: json['products'] as List<int>,
      productsDetailed:
          json['products_detailed'] as Map<String, Map<String, dynamic>>?,
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
      'state': status.name,
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
    OrderStatus? status,
    List<int>? products,
    Map<String, Map<String, dynamic>>? productsDetailed,
    double? price,
    double? costPrice,
    String? customer,
    Map<String, dynamic>? details,
  }) {
    return Order(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      products: products ?? this.products,
      productsDetailed: productsDetailed ?? this.productsDetailed,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      customer: customer ?? this.customer,
      details: details ?? this.details,
    );
  }
}
