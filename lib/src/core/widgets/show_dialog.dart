import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/labours/provider/labour.provider.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';

class Dialogs {
  static Future<void> editBillDailog(
    BuildContext context, {
    required int index,
    List<RecieptProduct>? product,
  }) {
    final priceCtrl = TextEditingController(text: "${(product?[index].count ?? 0) * (product?[index].price ?? 0)}");
    final key = GlobalKey<FormState>();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final state = ref.watch(uploadProvider);
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Edit Amount'),
              titleTextStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: SizedBox(
                width: 600,
                child: Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
                      controller: priceCtrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the value !';
                        }
                        try {
                          num.parse(
                            priceCtrl.text,
                          );
                        } catch (e) {
                          return 'Please enter the value !';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                        hintText: 'Enter price here ...',
                        hintStyle: const TextStyle(fontSize: 20),
                      ),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    priceCtrl.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: primary.value, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    if (key.currentState?.validate() ?? false) {
                      final price = num.parse(priceCtrl.text);
                      ref.read(billProductProvider.notifier).updateProductFromBill(index, price);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(state, style: TextStyle(color: primary.value, fontSize: 18)),
                )
              ],
            );
          });
        });
      },
    );
  }

  static Future<void> singleFieldDailog(
    BuildContext context, {
    List<String?>? ids = const [],
    String? categoryName,
    String? subProduct,
    void Function()? onSuccess,
  }) {
    final titleCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final isProduct = categoryName != null;
    final isSubProduct = subProduct != null;
    final key = GlobalKey<FormState>();
    var selectedTyoeInFood = 'One Product';
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final state = ref.watch(uploadProvider);
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  const Spacer(),
                  Text('Add ${isProduct || isSubProduct ? 'Food' : 'Category'}'),
                  const Spacer(),
                  Visibility(
                    visible: isProduct && !isSubProduct,
                    child: DropdownButton(
                      underline: const SizedBox.shrink(),
                      value: selectedTyoeInFood,
                      items: ['One Product', 'Category']
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: const TextStyle(fontWeight: FontWeight.bold)),
                              onTap: () => setState(() => selectedTyoeInFood = e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              titleTextStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: SizedBox(
                width: 600,
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        selectedTyoeInFood == 'One Product' && isProduct || isSubProduct ? 2 : 1,
                        (i) => Padding(
                          padding: EdgeInsets.only(bottom: i == 0 ? 24 : 0),
                          child: TextFormField(
                            controller: i == 0 ? titleCtrl : priceCtrl,
                            validator: (value) => value == null || value.isEmpty ? 'Please enter the value !' : null,
                            keyboardType: i == 1 ? TextInputType.number : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                              hintText: i == 0 ? 'Enter ${isProduct || isSubProduct ? 'food' : 'category'} here ...' : 'Enter price here ...',
                              hintStyle: const TextStyle(fontSize: 20),
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    titleCtrl.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: primary.value, fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    if (state == 'Loading...') return;
                    if (key.currentState?.validate() ?? false) {
                      //* adding category
                      if (!isProduct && !isSubProduct) {
                        ref.read(uploadProvider.notifier).uploadFoodAndCategory(titleCtrl.text, ids: ids, onSuccess: onSuccess);
                        return;
                      }
                      final isOneProduct = selectedTyoeInFood == 'One Product';
                      final List list = [titleCtrl.text, categoryName];
                      if (isOneProduct) list.add(num.parse(priceCtrl.text));
                      ref.read(uploadProvider.notifier).uploadFoodAndCategory(list, ids: ids, subProduct: subProduct, onSuccess: onSuccess);
                    }
                  },
                  child: Text(state, style: TextStyle(color: primary.value, fontSize: 18)),
                )
              ],
            );
          });
        });
      },
    );
  }

  static Future<void> addEmployeeDialog(BuildContext context) {
    final ctrls = List.generate(3, (i) => TextEditingController());
    final hints = ['Enter Employee Name ', 'Enter Phone Phone', 'Enter Gender '];
    final key = GlobalKey<FormState>();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final state = ref.watch(uploadEmployeeProvider);
          return AlertDialog(
            title: const Center(child: Text('Add Employee')),
            titleTextStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: SizedBox(
              width: 600,
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: Form(
                key: key,
                child: ListView(
                  children: List.generate(
                    3,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: TextFormField(
                        controller: ctrls[i],
                        validator: (value) => value == null || value.isEmpty ? 'Please enter the value !' : null,
                        keyboardType: i == 1 ? TextInputType.number : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                          hintText: '${hints[i]} here ...',
                          hintStyle: const TextStyle(fontSize: 20),
                        ),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  for (var e in ctrls) {
                    e.clear();
                  }
                },
                child: Text('Cancel', style: TextStyle(color: primary.value, fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  if (state == 'Loading...') return;
                  if (key.currentState?.validate() ?? false) {
                    ref.read(uploadEmployeeProvider.notifier).uploadFoodAndCategory(ctrls.map((e) => e.text).toList(), ref, context);
                  }
                },
                child: Text(state, style: TextStyle(color: primary.value, fontSize: 18)),
              )
            ],
          );
        });
      },
    );
  }

  static Future<void> loadingDailog(BuildContext context, {String? text}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SizedBox(
              width: 600,
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      text ?? 'Deleating...',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    LinearProgressIndicator(color: primary.value),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  static void showSnack(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text(text, style: const TextStyle(fontSize: 40)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: MediaQuery.of(context).size.height * 0.06),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
      ));
  }
}
