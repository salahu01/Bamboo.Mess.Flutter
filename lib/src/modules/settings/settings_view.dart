import 'package:flutter/material.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: primary,
        builder: (context, color, child) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: ListView(
              children: [
                Text(
                  'Themes',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: color),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Accent',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Colors.black),
                      ),
                      const Spacer(),
                      ...List.generate(primaryColors.length, (i) {   
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CircleAvatar(
                            backgroundColor: primaryColors[i] == primary.value ? Colors.black : Colors.white,
                            radius: 38,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 36,
                              child: GestureDetector(
                                onTap: () {
                                  Dialogs.loadingDailog(context, text: 'Updating...');
                                  LocalDataBase().updateColor(i).then((_) {
                                    Navigator.pop(context);
                                  });
                                  primary.value = primaryColors[i]!;
                                },
                                child: CircleAvatar(
                                  backgroundColor: primaryColors[i],
                                  radius: 32,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
