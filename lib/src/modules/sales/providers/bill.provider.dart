import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/product.model.dart';
import 'package:freelance/src/core/models/reciept.model.dart';

class BillProductsNotifier extends StateNotifier<List<RecieptProduct>> {
  BillProductsNotifier() : super([]);

  void addProductToBill(ProductModel? product) {
    final already = state.indexWhere((e) => e.name == product?.name);
    if (already == -1) {
      state = [...state, RecieptProduct(count: 1, name: product?.name, price: product?.price)];
    } else {
      final updatedState = List<RecieptProduct>.from(state);
      updatedState[already] = RecieptProduct(count: (state[already].count ?? 0) + 1, name: state[already].name, price: state[already].price);
      state = updatedState;
    }
  }

  void removeProductFromBill(int index) {
    final list = state;
    state[index].count != 1 ? list[index].count = list[index].count! - 1 : list.removeAt(index);
    state = [...list];
  }

  void updateProductFromBill(int index, num price) {
    final list = state;
    list[index].price = price;
    state = [...list];
  }

  void clearProducts() {
    state = [];
  }

  void selectBill(List<RecieptProduct> products) {
    state = products;
  }
}
