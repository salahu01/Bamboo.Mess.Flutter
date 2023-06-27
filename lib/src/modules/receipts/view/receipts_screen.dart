import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ReceiptsView extends StatefulWidget {
  const ReceiptsView({super.key});

  @override
  State<ReceiptsView> createState() => _ReceiptsViewState();
}

class _ReceiptsViewState extends State<ReceiptsView> {
  int _selectedReceipt = 0;
  int _selectedRow = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#deb4ff').withOpacity(0.2),
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
                            hintText: 'Search here ...',
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
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('Sunday, May 28, 2023', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.pinkAccent)),
                            ),
                            Column(
                              children: List.generate(
                                4,
                                (i) {
                                  final selected = _selectedReceipt == i && rowIndex == _selectedRow;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                    child: ListTile(
                                      selected: selected,
                                      selectedTileColor: HexColor('#deb4ff'),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      leading: const Icon(Icons.payments, size: 34, color: Colors.black),
                                      title: const Text(
                                        '3,055.00',
                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        '05:00 PM',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.more_vert, size: 32, color: Colors.black),
                                      ),
                                      onTap: () => setState(() {
                                        _selectedReceipt = i;
                                        _selectedRow = rowIndex;
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // child: Column(
            //   children: [
            //     TextField(
            //       decoration: InputDecoration(
            //         filled: true,
            //         fillColor: Colors.white,
            //         hintText: 'Search',
            //         isDense: true,
            //         hintStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.6)),
            //         prefixIcon: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 12),
            //           child: Icon(Icons.search, color: Colors.black.withOpacity(0.6), size: 48),
            //         ),
            //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            //         border: const OutlineInputBorder(borderSide: BorderSide.none),
            //       ),
            //       style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.7)),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: const Divider(indent: 80, color: Colors.black26, height: 0.1),
            //     ),
            //     Expanded(
            //       child: ListView.separated(
            //         shrinkWrap: true,
            //         itemCount: 100,
            //         separatorBuilder: (context, index) => const Divider(indent: 80, color: Colors.black26, height: 0.1),
            //         itemBuilder: (context, i) {
            //           return ColoredBox(
            //             color: i == 0 ? HexColor('#deb4ff').withOpacity(0.8) : Colors.transparent,
            //             child: const Row(
            //               children: [
            //                 Icon(
            //                   Icons.payments_outlined,
            //                   size: 42,
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       '3,055.00',
            //                       style: TextStyle(
            //                         fontSize: 30,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                     Text(
            //                       '05:23 PM',
            //                       style: TextStyle(
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                   ],
            //                 )
            //               ],
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: SizedBox(
                width: 600,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                  child: SizedBox(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Text(
                            'Billing',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4, left: 24),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Billed : Employee 1',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
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
                        const Text(
                          'Total : 100.00',
                          style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700, letterSpacing: 0.6),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                        ),
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
}
