import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';

class Dialogs {
  static Future<void> singleFieldDailog(
    BuildContext context, {
    List<String?>? ids = const [],
    String? categoryName,
    void Function()? onSuccess,
  }) {
    final titleCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final isProduct = categoryName != null;
    final key = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer(builder: (context, ref, child) {
          final state = ref.watch(uploadProvider);
          if (state == 'Success') {
            onSuccess?.call();
            Navigator.pop(context);
          }
          return AlertDialog(
            title: Center(child: Text('Add ${isProduct ? 'Food' : 'Category'}')),
            titleTextStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: SizedBox(
              width: 600,
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    isProduct ? 2 : 1,
                    (i) => Padding(
                      padding: EdgeInsets.only(bottom: isProduct && i == 0 ? 24 : 0),
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
                          hintText: i == 0 ? 'Enter ${isProduct ? 'food' : 'category'} here ...' : 'Enter price here ...',
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
                  titleCtrl.clear();
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: primary.value, fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  if (state == 'Loading...') return;
                  if (key.currentState?.validate() ?? false)
                    ref.read(uploadProvider.notifier).uploadFoodAndCategory(isProduct ? [titleCtrl.text, categoryName, num.parse(priceCtrl.text)] : titleCtrl.text, ids: ids);
                },
                child: Text(state, style: TextStyle(color: primary.value, fontSize: 18)),
              )
            ],
          );
        });
      },
    );
  }
}
