import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/models/product.model.dart';
import 'package:freelance/src/core/services/db/db.services.dart';
part './upload.provider.dart';

final categoryProvider = FutureProvider.autoDispose<List<CategoryModel>>((ref) async {
  final categories = await DataBase().getCategories;
  final allProducts = await DataBase().getProducts;
  categories.insert(categories.length, CategoryModel(productIds: const [], categaryName: 'All', products: allProducts));
  ref.keepAlive();
  return categories;
});

final uploadProvider = StateNotifierProvider<UploadNotifier, String>((ref) {
  return UploadNotifier();
});
