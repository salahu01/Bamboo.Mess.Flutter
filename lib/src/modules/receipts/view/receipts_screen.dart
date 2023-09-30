// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/extensions/date_time.extension.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/core/services/printer/printer.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';
import 'package:freelance/src/core/widgets/snak_bar.dart';
import 'package:freelance/src/modules/receipts/provider/receipts.provider.dart';

class ReceiptsView extends ConsumerStatefulWidget {
  TextEditingController? passwordController = TextEditingController();
  ReceiptsView({super.key});

  @override
  ConsumerState<ReceiptsView> createState() => _ReceiptsViewState();
}

class _ReceiptsViewState extends ConsumerState<ReceiptsView> {
  int _selectedReceipt = 0;
  int _selectedRow = 0;
  final List<String> _locations = ['Lock Screen', 'Lock App', 'Unlock Screen', 'Unlock App', 'Lock', 'Unlock'];
  String? _selectedLocation;
  bool isactivedelect = false;

  @override
  void dispose() {
    isactivedelect = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("TRUE OR FALSE 2 => $isactivedelect");
    return Scaffold(
      backgroundColor: primary.value.withOpacity(0.2),
      body: ref.watch(recieptsProvider).when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(child: Text('No Reciepts', style: TextStyle(fontSize: 30)));
              }
              return Row(
                children: [
                  Flexible(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                                margin: const EdgeInsets.only(top: 24, left: 10),
                                child: SizedBox(
                                  width: 440,
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
                              Padding(
                                padding: const EdgeInsets.only(top: 20, left: 8),
                                child: PopupMenuButton<String>(
                                  icon: const Icon(Icons.align_vertical_bottom, size: 35),
                                  onSelected: (value) {
                                    print('Selected: $value');
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'Price: Low to High',
                                        mouseCursor: MouseCursor.defer,
                                        child: Text('Price: Low to High'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'Price: High to Low',
                                        child: Text('Price: High to Low'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'Date: End to start',
                                        child: Text('Date: End to start'),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView(
                              children: List.generate(data.length, (rowIndex) {
                                return ListView(
                                  primary: false,
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(data[rowIndex].first.date?.order ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: primary.value)),
                                    ),
                                    Column(
                                      children: List.generate(
                                        data[rowIndex].length,
                                        (i) {
                                          final selected = _selectedReceipt == i && rowIndex == _selectedRow;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                            child: ListTile(
                                              selected: selected,
                                              selectedTileColor: primary.value,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              leading: const Icon(Icons.payments, size: 34, color: Colors.black),
                                              title: Text(
                                                '${data[rowIndex][i].totalAmount ?? ''}',
                                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                                              ),
                                              subtitle: Text(
                                                data[rowIndex][i].time ?? '',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),
                                              ),
                                              trailing: isactivedelect == true
                                                  ? IconButton(
                                                      onPressed: () {
                                                        Dialogs.loadingDailog(context);
                                                        MongoDataBase().deleteOneReciept(data[rowIndex][i]).then((value) {
                                                          Navigator.pop(context);
                                                          // ignore: unused_result
                                                          value ? ref.refresh(recieptsProvider) : null;
                                                        });
                                                      },
                                                      icon: const Icon(Icons.delete, size: 32, color: Colors.black),
                                                    )
                                                  : const Icon(Icons.local_print_shop_outlined),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.12),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 4,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Text(
                                  '₹ ${data[_selectedRow][_selectedReceipt].totalAmount ?? ''}.00',
                                  style: const TextStyle(fontSize: 58, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                'Total',
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.grey[900]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 24, top: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Employee : ${data[_selectedRow][_selectedReceipt].employee ?? ''}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 12),
                                      Text(data[_selectedRow][_selectedReceipt].orderType ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
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
                                  itemCount: data[_selectedRow][_selectedReceipt].products?.length ?? 0,
                                  itemBuilder: (context, i) {
                                    return ListTile(
                                      dense: true,
                                      title: Text(
                                        data[_selectedRow][_selectedReceipt].products?[i].name ?? '',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                                      ),
                                      subtitle: Text(
                                        'Qty : ${data[_selectedRow][_selectedReceipt].products?[i].count}',
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                                      ),
                                      trailing: Text(
                                        '₹ ${(data[_selectedRow][_selectedReceipt].products?[i].count ?? 0) * (data[_selectedRow][_selectedReceipt].products?[i].price ?? 0)}',
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
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      child: Container(
                        // width: 50,
                        height: 50,
                        color: Colors.transparent,
                        child: DropdownButton(
                          underline: const SizedBox.shrink(),
                          icon: const Icon(Icons.lock_clock_outlined),
                          dropdownColor: primary.value.withOpacity(0.2),
                          value: _selectedLocation,
                          onChanged: (_) {
                            setState(() {
                              widget.passwordController?.clear();
                              _selectedLocation = _;
                              _selectedLocation == 'Lock' ? alertBoxToPassword(context) : const SizedBox();
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              value: location,
                              child: Text(location),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FloatingActionButton.large(
                        backgroundColor: primary.value,
                        onPressed: () {
                          Printer.instance.print(data[_selectedRow][_selectedReceipt]);
                        },
                        child: const Icon(Icons.print),
                      ),
                    ),
                  )
                ],
              );
            },
            error: (error, stackTrace) => Text('$error'),
            loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
          ),
    );
  }

  alertBoxToPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final key = GlobalKey<FormState>();
        return AlertDialog(
          title: const Row(
            children: [
              Spacer(),
              Text('Enter Your Code When Lock The App'),
              Spacer(),
            ],
          ),
          titleTextStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: SizedBox(
            width: 600,
            child: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
                      controller: widget.passwordController,
                      validator: (value) => value == null || value.isEmpty ? 'Please enter the value !' : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.red)),
                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: primary.value)),
                        hintText: "Enter The Password",
                        hintStyle: const TextStyle(fontSize: 20),
                      ),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: primary.value, fontSize: 18)),
            ),
            TextButton(
              onPressed: () {
                widget.passwordController?.text == "12345" ? showSnackBar(context, "Password is Current") : showSnackBar(context, "Password is wrong !");
                widget.passwordController?.text == "12345" ? isactivedelect = true : isactivedelect = false;
                log("TRUE OR FALSE 1 => $isactivedelect");
                Navigator.pop(context);
              },
              child: Text('OK', style: TextStyle(color: primary.value, fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  clear() {
    widget.passwordController = null;
  }
}
