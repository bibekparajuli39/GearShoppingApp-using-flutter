import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gearapp/models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore firebase;
  ProductRepository(this.firebase);

  Future<List<ProductModel>> fetchProducts() async {
    final snapshot = await firebase.collection('products').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<List<ProductModel>> fetchProductsByCategory(
    String categoryName,
  ) async {
    final snapshot = await firebase
        .collection('products')
        .where('category', isEqualTo: categoryName)
        .get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}
