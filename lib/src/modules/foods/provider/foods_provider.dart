import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/models/product.model.dart';

final selCategoryProvider = StateProvider<CategoryModel?>((ref) {
  return;
});

final selDeletedProvider = StateProvider<List<ProductModel>>((ref) {
  return [];
});
