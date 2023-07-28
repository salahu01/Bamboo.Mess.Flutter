import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/foods/foods_view.dart';
import 'package:freelance/src/modules/labours/labours_view.dart';
import 'package:freelance/src/modules/receipts/view/receipts_screen.dart';
import 'package:freelance/src/modules/sales/sales_screen.dart';
import 'package:freelance/src/modules/settings/settings_view.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final _key = GlobalKey<ScaffoldState>();
  final ValueNotifier<bool> _showBills = ValueNotifier(false);
  final _drawerIcons = [
    Icons.shopping_basket,
    Icons.receipt_outlined,
    Icons.category,
    Icons.settings,
    Icons.person
  ];
  final _drawerTitles = ['Sales', 'Receipts', 'Foods', 'Settings', 'Labours'];
  final _appBarTitles = ['Receipts', 'Foods', 'Settings', 'Labours'];
  int _drawerIndex = 0;

  @override
  void initState() {
    primary.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: primary.value,
        systemOverlayStyle:
            SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
        leadingWidth: 120,
        leading: GestureDetector(
          onTap: () => _key.currentState?.openDrawer(),
          child: Card(
            margin: const EdgeInsets.all(30),
            elevation: 10,
            color: primary.value,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.menu, size: 34, color: Colors.white),
          ),
        ),
        centerTitle: true,
        elevation: 4,
        title: [
          Visibility(
            visible: !_showBills.value,
            replacement: const Text('Saved Bills',
                style: TextStyle(color: Colors.white, fontSize: 40)),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 10,
              child: SizedBox(
                width: 600,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search foods here ...',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.8)),
                    prefixIcon:
                        const Icon(Icons.search, color: Colors.black, size: 28),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          ...List.generate(
              4,
              (i) => Text(_appBarTitles[i],
                  style: const TextStyle(color: Colors.white, fontSize: 40)))
        ][_drawerIndex],
        actions: [
          Visibility(
            visible: _drawerIndex == 0,
            child: GestureDetector(
              onTap: () {
                setState(
                    () => _showBills.value = _showBills.value ? false : true);
              },
              child: Card(
                margin: const EdgeInsets.all(30),
                elevation: 10,
                color: primary.value,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, anim) => RotationTransition(
                      turns: child.key == const ValueKey('icon1')
                          ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                          : Tween<double>(begin: 0.75, end: 1).animate(anim),
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                    child: _showBills.value
                        ? const Icon(Icons.close,
                            key: ValueKey('icon1'), size: 34)
                        : const Icon(Icons.save,
                            key: ValueKey('icon2'), size: 34),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          width: 600,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            margin: const EdgeInsets.all(20),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                  height: 132,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Text('BAMBOO MESS',
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600))),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 8),
                            child: Divider(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  5,
                  (i) {
                    final selected = _drawerIndex == i;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: ListTile(
                          selected: selected,
                          selectedTileColor: primary.value,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          leading: Icon(_drawerIcons[i],
                              size: 32, color: Colors.black),
                          title: Text(_drawerTitles[i],
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          onTap: () {
                            setState(() => _drawerIndex = i);
                            Navigator.pop(context);
                          }),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: [
        SalesView(showBills: _showBills),
        const ReceiptsView(),
        const FoodsView(startAnimation: true),
        const SettingsView(),
        const LaboursView(),
      ][_drawerIndex],
    );
  }

  @override
  void dispose() {
    _showBills.dispose();
    super.dispose();
  }
}
