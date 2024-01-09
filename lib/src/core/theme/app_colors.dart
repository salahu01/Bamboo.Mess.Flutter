import 'package:flutter/material.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';

//Accent colors

final primaryColors = [
  const Color(0xFF911D5E),
  Colors.pinkAccent,
  Colors.blueGrey,
  Colors.lightGreen[800],
  Colors.red,
  Colors.teal[200],
  Colors.purpleAccent[200],
];

//Selected primary.value.value
final ValueNotifier<Color> primary = ValueNotifier(const Color(0xFF911D5E));

Future<void> retriveColor() async {
  final _ = await LocalDataBase().retriveColor();
  primary.value = primaryColors[_]!;
}
