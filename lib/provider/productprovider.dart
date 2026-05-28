import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gearapp/repository/product_repository.dart';
import 'package:riverpod/riverpod.dart';

final firestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

//repository provider
final productRepositoryProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ProductRepository(firestore);
});

///fetch products provider
final fetchProductsProvider = FutureProvider((ref) async {
  final productRepository = ref.read(productRepositoryProvider);
  return await productRepository.fetchProducts();
});

final productsByCategoryProvider =
    FutureProvider.family<List<dynamic>, String?>((ref, categoryName) async {
      final productRepository = ref.read(productRepositoryProvider);

      if (categoryName == null) {
        return await productRepository.fetchProducts();
      } else {
        return await productRepository.fetchProductsByCategory(categoryName);
      }
    });

//it store when user type in search
final searchProvider = StateProvider<String>((ref) => '');
