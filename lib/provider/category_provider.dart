import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gearapp/models/catagories_model.dart';
import 'package:gearapp/service/category.dart';

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final categoryService = Provider((ref) {
  return CategoryService();
});

final categoryProvider = FutureProvider<List<CategoryModel>>((ref) {
  final service = ref.watch(categoryService);
  return service.getCategory();
});
