import 'package:flutter/material.dart';
import 'package:freelance/src/modules/dashboard/view/dashboard_view.dart';
import 'package:hexcolor/hexcolor.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: HexColor('#deb4ff'),
        leadingWidth: 120,
        leading: GestureDetector(
          onTap: () => _key.currentState?.openDrawer(),
          child: Card(
            margin: const EdgeInsets.all(30),
            elevation: 10,
            color: HexColor('#deb4ff'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.menu, size: 34, color: Colors.white),
          ),
        ),
        title: const Text(
          "Receipts",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 4,
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const DashBoardView(),
                  ),
                );
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
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  color: Colors.red,
                    
                ),
              ),
              Flexible(
                flex: 5,
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.86,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.only(top: 24),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                              ),
                              const Text(
                                '3500.00',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.6),
                              ),
                              const Text(
                                "Total",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          const Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "      Employee : ${"Owner"}",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "      POS : ${"POS"}",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "     Dine in",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Divider(color: Colors.black),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              physics: const BouncingScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (context, i) {
                                i += 1;
                                return ListTile(
                                  dense: true,
                                  title: const Text(
                                    'Pani puri ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.6),
                                  ),
                                  subtitle: Text(
                                    'Qty : $i',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.6),
                                  ),
                                  trailing: Text(
                                    '\$ ${i}00',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.6),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
