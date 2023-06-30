import 'package:flutter/material.dart';
import 'package:freelance/src/core/theme/app_colors.dart';

class LaboursView extends StatefulWidget {
  const LaboursView({super.key});

  @override
  State<LaboursView> createState() => _LaboursViewState();
}

class _LaboursViewState extends State<LaboursView> {
  int _selectedLabour = 0;
  @override
  Widget build(BuildContext context) {
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
                      children: List.generate(
                        40,
                        (i) {
                          final selected = _selectedLabour == i;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            child: ListTile(
                              selected: selected,
                              selectedTileColor: primary.value,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              leading: const Icon(Icons.person, size: 34, color: Colors.black),
                              title: Text(
                                'Employee $i',
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                              subtitle: Text(
                                '+91 0000000$i',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert, size: 32, color: Colors.black),
                              ),
                              onTap: () => setState(() {
                                _selectedLabour = i;
                              }),
                            ),
                          );
                        },
                      ),
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
                  child: const SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Icon(Icons.person, size: 200, color: Colors.black),
                        ),
                        Text(
                          'Employee',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                        Text(
                          '+91 0000000',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        Text(
                          'Male',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.black),
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
