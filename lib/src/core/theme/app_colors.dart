import 'package:flutter/material.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';

//Accent colors

final primaryColors = [
  Colors.pinkAccent,
  Colors.blueGrey,
  Colors.lightGreen[800],
  Colors.red,
  Colors.blue[200],
  Colors.teal[200],
  Colors.purpleAccent[200]
];

//Selected primary.value.value
final ValueNotifier<Color> primary = ValueNotifier(Colors.pinkAccent);

Future<void> retriveColor() async {
  final _ = await LocalDataBase().retriveColor();
  primary.value = primaryColors[_ ]!;
}

