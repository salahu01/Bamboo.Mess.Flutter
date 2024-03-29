import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/main.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/models/product.model.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/modules/foods/provider/foods_provider.dart';
import 'package:freelance/src/modules/sales/providers/bill.provider.dart';
part 'upload.provider.dart';

final categoryProvider = FutureProvider.autoDispose<List<CategoryModel>>((ref) async {
  final categories = await MongoDataBase().getCategories;
  if (categories.isNotEmpty) {
    final allProducts = await MongoDataBase().getProducts;
    categories.insert(categories.length, CategoryModel(productIds: const [], categaryName: 'All', products: allProducts));
    ref.read(selCategoryProvider.notifier).update((_) => categories.length == 1 ? null : categories.first);
  }
  return categories;
});

final storedBillsProvider = FutureProvider.autoDispose<List<List>>((ref) async {
  final products = await LocalDataBase().retriveProducts();
  return products;
});

final selectedBillProvider = StateProvider<int?>((ref) {
  return null;
});

final uploadProvider = StateNotifierProvider<UploadNotifier, String>((ref) {
  return UploadNotifier();
});

final billProductProvider = StateNotifierProvider<BillProductsNotifier, List<RecieptProduct>>((ref) {
  return BillProductsNotifier();
});

final storeBillsProvider = StateNotifierProvider<StoreBillNotifier, String>((ref) {
  return StoreBillNotifier();
});
