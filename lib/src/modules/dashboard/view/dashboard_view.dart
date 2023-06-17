import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/modules/dashboard/view/category_view.dart';
import 'package:freelance/src/modules/dashboard/view/saved_items_view.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
      ),
      body: const Row(
        children: [
          Flexible(
            flex: 6,
            child: CategoryView(),
          ),
          Flexible(
            flex: 2,
            child: SavedItemsView(),
          )
        ],
      ),
    );
  }
}
