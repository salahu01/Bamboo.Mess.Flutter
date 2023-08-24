import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';
import 'package:freelance/src/modules/sales/view/category_view.dart';
import 'package:freelance/src/modules/sales/view/saved_items_view.dart';

class SalesView extends ConsumerWidget {
  const SalesView({super.key, required this.showBills});
  final ValueNotifier<bool> showBills;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: showBills.value,
      replacement: ref.watch(categoryProvider).when(
            data: (data) => Row(
              children: [
                Flexible(
                  flex: 5,
                  child: CategoryView(categories: data),
                ),
                const Flexible(
                  flex: 2,
                  child: SavedItemsView(),
                ),
              ],
            ),
            error: (error, stackTrace) => Text('$error'),
            loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
          ),
      child: ref.watch(storedBillsProvider).when(
            data: (data) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    width: 500,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: index == 1 ? primary.value : Colors.transparent, width: 4)),
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
                                    'Qty : ${data[index][i].count ?? 0}',
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                                  ),
                                  trailing: Text(
                                    '₹ ${data[index].fold<num>(0, (v, e) => v + (e.count ?? 0) * (e.price ?? 0))}',
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
                          const Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: Text(
                              'Total Amount : 100',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => Text('$error'),
            loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
          ),
    );
  }
}
