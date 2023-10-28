// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';
import 'package:freelance/src/modules/charge_screen/view/charge_screen.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';

class SavedItemsView extends ConsumerWidget {
  SavedItemsView({super.key});

  bool isEditText = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 24, left: 12, right: 24, top: 24),
        elevation: 4,
        child: Consumer(
          builder: (context, ref, child) {
            final products = ref.watch(billProductProvider);
            return Column(
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
                      final editcontroller = TextEditingController(text: '${(products[i].count ?? 0) * (products[i].price ?? 0)}');
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              autoClose: true,
                              onPressed: (context) {
                                isEditText = true;
                              },
                              backgroundColor: primary.value,
                              foregroundColor: Colors.white,
                              icon: Icons.edit_document,
                              label: 'Edit',
                            ),
                          ],
                        ),
                        child: ListTile(
                          dense: true,
                          onTap: () => ref.read(billProductProvider.notifier).removeProductFromBill(i),
                          title: Text(
                            products[i].name ?? '',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                          ),
                          subtitle: Text(
                            'Qty : ${products[i].count ?? 0}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                          ),
                          trailing: Container(
                            width: 100,
                            child: isEditText == false
                                ? Text(
                                    '₹ ${(products[i].count ?? 0) * (products[i].price ?? 0)}',
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                                  )
                                : TextFormField(
                                    controller: editcontroller,
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                                    maxLength: 5,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Divider(color: Colors.black),
                ),
                Text(
                  'Total Amount : ${products.fold<num>(0, (v, e) => v + (e.count ?? 0) * (e.price ?? 0))}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final billsProvider = ref.watch(storeBillsProvider);
                          return customBotton(
                            billsProvider.toUpperCase(),
                            () {
                              if (products.isEmpty) {
                                Dialogs.showSnack(context, 'Please select products !');
                              } else {
                                ref.read(storeBillsProvider.notifier).storeBill(products, ref);
                              }
                            },
                            context,
                          );
                        },
                      ),
                      customBotton(
                        "CHARGE",
                        () {
                          if (products.isEmpty) {
                            Dialogs.showSnack(context, 'Please select products !');
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ChargeScreen()));
                          }
                        },
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget customBotton(
    String name,
    VoidCallback onPressed,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01)),
        backgroundColor: primary.value,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.08,
        height: 72,
        child: Center(
          child: Text(name, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
