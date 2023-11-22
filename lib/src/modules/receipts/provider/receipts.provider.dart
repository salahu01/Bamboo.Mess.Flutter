import 'package:freelance/src/core/extensions/date_time.extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';

final recieptsProvider = FutureProvider.autoDispose.family<List<List<RecieptModel>>, String?>((ref, sortType) async {
  final recieptsFomMongo = (await MongoDataBase().getReciepts).reversed.toList();
  List<List<RecieptModel>> reciepts = [];
  for (var e in recieptsFomMongo) {
    final index = reciepts.indexWhere((_) => '${_.first.date?.order}' == '${e.date?.order}');
    index == -1 ? reciepts.add([e]) : reciepts[index].add(e);
  }
  if (sortType == 'Price: Low to High') {
    for (var i = 0; i < reciepts.length; i++) {
      reciepts[i].sort((a, b) => (a.totalAmount ?? 0).compareTo(b.totalAmount ?? 0));
    }
  }
  if (sortType == 'Price: High to Low') {
    for (var i = 0; i < reciepts.length; i++) {
      reciepts[i].sort((a, b) => (b.totalAmount ?? 0).compareTo(a.totalAmount ?? 0));
    }
  }
  return reciepts;
});
