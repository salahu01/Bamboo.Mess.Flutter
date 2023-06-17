import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/modules/dashboard/view/category_view.dart';
import 'package:freelance/src/modules/dashboard/view/saved_items_view.dart';

import 'package:hexcolor/hexcolor.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final _key = GlobalKey<ScaffoldState>();
  bool _showBills = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: HexColor('#deb4ff'),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
        leadingWidth: 120,
        leading: GestureDetector(
          onTap: () => _key.currentState?.openDrawer(),
          child: Card(
            margin: const EdgeInsets.all(30),
            elevation: 10,
            color: HexColor('#deb4ff'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.menu, size: 34, color: Colors.white),
          ),
        ),
        centerTitle: true,
        elevation: 4,
        title: Visibility(
          visible: !_showBills,
          replacement: const Text('Saved Bills', style: TextStyle(color: Colors.white, fontSize: 40)),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 10,
            child: SizedBox(
              width: 600,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search foods here ...',
                  hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
                  prefixIcon: const Icon(Icons.search, color: Colors.black, size: 28),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => setState(() => _showBills = _showBills ? false : true),
            child: Card(
              margin: const EdgeInsets.all(30),
              elevation: 10,
              color: HexColor('#deb4ff'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(_showBills ? Icons.close : Icons.save, size: 34, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 600,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: HexColor('#deb4ff'),
              ),
              accountName: const Text(
                "Owner",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                "Bamboo Mess",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: const Icon(
                Icons.home,
                size: 32,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: const Icon(
                Icons.receipt,
                size: 32,
              ),
              title: const Text(
                "Receipt",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: const Icon(
                Icons.list,
                size: 32,
              ),
              title: const Text(
                "Items",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: const Icon(
                Icons.settings,
                size: 32,
              ),
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Visibility(
        visible: !_showBills,
        replacement: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              width: 500,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: index == 1 ? HexColor('#deb4ff') : Colors.transparent, width: 4)),
                margin: const EdgeInsets.only(bottom: 24, left: 12, right: 24, top: 24),
                elevation: 4,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Text('Billing', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Total Amount : 100',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        child: Row(
          children: [
            Flexible(
              flex: 5,
              child: CategoryView(),
            ),
            Flexible(
              flex: 2,
              child: SavedItemsView(),
            ),
          ],
        ),
      ),
    );
  }
}
