import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/employee.model.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/modules/labours/provider/labour.provider.dart';

class UploadEmployeeNotifier extends StateNotifier<String> {
  UploadEmployeeNotifier() : super('Save');

  void uploadFoodAndCategory(List<String> vals, ref, context) async {
    try {
      state = 'Loading...';
      await MongoDataBase().insertEmployee(EmployeeModel(name: vals[0], phone: vals[1], age: vals[2]));
      ref.refresh(laboursProvider);
      Navigator.pop(context);
      state = 'Success';
    } catch (e) {
      log('error : $e');
      state = 'Retry';
    }
  }
}
