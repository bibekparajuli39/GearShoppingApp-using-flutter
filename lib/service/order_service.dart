import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gearapp/models/cart_item_model.dart';
import 'package:uuid/uuid.dart';

class OrderService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> placeOrder({
    required String userId,
    required List<CartItemModel> cartitems,
    required double totalPrice,
  }) async {
    final orderId = const Uuid().v4();

    final orderData = {
      'orderId': orderId,
      'userId': userId,
      'items': cartitems.map((e) {
        return {
          'productId': e.product.id,
          'name': e.product.name,
          'price': e.product.price,
          'imageUrl': e.product.imageUrl,
          'quantity': e.quantity,
        };
      }).toList(),
      'totalPrice': totalPrice,
      'status': 'pending',
      'createdAt': Timestamp.now(),
    };

    //It set global collection
    await db.collection('orders').doc(orderId).set(orderData);

    // sub collection inside users
    await db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .set(orderData);

    // clear the cart after place the order
    final cartRef = db.collection('users').doc(userId).collection('cart');

    final snapshot = await cartRef.get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
