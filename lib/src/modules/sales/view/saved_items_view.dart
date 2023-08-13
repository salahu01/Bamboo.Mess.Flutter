import 'package:flutter/material.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/charge_screen/view/charge_screen.dart';

class SavedItemsView extends StatelessWidget {
  const SavedItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 24, left: 12, right: 24, top: 24),
        elevation: 4,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Billing',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 128, vertical: 8),
              child: Divider(color: Colors.black),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, i) {
                  i += 1;
                  return ListTile(
                    dense: true,
                    title: const Text(
                      'Pani puri ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                    ),
                    subtitle: Text(
                      'Qty : $i',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                    ),
                    trailing: Text(
                      '\$ ${i}00',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Divider(color: Colors.black),
            ),
            const Text(
              'Total Amount : 100',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.6),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customBotton("SAVE", () {}, context),
                  customBotton("CHARGE", () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ChargeScreen()));
                  }, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customBotton(
    String name,
    VoidCallback onPressed,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01)),
        backgroundColor: primary.value,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.08,
        height: 72,
        child: Center(
          child: Text(name, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
