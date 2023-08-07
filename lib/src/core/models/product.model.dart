import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

@immutable
class ProductModel {
  final String? id;
  final String? name;
  final int? price;
  final String? categaryName;

  const ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.categaryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        categaryName: json['categary_name'],
        name: json['name'],
        price: json['price'],
        id: (json["_id"] as ObjectId).$oid,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'categary_name': categaryName,
      };
}
