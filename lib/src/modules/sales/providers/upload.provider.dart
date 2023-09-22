part of 'sales.provider.dart';

class UploadNotifier extends StateNotifier<String> {
  UploadNotifier() : super('Save');

  void uploadFoodAndCategory(product, {String? subProduct, List<String?>? ids = const [], void Function()? onSuccess}) async {
    try {
      state = 'Loading...';
      if (product is List) {
        if (subProduct != null) {
          await MongoDataBase().insertSubProduct(ProductModel(name: product[0], price: product[2], categaryName: product[1]), subProduct, ids);
        } else if (product.length == 3) {
          await MongoDataBase().insertProduct(ProductModel(name: product[0], price: product[2], categaryName: product[1]), ids);
        } else {
          await MongoDataBase().insertProduct(ProductModel(name: product[0], categaryName: product[1], productIds: const []), ids);
        }
      } else {
        await MongoDataBase().insertCategory(CategoryModel(productIds: const [], categaryName: product));
      }
      onSuccess?.call();
      Navigator.pop(MyApp.navigator.currentContext!);
      state = 'Save';
    } catch (e) {
      state = 'Retry';
    }
  }
}

class StoreBillNotifier extends StateNotifier<String> {
  StoreBillNotifier() : super('Save');

  void storeBill(List<RecieptProduct> products, ref) async {
    try {
      var res = false;
      state = 'Loading...';
      final index = ref.read(selectedBillProvider);
      res = await (index == null ? LocalDataBase().storeProducts(products) : LocalDataBase().updateProducts(products, index));
      if (res) {
        ref
          ..read(billProductProvider.notifier).clearProducts()
          ..read(selectedBillProvider.notifier).update((state) => state = null)
          ..refresh(storedBillsProvider);
        state = 'Save';
      } else {
        state = 'Retry';
      }
    } catch (e) {
      log('error : $e');
      state = 'Retry';
    }
  }
}
