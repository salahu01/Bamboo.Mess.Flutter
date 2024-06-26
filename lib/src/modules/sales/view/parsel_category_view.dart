import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/category.model.dart';
import 'package:freelance/src/core/models/product.model.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';
import 'package:freelance/src/modules/dashboard/view/dashboard_view.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';

class ParselCategoryView extends ConsumerStatefulWidget {
  const ParselCategoryView({super.key, required this.categories, required this.searchCtrl});
  final List<CategoryModel> categories;
  final TextEditingController searchCtrl;

  @override
  ConsumerState<ParselCategoryView> createState() => _ParselCategoryViewState();
}

class _ParselCategoryViewState extends ConsumerState<ParselCategoryView> {
  int selectedIndex = 0;
  final lockedIndices = <int>[];
  int? selectedSubIndex;

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: selectedSubIndex != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton(
                    onPressed: () => setState(() => selectedSubIndex = null),
                    icon: Icon(Icons.arrow_back, color: primary.value, size: 32),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(left: 24, right: 12, bottom: 24),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _getReorderableWidget(),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    // margin: const EdgeInsets.only(left: 24, right: 12, top: 24, bottom: 24),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: widget.categories.isEmpty ? empty : _getReorderableWidget(),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(left: 15, bottom: 15),
                  elevation: 4,
                  child: buildBottom(context, width),
                ),
              ],
            ),
    );
  }

  Widget get empty => const Center(child: Text('No Foods !', style: TextStyle(fontSize: 24)));
  Widget get searchEmpty => const Center(child: Text('Coudn\'t find Foods !', style: TextStyle(fontSize: 24)));

  Widget _getReorderableWidget() {
    return ValueListenableBuilder(
      valueListenable: widget.searchCtrl,
      builder: (BuildContext context, query, Widget? child) {
        //* Manage Add feature visible or not
        final canAdd = selectedIndex == (widget.categories.length - 1) || query.text.isNotEmpty ? 0 : 1;

        //*
        List<ProductModel?>? products;

        //* Search Functionality
        if (query.text.isNotEmpty) {
          products = widget.categories.last.products?.where((e) => '${e?.name}'.toLowerCase().contains(query.text.toLowerCase())).toList() ?? [];
        }
        //* Sorting Products if selected subcategory
        else if (selectedSubIndex != null) {
          products = widget.categories[selectedIndex].products?[selectedSubIndex!]?.products;
        } else {
          products = widget.categories[selectedIndex].products;
        }

        //* Managing if not found searched product
        if (query.text.isNotEmpty && (products?.isEmpty ?? true)) {
          return searchEmpty;
        }

        final generatedChildren = List<Widget>.generate(
          (products?.length ?? 0) + canAdd,
          (i) {
            return GestureDetector(
              key: Key('$i'),
              onTap: () {
                final isSubProduct = selectedSubIndex != null;
                if (i == (products?.length ?? 1)) {
                  final ids = isSubProduct ? widget.categories[selectedIndex].products![selectedSubIndex!]?.productIds : widget.categories[selectedIndex].productIds;
                  final name = isSubProduct ? null : widget.categories[selectedIndex].categaryName;
                  Dialogs.singleFieldDailog(
                    context,
                    ids: ids,
                    categoryName: name,
                    subProduct: isSubProduct ? widget.categories[selectedIndex].products![selectedSubIndex!]?.id : null,
                    onSuccess: () => ref.refresh(categoryProvider),
                  );
                } else if (products?[i]?.productIds == null) {
                  ref.read(billProductProvider.notifier).addProductToBill(products?[i]);
                } else if (widget.categories[selectedIndex].products?[i]?.productIds != null) {
                  setState(() => selectedSubIndex = i);
                }
              },
              child: Card(
                elevation: 8,
                color: primary.value,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: i == ((products ?? widget.categories[selectedIndex].products)?.length ?? 1)
                      ? Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 70, 70, 70)),
                          child: const Icon(Icons.add, size: 60, color: Colors.white),
                        )
                      : Stack(
                          children: [
                            Visibility(
                              visible: (products ?? widget.categories[selectedIndex].products)?[i]?.productIds != null,
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.category, color: Colors.white),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7, right: 5),
                                child: Text(
                                  (products ?? widget.categories[selectedIndex].products)?[i]?.name ?? '',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
        );
        if (selectedSubIndex == null) {
          return ReorderableBuilder(
            key: Key(_gridViewKey.toString()),
            onReorder: _handleReorder,
            lockedIndices: lockedIndices,
            scrollController: _scrollController,
            builder: (children) {
              return GridView.count(
                key: _gridViewKey,
                childAspectRatio: 4 / 2.8,
                shrinkWrap: true,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                controller: _scrollController,
                crossAxisCount: 6,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: children,
              );
            },
            children: generatedChildren,
          );
        }
        return GridView.count(
          key: _gridViewKey,
          childAspectRatio: 4 / 2.8,
          shrinkWrap: true,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          controller: _scrollController,
          crossAxisCount: 6,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: generatedChildren,
        );
      },
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return ScaleTransition(
                              alignment: Alignment.center,
                              scale: Tween<double>(begin: 0.1, end: 1).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOutCirc,
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(seconds: 1),
                          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                            return const DashBoardView();
                          },
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 80,
                      child: Icon(CupertinoIcons.backward_fill, color: primary.value, size: 60),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconButton(
                    onPressed: () {
                      Dialogs.singleFieldDailog(context, onSuccess: () => ref.refresh(categoryProvider));
                    },
                    icon: Icon(Icons.add, color: primary.value, size: 40),
                  ),
                ),
              ],
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
                    // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
}
