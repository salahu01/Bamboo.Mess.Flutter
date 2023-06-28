import 'package:flutter/material.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/sales/category_view.dart';
import 'package:freelance/src/modules/sales/saved_items_view.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key, required this.showBills});
  final ValueNotifier<bool> showBills;

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  bool _startAnimation = false;
  @override
  void initState() {
    startAnimation();
    widget.showBills.addListener(() {
      if (mounted) startAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: !widget.showBills.value,
      replacement: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 300 + (index * 200)),
            transform: Matrix4.translationValues(_startAnimation ? 0 : width, 0, 0),
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            width: 500,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: index == 1 ? primary.value : Colors.transparent, width: 4)),
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
            child: CategoryView(startAnimation: _startAnimation),
          ),
          const Flexible(
            flex: 2,
            child: SavedItemsView(),
          ),
        ],
      ),
    );
  }

  void startAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _startAnimation = true);
    });
    _startAnimation = false;
  }
}
