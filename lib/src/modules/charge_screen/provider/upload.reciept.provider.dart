import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';

class UploadRecieptNotifier extends StateNotifier<String> {
  UploadRecieptNotifier() : super('Charge Amount');

  void createReciept(RecieptModel reciept, ref) async {
    try {
      state = 'Loading...';
      await MongoDataBase().insertReciept(reciept);
      final selected = ref.read(selectedBillProvider);
      if (selected != null) {
        await LocalDataBase().removeProducts(selected);
      }
      ref
        ..read(billProductProvider.notifier).clearProducts()
        ..read(selectedBillProvider.notifier).update((state) => state = null)
        ..refresh(storedBillsProvider);
      state = 'Success';
    } catch (e) {
      state = 'Retry';
    }
  }
}
