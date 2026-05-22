import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gearapp/models/catagories_model.dart';

class CategoryService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategory() async {
    final snapshot = await db.collection('categories').get();

    return snapshot.docs.map((doc) {
      return CategoryModel.fromMap(doc.data(), doc.id);
    }).toList();
  }
}
