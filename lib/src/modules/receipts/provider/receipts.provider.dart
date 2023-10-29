import 'package:freelance/src/core/extensions/date_time.extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';

final recieptsProvider = FutureProvider.autoDispose<List<List<RecieptModel>>>((ref) async {
  final recieptsFomMongo = (await MongoDataBase().getReciepts).reversed.toList();
  List<List<RecieptModel>> reciepts = [];
  for (var e in recieptsFomMongo) {
    final index = reciepts.indexWhere((_) => '${_.first.date?.order}' == '${e.date?.order}');
    index == -1 ? reciepts.add([e]) : reciepts[index].add(e);
  }
  return reciepts;
});
