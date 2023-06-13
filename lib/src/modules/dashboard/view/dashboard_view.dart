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

  List<String> items = ['All'];
  static const _startCounter = 30;
  final lockedIndices = <int>[];

  List<int> children = List.generate(_startCounter, (index) => index);

  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();
  final colors = [Colors.green, Colors.red, Colors.blue, Colors.yellow, Colors.deepOrange];

  late final TextEditingController _addCatrgoryCtrl;
  late final GlobalKey<FormFieldState> _addCategoryKey;
  bool showSearch = false;

  @override
  void initState() {
    _addCatrgoryCtrl = TextEditingController();
    _addCategoryKey = GlobalKey<FormFieldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 6,
              child: ColoredBox(
                color: Theme.of(context).primaryColor,
                child: SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu, size: 35, color: Colors.white),
                      ),
                      Spacer(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: showSearch ? 0 : MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1000),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1000),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1000),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            hintText: 'Search here',
                            hintStyle: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                          cursorColor: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showSearch = showSearch ? false : true;
                          });
                        },
                        icon: Icon(showSearch ? Icons.search : Icons.close, color: Colors.white, size: 35),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Saved items  [${1}]",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.dashboard_sharp,
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 6,
            child: Column(
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
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SlideBillMenu(
                        menuItems: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        ],
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          trailing: Text(
                            "$index x \$1200",
                            style: const TextStyle(fontSize: 20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          title: Text(
                            'Item $index',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), child: Divider()),
                const Text('Total Amount : \$5000', style: TextStyle(fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      customBotton("SAVE", () {}),
                      customBotton("CHARGE", () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customBotton(String name, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01)))),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.08,
        height: 72,
        child: Center(
          child: Text(name, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Center(child: Text('Add Category')),
                    titleTextStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    content: SizedBox(
                      width: 600,
                      child: TextFormField(
                        key: _addCategoryKey,
                        controller: _addCatrgoryCtrl,
                        validator: (value) => value == null || value.isEmpty ? 'Enter Category name !' : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          hintText: 'Enter category name',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () {
                          if (_addCategoryKey.currentState?.validate() ?? false) {
                            setState(() {
                              items.add(_addCatrgoryCtrl.text);
                              _addCatrgoryCtrl.clear();
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
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

  selectecdIndexUpdate(int index) {
    setState(() {
      selectedIndex = index;
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _addCatrgoryCtrl.dispose();
    super.dispose();
  }
}
