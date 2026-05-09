import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gearapp/models/cart_item_model.dart';
import 'package:gearapp/models/product_model.dart';

class CartServices {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addToCart({
    required String userId,
    required ProductModel productId,
  }) async {
    // creating firestore reference
    final ref = db
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId.id);

    // fetching the document from firestore if ot exits
    final doc = await ref.get();

    if (doc.exists) {
      //update the quantity by 1  if documnet exists
      await ref.update({'quantity': FieldValue.increment(1)});
    } else {
      // return all data and changed the quantity to 1
      await ref.set({
        'name': productId.name,
        'price': productId.price,
        'imageUrl': productId.imageUrl,
        'description': productId.description,
        'quantity': 1,
      });
    }
  }

  //streaming live data from firestore
  Stream<List<CartItemModel>> getCartItem(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return CartItemModel(
              product: ProductModel(
                id: doc.id,
                name: data['name'] ?? '',
                description: data['description'] ?? '',
                price: (data['price'] ?? 0).toInt(),
                imageUrl: data['imageUrl'] ?? '',
              ),
              quantity: data['quantity'] ?? 1,
            );
          }).toList();
        });
  }
}
