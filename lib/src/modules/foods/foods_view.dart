import 'package:flutter/material.dart';
import 'package:freelance/src/core/theme/app_colors.dart';

class FoodsView extends StatefulWidget {
  const FoodsView({super.key, required this.startAnimation});
  final bool startAnimation;

  @override
  State<FoodsView> createState() => _FoodsViewState();
}

class _FoodsViewState extends State<FoodsView> {
  // int selectedIndex = 0;

  // List<String> items = ['All', 'Rice', 'Kury'];
  // final lockedIndices = <int>[];

  // List<int> children = List.generate(60, (index) => index);

  // final _scrollController = ScrollController();
  // final _gridViewKey = GlobalKey();

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary.value.withOpacity(0.2),
      body: Row(
        children: [
          Flexible(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: SizedBox(
                      width: 600,
                      height: 68,
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search Categry...',
                            hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.search, color: Colors.black, size: 36),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(vertical: 18),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: List.generate(10, (rowIndex) {
                        return ListView(
                          primary: false,
                          shrinkWrap: true,
                          children: [],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: SizedBox(
                width: width * 0.6,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                          child: SizedBox(
                            width: width * 0.5,
                            height: 68,
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Search Food...',
                                  hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Icon(Icons.search, color: Colors.black, size: 36),
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                  isDense: true,
                                ),
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView(
                            children: List.generate(10, (rowIndex) {
                              return ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: [],
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }
}
