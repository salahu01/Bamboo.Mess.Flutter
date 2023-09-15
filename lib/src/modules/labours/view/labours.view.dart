import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';
import 'package:freelance/src/modules/labours/provider/labour.provider.dart';

class LaboursView extends ConsumerStatefulWidget {
  const LaboursView({super.key});

  @override
  ConsumerState<LaboursView> createState() => _LaboursViewState();
}

class _LaboursViewState extends ConsumerState<LaboursView> {
  int? _selectedLabour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary.value.withOpacity(0.2),
      body: ref.watch(laboursProvider).when(
            data: (data) {
              return Row(
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
                                data.length,
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
                                        data[i].name ?? '',
                                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        data[i].id ?? '',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          _selectedLabour = null;
                                          Dialogs.loadingDailog(context);
                                          MongoDataBase().deleteOneEmployee(data[i]).then((value) {
                                            Navigator.pop(context);
                                            // ignore: unused_result
                                            value ? ref.refresh(laboursProvider) : null;
                                          });
                                        },
                                        icon: const Icon(Icons.delete, size: 32, color: Colors.black),
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
                          child: _selectedLabour == null
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Select Employee !', style: TextStyle(fontSize: 20)),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 24),
                                      child: Icon(Icons.person, size: 200, color: Colors.black),
                                    ),
                                    Text(
                                      '${data[_selectedLabour!].name}',
                                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.black),
                                    ),
                                    Text(
                                      '${data[_selectedLabour!].phone}',
                                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.black),
                                    ),
                                    Text(
                                      '${data[_selectedLabour!].age}',
                                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.black),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => Text('$error'),
            loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
          ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Dialogs.addEmployeeDialog(context);
        },
        child: Card(
          margin: const EdgeInsets.all(32),
          elevation: 10,
          color: primary.value,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(Icons.person_add_alt_1, size: 40, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
