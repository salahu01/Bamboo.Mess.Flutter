import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

@immutable
class EmployeeModel {
  final String? id;
  final String? name;
  final String? age;
  final String? phone;

  const EmployeeModel({
    this.id,
    required this.name,
    required this.age,
    required this.phone,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        name: json['name'],
        age: json['age'],
        phone: json['phone'],
        id: (json["_id"] as ObjectId).$oid,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        'age': age,
        'phone': phone,
      };
}
