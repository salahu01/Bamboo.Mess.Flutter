import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

@immutable
class EmployeeModel {
  final String? id;
  final String? name;

  const EmployeeModel({this.id, required this.name});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        name: json['name'],
        id: (json["_id"] as ObjectId).$oid,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
