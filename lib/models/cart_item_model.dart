class CartItemModel {
  final String id; // cart row id (UUID)
  final String productId; // IMPORTANT
  final String name;
  final int price;
  final String imageUrl;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  /// FROM SUPABASE
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'].toString(),
      productId: map['product_id'].toString(),
      name: map['name'] ?? '',
      price: (map['price'] as num).toInt(),
      imageUrl: map['imageUrl'] ?? '', // ✅ matches your DB
      quantity: map['quantity'] ?? 1,
    );
  }

  /// TO SUPABASE (INSERT)
  Map<String, dynamic> toMap({required String userId}) {
    return {
      'user_id': userId,
      'product_id': productId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
