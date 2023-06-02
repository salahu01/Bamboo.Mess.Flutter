import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:freelance/src/modules/custom/slide_and_remove.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int selectedIndex = 0;
  int currentIndex = 0;

  List<String> items = [
    "PAGE 1",
    "PAGE 2",
    "PAGE 3",
    "PAGE 4",
    "PAGE 5",
    "TOTAL PAGE",
  ];
  static const _startCounter = 30;
  final lockedIndices = <int>[];

  List<int> children = List.generate(_startCounter, (index) => index);

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 6,
            child: Column(
              children: [
                AppBar(
                  toolbarHeight: 100,
                  backgroundColor: Theme.of(context).primaryColor,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 8, top: 4),
                    child: _getReorderableWidget(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: buildBottom(context),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 100,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.dashboard_sharp,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                  title: InkWell(
                    onTap: () {
                      log("SAVED ITEMS SHOWING");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Saved items  [${1}]",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.79,
                  child: ListView.builder(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SlideBillMenu(
                        menuItems: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        ],
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            trailing: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "1200",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            title: Text(
                              'Item $index',
                              style: const TextStyle(fontSize: 20),
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customBotton(
                        "SAVE",
                        () {
                          log("efwfqe");
                        },
                      ),
                      customBotton(
                        "CHARGE",
                        () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customBotton(String name, VoidCallback onTapFuncation) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTapFuncation,
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Material buildBottom(BuildContext context) {
    return Material(
      child: SizedBox(
        child: ListView.builder(
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
                  height: 20,
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
                            colors: [
                              Theme.of(context).primaryColor,
                              Colors.black
                            ],
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
                        color: index == selectedIndex
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
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

  Widget _getReorderableWidget() {
    final generatedChildren = List<Widget>.generate(
      children.length,
      (index) => Container(
        key: Key(children[index].toString()),
        decoration: BoxDecoration(
          color: lockedIndices.contains(index) ? Colors.black : Colors.white,
        ),
        child: Card(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              'test ${children[index]}',
              style: const TextStyle(),
            ),
          ),
        ),
      ),
    );
    return ReorderableBuilder(
      key: Key(_gridViewKey.toString()),
      onReorder: _handleReorder,
      lockedIndices: lockedIndices,
      scrollController: _scrollController,
      builder: (children) {
        return GridView.extent(
          key: _gridViewKey,
          controller: _scrollController,
          maxCrossAxisExtent: 280,
          padding: EdgeInsets.zero,
          children: children,
        );
      },
      children: generatedChildren,
    );
  }

  selectecdIndexUpdate(int index) {
    setState(() {
      selectedIndex = index;
      currentIndex = index;
    });
  }
}
