import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/employee.model.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/modules/labours/provider/upload.employee.provider.dart';

final laboursProvider = FutureProvider.autoDispose<List<EmployeeModel>>((ref) async {
  final labours = await MongoDataBase().getEmployees;
  return labours;
});

final uploadEmployeeProvider = StateNotifierProvider<UploadEmployeeNotifier, String>((ref) {
  return UploadEmployeeNotifier();
});
