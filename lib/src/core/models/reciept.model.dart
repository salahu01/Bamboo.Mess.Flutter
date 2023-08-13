import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:freelance/src/core/extensions/date_time.extension.dart';


class RecieptModel {
  // final String? id;
  final DateTime? date;
  final List<Product>? products;
  late final num? totalAmount;
  late final String? time;
  final String? employee;

  RecieptModel({
    // required this.id,
    required this.products,
    required this.employee,
    required this.date,
    required this.totalAmount,
    required this.time,
  });

  factory RecieptModel.fromJson(Map<String, dynamic> json) {
    log('$json');
    final tempProducts = (json['products'] as List?)?.map((e) => Product.fromJson(e)).toList() ?? [];
    final dateTime = json['date'] == null ? null : (json['date'] as DateTime).findTime;
    return RecieptModel(
      employee: json['employee'],
      date: json['date'],
      products: tempProducts,
      // id: (json["_id"] as ObjectId).$oid,
      totalAmount: tempProducts.map((e) => e.price).reduce((a, b) => (a ?? 0) + (b ?? 0)),
      time: dateTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'products': products?.map((v) => v.toJson()).toList() ?? [],
        'employee': employee,
        'date': date,
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
