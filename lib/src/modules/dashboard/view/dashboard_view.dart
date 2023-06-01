import 'dart:developer';
import 'package:flutter/material.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, right: 8, top: 4),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    ),
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
                  title: InkWell(
                    onTap: () {
                      log("SAVED ITEMS SHOWING");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Saved items  [${1}]",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.79,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          title: Text('Item $index'),
                          onTap: () {},
                        );
                      },
                    ),
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
                        () {
                          log("message");
                        },
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

  selectecdIndexUpdate(int index) {
    setState(() {
      selectedIndex = index;
      currentIndex = index;
    });
  }
}
