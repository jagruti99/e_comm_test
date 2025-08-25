/// Product model normalized from both:
/// - restaurant-search -> data.restaurants[].items[]
/// - restaurant-detail-v2 -> data.items_list[]
class Product {
  final String id; // keep as string to unify
  final String name;
  final String description;
  final String image;
  final double price;
  final String currencyCode;
  final int? restaurantId; // for search items
  final String? restaurantName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.currencyCode,
    this.restaurantId,
    this.restaurantName,
  });

  factory Product.fromSearchJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: (json['short_description'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      price: _toDouble(json['final_price'] ?? json['regular_price'] ?? '0'),
      currencyCode: (json['currency_code'] ?? 'KD').toString(),
      restaurantId: (json['restaurant']?['id']),
      restaurantName: (json['restaurant']?['name'])?.toString(),
    );
  }

  factory Product.fromDetailJson(
    Map<String, dynamic> json, {
    int? restaurantId,
    String? restaurantName,
  }) {
    return Product(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: (json['short_description'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      price: _toDouble(
        json['final_price'] ??
            json['orignal_final_price'] ??
            json['regular_price'] ??
            '0',
      ),
      currencyCode: 'KD',
      restaurantId: restaurantId,
      restaurantName: restaurantName,
    );
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}
