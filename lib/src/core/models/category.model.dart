import 'package:flutter/material.dart';
import 'package:freelance/src/core/models/product.model.dart';
import 'package:mongo_dart/mongo_dart.dart';

@immutable
final class CategoryModel {
  final String? id;
  final List<String?>? productIds;
  final List<ProductModel?>? products;
  final String? categaryName;

  const CategoryModel({
    this.id,
    this.products,
    required this.productIds,
    required this.categaryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, {List<ProductModel?> products = const []}) {
    final productMap = Map.fromEntries(products.where((product) => product != null).map((product) => MapEntry(product!.id, product)));
    final productIds = List<String>.from(json["products"].map((x) => x));
    return CategoryModel(
      id: (json["_id"] as ObjectId).$oid,
      productIds: productIds,
      products: List<ProductModel?>.from(productIds.map((productId) => productMap[productId])),
      categaryName: json["categary_name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "products": productIds ?? [],
        "categary_name": categaryName,
      };
}
