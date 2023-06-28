import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/custom/show_dialog.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.startAnimation});
  final bool startAnimation;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int selectedIndex = 0;

  List<String> items = ['All', 'Rice', 'Kury'];
  final lockedIndices = <int>[];

  List<int> children = List.generate(60, (index) => index);

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(left: 24, right: 12, top: 24, bottom: 24),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _getReorderableWidget(),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(left: 24, right: 12, bottom: 24),
            elevation: 4,
            child: buildBottom(context, width),
          ),
        ],
      ),
    );
  }

  Widget _getReorderableWidget() {
    final generatedChildren = List<Widget>.generate(
      children.length,
      (i) {
        return Card(
          key: Key(children[i].toString()),
          elevation: 8,
          color: primary.value,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Center(
            child: Text(
              'Thalesseri Biriyani',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
        );
      },
    );
    return ReorderableBuilder(
      key: Key(_gridViewKey.toString()),
      onReorder: _handleReorder,
      lockedIndices: lockedIndices,
      scrollController: _scrollController,
      builder: (children) {
        return GridView.count(
          key: _gridViewKey,
          childAspectRatio: 3 / 2,
          shrinkWrap: true,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          controller: _scrollController,
          crossAxisCount: 5,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: children,
        );
      },
      children: generatedChildren,
    );
  }

  Widget buildBottom(BuildContext context, double width) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Dialogs.singleFieldDailog(context, title: 'Add Category', validatorText: 'Enter category here', leftButtonText: 'Save'),
              child: Card(
                elevation: 8,
                color: primary.value,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(Icons.add, size: 46, color: Colors.white),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (ctx, index) {
                return AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 300 + (index * 200)),
                  transform: Matrix4.translationValues(widget.startAnimation ? 0 : width * 0.4, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      selectecdIndexUpdate(index);
                    },
                    child: Card(
                      elevation: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      color: index == selectedIndex ? primary.value : Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              fontSize: 20,
                              color: index == selectedIndex ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleReorder(List<OrderUpdateEntity> onReorderList) {
    for (final reorder in onReorderList) {
      final child = children.removeAt(reorder.oldIndex);
      children.insert(reorder.newIndex, child);
    }
    setState(() {});
  }

  selectecdIndexUpdate(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void startAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }
}
