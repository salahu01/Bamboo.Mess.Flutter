import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/dashboard/provider/dashboard_provider.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';
import 'package:freelance/src/modules/sales/view/category_view.dart';
import 'package:freelance/src/modules/sales/view/billing_view.dart';

class SalesView extends ConsumerWidget {
  const SalesView({super.key, required this.showBills, required this.searchCtrl});
  final bool showBills;
  final TextEditingController searchCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: showBills,
      replacement: ref.watch(categoryProvider).when(
            data: (data) => Row(
              children: [
                Flexible(
                  flex: 5,
                  child: CategoryView(categories: data, searchCtrl: searchCtrl),
                ),
                const Flexible(
                  flex: 2,
                  child: BillingView(),
                ),
              ],
            ),
            error: (error, stackTrace) => Center(child: Text('$error')),
            loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
          ),
      child: ref.watch(storedBillsProvider).when(
            data: (data) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (ref.read(selectedBillProvider) != index) {
                        ref.read(selectedBillProvider.notifier).update((_) => _ = index);
                        ref.read(billProductProvider.notifier)
                          ..clearProducts()
                          ..selectBill(data[index].cast());
                      } else {
                        ref.read(selectedBillProvider.notifier).update((_) => _ = null);
                        ref.read(billProductProvider.notifier).clearProducts();
                      }
                      ref.read(showBillsProvider.notifier).update((_) => false);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                      width: 500,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: index == ref.watch(selectedBillProvider) ? primary.value : Colors.transparent, width: 4),
                        ),
                        margin: const EdgeInsets.only(bottom: 24, left: 12, right: 24, top: 24),
                        elevation: 4,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: Text('Billing', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 128, vertical: 8),
                              child: Divider(color: Colors.black),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                physics: const BouncingScrollPhysics(),
                                itemCount: data[index].length,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    dense: true,
                                    title: Text(
                                      data[index][i].name ?? '',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                                    ),
                                    subtitle: Text(
                                      'Qty   ×   ${data[index][i].count ?? 0}',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                                    ),
                                    trailing: Text(
                                      '₹ ${(data[index][i].count ?? 0) * (data[index][i].price ?? 0)}',
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Text(
                                'Total Amount : ${data[index].fold<num>(0, (v, e) => v + (e.count ?? 0) * (e.price ?? 0))}',
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => Center(child: Text('$error')),
            loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
          ),
    );
  }
}
