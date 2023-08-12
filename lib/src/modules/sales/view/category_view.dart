import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';

class CategoryView extends ConsumerStatefulWidget {
  const CategoryView({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  ConsumerState<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends ConsumerState<CategoryView> {
  int selectedIndex = 0;
  final lockedIndices = <int>[];

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

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
      (widget.categories[selectedIndex].products?.length ?? 0) + 1,
      (i) {
        return Card(
          key: Key('$i'),
          elevation: 8,
          color: primary.value,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: i == (widget.categories[selectedIndex].products?.length ?? 1)
                ? GestureDetector(
                    onTap: () {
                      Dialogs.singleFieldDailog(context,ids:widget.categories[selectedIndex].productIds, categoryName: widget.categories[selectedIndex].categaryName);
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 70, 70, 70),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    widget.categories[selectedIndex].products?[i]?.name ?? '',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: primary.value, size: 40),
              ),
            ),
            ...List.generate(
              widget.categories.length,
              (index) {
                return GestureDetector(
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
                          widget.categories[index].categaryName ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            color: index == selectedIndex ? Colors.white : Colors.black,
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
      final child = widget.categories[selectedIndex].products?.removeAt(reorder.oldIndex);
      widget.categories[selectedIndex].products?.insert(reorder.newIndex, child);
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

  // _addFoodOrCatrgoryWidget() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01)),
  //         actions: [
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width * 0.5,
  //             height: MediaQuery.of(context).size.height * 0.4,
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [

  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
