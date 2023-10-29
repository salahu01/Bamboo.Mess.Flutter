import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/printer/printer.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';
import 'package:freelance/src/modules/charge_screen/provider/charge.screen.provider.dart';
import 'package:freelance/src/modules/labours/provider/labour.provider.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';

class ChargeScreen extends ConsumerStatefulWidget {
  const ChargeScreen({super.key});

  @override
  ConsumerState<ChargeScreen> createState() => _ChargeScreenState();
}

String? selectedEmployee;

String? selectedOrderType = 'Dine in';

var orderTypes = [
  'Dine in',
  'Parcel',
];

class _ChargeScreenState extends ConsumerState<ChargeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      await selectEmployee();
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(billProductProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: primary.value,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
        leadingWidth: 120,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 24, left: 12, right: 24, top: 24),
              elevation: 4,
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
                    padding: EdgeInsets.symmetric(horizontal: 128, vertical: 8),
                    child: Divider(color: Colors.black),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      physics: const BouncingScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            products[i].name ?? '',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                          ),
                          subtitle: Text(
                            'Qty : ${products[i].count ?? 0}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                          ),
                          trailing: Text(
                            '₹ ${(products[i].count ?? 0) * (products[i].price ?? 0)}',
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
          Expanded(
              flex: 4,
              child: ref.watch(laboursProvider).when(
                    data: (data) {
                      return Container(
                        color: const Color.fromARGB(255, 228, 222, 222),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹ ${products.fold<num>(0, (v, e) => v + (e.count ?? 0) * (e.price ?? 0))}",
                                    style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    "Total Amount",
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.17,
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        child: InkWell(
                                          onTap: () {
                                            selectEmployee();
                                          },
                                          child: Row(
                                            children: [
                                              Text(selectedEmployee == null ? "Select Emplyee" : '$selectedEmployee', style: const TextStyle(fontSize: 25)),
                                              selectedEmployee == null ? const Icon(Icons.keyboard_double_arrow_down_outlined) : const SizedBox.shrink()
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.17,
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        child: Center(
                                          child: DropdownButton(
                                            underline: const SizedBox.shrink(),
                                            value: selectedOrderType,
                                            icon: const Padding(
                                              padding: EdgeInsets.only(left: 15),
                                              child: Icon(Icons.keyboard_arrow_down, size: 35),
                                            ),
                                            items: orderTypes.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style: const TextStyle(fontSize: 25),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedOrderType = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 45),
                                  InkWell(
                                    onTap: () {
                                      if (selectedEmployee == null) {
                                        Dialogs.showSnack(context, 'Please select employee !');
                                      } else {
                                        final reciept = RecieptModel(products: products, orderType: selectedOrderType, employee: selectedEmployee, date: DateTime.now());
                                        Printer.instance.print(reciept).then((_) {
                                          ref.read(uploadRecieptProvider.notifier).createReciept(reciept, ref, context);
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      decoration: BoxDecoration(color: primary.value, borderRadius: BorderRadius.circular(30)),
                                      child: Center(
                                        child: Consumer(
                                          builder: (context, ref, child) {
                                            final state = ref.watch(uploadRecieptProvider);
                                            return Text(state, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    error: (error, stackTrace) => Text('$error'),
                    loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
                  )),
        ],
      ),
    );
  }

  Future selectEmployee() {
    return showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          title: const Text("Select Employee", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 700,
              child: ref.watch(laboursProvider).when(
                    data: (data) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedEmployee = data[index].name;
                                log("selected emplyee is => $selectedEmployee");
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              color: primary.value,
                              child: Center(
                                child: Text(
                                  data[index].name.toString(),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => Text('$error'),
                    loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
                  ),
            ),
          ),
        );
      },
    );
  }
}
