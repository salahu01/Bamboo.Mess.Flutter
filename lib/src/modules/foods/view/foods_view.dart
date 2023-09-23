import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/core/widgets/show_dialog.dart';
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
                final selSubCategory = ref.watch(selSubCategoryProvider);
                return Stack(
                  children: [
                    Row(
                      children: [
                        //* Categories
                        Flexible(
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            margin: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 4,
                                  margin: const EdgeInsets.all(16),
                                  child: SizedBox(
                                    height: 68,
                                    child: Center(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Search Category ...',
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
                                  child: Visibility(
                                    visible: data.isNotEmpty,
                                    replacement: const Center(child: Text('No Categories !', style: TextStyle(fontSize: 24))),
                                    child: ListView(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      children: List.generate(
                                        data.isEmpty ? 0 : data.length - 1,
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
                                                onPressed: () {
                                                  Dialogs.loadingDailog(context);
                                                  MongoDataBase().deleteOneCategory(data[i]).then((value) {
                                                    Navigator.pop(context);
                                                    // ignore: unused_result
                                                    value ? ref.refresh(categoryProvider) : null;
                                                  });
                                                },
                                                icon: const Icon(Icons.delete, size: 32, color: Colors.black),
                                              ),
                                              onTap: () => ref.read(selCategoryProvider.notifier).update((_) => data[i]),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //* Products and SubCategories
                        Flexible(
                          child: Center(
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 4,
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
                                          onChanged: (value) {},
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'Search Sub Category ...',
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
                                      replacement: const Center(child: Text('No Sub Categories !', style: TextStyle(fontSize: 24))),
                                      child: Consumer(builder: (context, ref, child) {
                                        final ids = ref.watch(selSubProducts);
                                        return ListView.builder(
                                          itemCount: selCategory?.products?.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            final product = selCategory?.products?[index];
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: ListTile(
                                                selectedTileColor: primary.value,
                                                selected: '${selSubCategory?.id}' == '${product?.id}',
                                                onTap: () {
                                                  if (product?.price == null) {
                                                    ref.read(selSubCategoryProvider.notifier).update((_) => _ = product);
                                                  }
                                                },
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                leading: const Icon(Icons.payments_outlined, size: 34, color: Colors.black),
                                                title: Text(
                                                  product?.name ?? '',
                                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                                                ),
                                                // subtitle: Visibility(
                                                //   visible: product?.price != null,
                                                //   child: Text(
                                                //     '₹ ${product?.price ?? ''}',
                                                //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
                                                //   ),
                                                // ),
                                                trailing: Visibility(
                                                  visible: product?.price != null,
                                                  replacement: IconButton(
                                                    onPressed: () {
                                                      // Dialogs.loadingDailog(context);
                                                      // MongoDataBase().deleteOneCategory(data[i]).then((value) {
                                                      //   Navigator.pop(context);
                                                      //   // ignore: unused_result
                                                      //   value ? ref.refresh(categoryProvider) : null;
                                                      // });
                                                    },
                                                    icon: const Icon(Icons.delete, size: 32, color: Colors.black),
                                                  ),
                                                  child: Transform.scale(
                                                    scale: 1.8,
                                                    child: Checkbox(
                                                      value: ids.map((e) => e.id).contains(product?.id),
                                                      activeColor: primary.value,
                                                      onChanged: (_) {
                                                        if (_!) {
                                                          ref.read(selSubProducts.notifier).update((s) => [...ids, product!]);
                                                        } else {
                                                          ref.read(selSubProducts.notifier).update((s) => [...ids.where((e) => e.id != product!.id)]);
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //* Products
                        Flexible(
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            margin: const EdgeInsets.all(16),
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
                                          onChanged: (value) {},
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
                                      visible: selSubCategory?.products?.isNotEmpty ?? false,
                                      replacement: const Center(child: Text('No Foods !', style: TextStyle(fontSize: 24))),
                                      child: Consumer(builder: (context, ref, child) {
                                        final ids = ref.watch(selProducts);
                                        return ListView.builder(
                                          itemCount: selSubCategory?.products?.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            final product = selSubCategory?.products?[index];
                                            return ListTile(
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              leading: const Icon(Icons.payments_outlined, size: 34, color: Colors.black),
                                              title: Text(
                                                product?.name ?? '',
                                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
                                              ),
                                              // subtitle: Text(
                                              //   '₹ ${product?.price ?? ''}',
                                              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),
                                              // ),
                                              trailing: Transform.scale(
                                                scale: 1.8,
                                                child: Checkbox(
                                                  value: ids.map((e) => e.id).contains(product?.id),
                                                  activeColor: primary.value,
                                                  onChanged: (_) {
                                                    if (_!) {
                                                      ref.read(selProducts.notifier).update((s) => [...ids, product!]);
                                                    } else {
                                                      ref.read(selProducts.notifier).update((s) => [...ids.where((e) => e.id != product!.id)]);
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Consumer(
                        builder: (context, myType, child) {
                          final ids = ref.watch(selSubProducts);
                          return Visibility(
                            visible: ids.isNotEmpty,
                            child: GestureDetector(
                              onTap: () {
                                Dialogs.loadingDailog(context);
                                MongoDataBase().deleteProducts(ids.map((e) => e.id!).toList(), ids.first.categaryName ?? '', selCategory?.productIds ?? []).then((value) {
                                  Navigator.pop(context);
                                  // ignore: unused_result
                                  value ? ref.refresh(categoryProvider) : null;
                                });
                              },
                              child: Card(
                                margin: const EdgeInsets.all(32),
                                elevation: 10,
                                color: primary.value,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Icon(Icons.delete, size: 40, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
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
