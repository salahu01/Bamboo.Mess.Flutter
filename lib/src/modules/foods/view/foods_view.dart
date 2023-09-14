import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/foods/provider/foods_provider.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';

class FoodsView extends ConsumerWidget {
  const FoodsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary.value.withOpacity(0.2),
      body: ref.watch(categoryProvider).when(
            data: (data) {
              return Consumer(builder: (context, ref, child) {
                final selCategory = ref.watch(selCategoryProvider);
                return Row(
                  children: [
                    Flexible(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        margin: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                              margin: const EdgeInsets.only(top: 24, bottom: 24),
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
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.only(bottom: 12),
                                children: List.generate(
                                  data.length - 1,
                                  (i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                      child: ListTile(
                                        selected: selCategory?.id == data[i].id,
                                        selectedTileColor: primary.value,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        leading: const Icon(Icons.fastfood_outlined, size: 34, color: Colors.black),
                                        title: Text(
                                          data[i].categaryName ?? '',
                                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.more_vert, size: 32, color: Colors.black),
                                        ),
                                        onTap: () => ref.read(selCategoryProvider.notifier).update((_) => data[i]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
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
                                    child: Visibility(
                                      visible: selCategory?.products?.isNotEmpty ?? false,
                                      replacement: const Center(child: Text('No Foods !', style: TextStyle(fontSize: 32))),
                                      child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 6),
                                        itemCount: selCategory?.products?.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          final product = selCategory?.products?[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                            child: ListTile(
                                              tileColor: primary.value,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              leading: const Icon(Icons.payments_outlined, size: 34, color: Colors.black),
                                              title: Text(
                                                product?.name ?? '',
                                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                                              ),
                                              trailing: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.more_vert, size: 32, color: Colors.black),
                                              ),
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
                        ),
                      ),
                    ),
                  ],
                );
              });
            },
            error: (error, stackTrace) => Text('$error'),
            loading: () => Center(child: CircularProgressIndicator(color: primary.value)),
          ),
    );
  }
}
