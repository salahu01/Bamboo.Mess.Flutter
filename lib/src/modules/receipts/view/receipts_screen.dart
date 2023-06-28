import 'package:flutter/material.dart';
import 'package:freelance/src/core/theme/app_colors.dart';

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
      backgroundColor: primary.withOpacity(0.2),
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
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text('Sunday, May 28, 2023', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary)),
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
                                      selectedTileColor: primary,
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
                            '3,055.00',
                            style: TextStyle(fontSize: 58, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[900]),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 24, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Employee : Employee 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 20),
                                  child: Text('POS: POS 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                ),
                                Text('Dine in', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          child: Divider(color: Colors.black),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            physics: const BouncingScrollPhysics(),
                            itemCount: 32,
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
