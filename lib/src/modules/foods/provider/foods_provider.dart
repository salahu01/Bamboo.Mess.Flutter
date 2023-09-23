import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/models/product.model.dart';

final selCategoryProvider = StateProvider<CategoryModel?>((ref) {
  return;
});

final selSubCategoryProvider = StateProvider<ProductModel?>((ref) {
  return;
});

final selProducts = StateProvider<List<ProductModel>>((ref) {
  return [];
});

final selSubCategoryProducts = StateProvider<List<ProductModel>>((ref) {
  return [];
});

void clearSelects(WidgetRef ref) {
  ref.read(selProducts.notifier).update((state) => []);
  ref.read(selSubCategoryProducts.notifier).update((state) => []);
  ref.read(selSubCategoryProvider.notifier).update((state) => null);
  ref.read(selCategoryProvider.notifier).update((state) => null);
}

void clearSubSelects(WidgetRef ref) {
  ref.read(selProducts.notifier).update((state) => []);
  ref.read(selSubCategoryProducts.notifier).update((state) => []);
}
