import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> singleFieldDailog(
    BuildContext context, {
    required String title,
    required String validatorText,
    required String leftButtonText,
  }) {
    final addCatrgoryCtrl = TextEditingController();
    final addCategoryKey = GlobalKey<FormFieldState>();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          titleTextStyle: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          content: SizedBox(
            width: 600,
            child: TextFormField(
              key: addCategoryKey,
              controller: addCatrgoryCtrl,
              validator: (value) => value == null || value.isEmpty ? validatorText : null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                hintText: validatorText,
                hintStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  addCatrgoryCtrl.clear();
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                if (addCategoryKey.currentState?.validate() ?? false) {
                  addCatrgoryCtrl.clear();
                  Navigator.pop(context);
                }
              },
              child: Text(leftButtonText),
            ),
          ],
        );
      },
    );
  }
}
