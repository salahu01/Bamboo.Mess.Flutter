part of 'sales.provider.dart';

class UploadNotifier extends StateNotifier<String> {
  UploadNotifier() : super('Save');

  void uploadFoodAndCategory(product, {List<String?>? ids = const []}) async {
    try {
      state = 'Loading...';
      if (product is List) {
        await MongoDataBase().insertProduct(ProductModel(name: product[0], price: product[2], categaryName: product[1]), ids);
      } else {
        await MongoDataBase().insertCategory(CategoryModel(productIds: const [], categaryName: product));
      }
      state = 'Success';
    } catch (e) {
      log('error : $e');
      state = 'Retry';
    }
  }
}

class StoreBillNotifier extends StateNotifier<String> {
  StoreBillNotifier() : super('Save');

  void storeBill(List<RecieptProduct> products, WidgetRef ref) async {
    try {
      state = 'Loading...';
      final res = await LocalDataBase().storeProducts(products);
      if (res) {
        ref.read(billProductProvider.notifier).clearProducts();
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
