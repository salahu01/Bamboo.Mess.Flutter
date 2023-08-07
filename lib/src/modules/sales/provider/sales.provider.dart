import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/services/db/db.services.dart';

final categoryProvider = FutureProvider.autoDispose<List<CategoryModel>>((ref) async {
  ref.keepAlive();
  return await DataBase().getCategories;
});
