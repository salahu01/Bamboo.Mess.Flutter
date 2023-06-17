import 'package:flutter/material.dart';
import 'package:freelance/src/modules/custom/slide_and_remove.dart';

class SavedItemsView extends StatefulWidget {
  const SavedItemsView({super.key});

  @override
  State<SavedItemsView> createState() => _SavedItemsViewState();
}

class _SavedItemsViewState extends State<SavedItemsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: TextButton(
          onPressed: () {},
          child: const Text(
            "SAVED ITEMS",
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.normal),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                '1',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: 10,
              itemBuilder: (context, index) {
                return SlideBillMenu(
                  menuItems: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ],
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    trailing: Text(
                      "$index x \$1200",
                      style: const TextStyle(fontSize: 20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    title: Text(
                      'Item $index',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), child: Divider()),
          const Text('Total Amount : \$5000', style: TextStyle(fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customBotton("SAVE", () {}),
                customBotton("CHARGE", () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customBotton(String name, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01)))),
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
