import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

@immutable
class RecieptModel {
  final String? id;
  final List<Product>? products;
  final String? employee;

  const RecieptModel({required this.id, required this.products, required this.employee});

  factory RecieptModel.fromJson(Map<String, dynamic> json) => RecieptModel(
        employee: json['employee'],
        products: (json['products'] as List?)?.map((e) => Product.fromJson(e)).toList() ?? [],
        id: (json["_id"] as ObjectId).$oid,
      );

  Map<String, dynamic> toJson() => {
        'products': products?.map((v) => v.toJson()).toList() ?? [],
        'employee': employee,
      };
}

@immutable
class Product {
  final String? name;
  final int? price;
  final int? count;

  const Product({this.name, this.price, this.count});

  factory Product.fromJson(json) => Product(
        name: json['name'],
        price: json['price'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'count': count,
      };
}
