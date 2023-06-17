import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:freelance/src/modules/custom/show_dialog.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int selectedIndex = 0;
  int currentIndex = 0;

  List<String> items = ['All'];
  static const _startCounter = 30;
  final lockedIndices = <int>[];

  List<int> children = List.generate(_startCounter, (index) => index);

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();
  final colors = [Colors.green, Colors.red, Colors.blue, Colors.yellow, Colors.deepOrange];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.lightGreen,
        title: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, size: 35, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              onPressed: () {
                Dialogs.singleFieldDailog(
                  context,
                  title: 'Search',
                  leftButtonText: 'search',
                  validatorText: 'Enter Search name !',
                );
              },
              icon: const Icon(Icons.search, color: Colors.white, size: 35),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 8),
                _getReorderableWidget(),
              ],
            ),
          ),
          buildBottom(context),
        ],
      ),
    );
  }

  Widget _getReorderableWidget() {
    final generatedChildren = List<Widget>.generate(
      children.length,
      (index) {
        colors.shuffle();
        return Container(
          key: Key(children[index].toString()),
          decoration: BoxDecoration(
            color: lockedIndices.contains(index) ? Colors.black : Colors.white,
          ),
          child: Card(
            elevation: 0,
            color: colors.first,
            child: const Center(
              child: Text(
                'Thalesseri Biriyani',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
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
        return GridView.extent(
          key: _gridViewKey,
          childAspectRatio: 3 / 2,
          shrinkWrap: true,
          controller: _scrollController,
          maxCrossAxisExtent: 280,
          padding: EdgeInsets.zero,
          children: children,
        );
      },
      children: generatedChildren,
    );
  }

  Widget buildBottom(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    selectecdIndexUpdate(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      border: index == selectedIndex
                          ? Border(
                              top: BorderSide(
                                width: MediaQuery.of(context).size.width * 0.01,
                                color: Colors.white,
                              ),
                            )
                          : null,
                      gradient: index == selectedIndex
                          ? LinearGradient(
                              colors: [Theme.of(context).primaryColor, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                    ),
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
              );
            },
          ),
        ],
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
      currentIndex = index;
    });
  }
}
