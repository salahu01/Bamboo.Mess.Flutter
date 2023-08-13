part of 'sales.provider.dart';

class UploadNotifier extends StateNotifier<String> {
  UploadNotifier() : super('Save');

  void upload(product, {List<String?>? ids = const []}) async {
    try {
      state = 'Loading...';
      if (product is List) {
        await DataBase().insertProduct(ProductModel(name: product[0], price: product[2], categaryName: product[1]), ids);
      } else {
        await DataBase().insertCategory(CategoryModel(productIds: const [], categaryName: product));
      }
      state = 'Success';
    } catch (e) {
      log('error : $e');
      state = 'Retry';
    }
  }
}
