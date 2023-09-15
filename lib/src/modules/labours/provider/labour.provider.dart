import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/employee.model.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';

final laboursProvider = FutureProvider.autoDispose<List<EmployeeModel>>((ref) async {
  final labours = await MongoDataBase().getEmployees;
  return labours;
});
