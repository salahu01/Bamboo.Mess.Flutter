import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

@immutable
class ProductModel {
  final String? id;
  final String? name;
  final num? price;
  final String? categaryName;
  final List<String?>? productIds;
  final List<ProductModel?>? products;

  const ProductModel({
    this.id,
    this.productIds,
    this.products,
    this.price,
    required this.name,
    this.categaryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, {List<ProductModel?>? products}) => ProductModel(
        categaryName: json['categary_name'],
        name: json['name'],
        price: json['price'],
        id: (json["_id"] as ObjectId).$oid,
        productIds: json["products"] == null ? null : List<String>.from(json["products"].map((x) => x)),
        products: products == null ? [] : (json["products"] as List? ?? []).cast<String?>().map((e) => products.singleWhere((v) => '${v?.id}' == '$e')).toList(),
      );

  ProductModel update(List<ProductModel>? subs) {
    return ProductModel(
      name: name,
      categaryName: categaryName,
      id: id,
      price: price,
      productIds: productIds,
      products: productIds?.map((e) => subs?.singleWhere((_) => _.id == e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'name': name};
    if (categaryName != null) json['categary_name'] = categaryName;
    if (price != null) json['price'] = price;
    if (productIds != null) json['products'] = productIds;
    return json;
  }
}
