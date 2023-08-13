import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/employee.model.dart';
import 'package:freelance/src/core/services/db/db.services.dart';

final employeesProvider = FutureProvider.autoDispose<List<EmployeeModel>>((ref) async {
  final employees = await DataBase().getEmployees;
  ref.keepAlive();
  return employees;
});
