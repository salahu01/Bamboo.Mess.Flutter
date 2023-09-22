part of '../printer.dart';


enum PrintAlignment { right, center, left }

int setAlignment(PrintAlignment alignment) {
  return {
    PrintAlignment.left: 0,
    PrintAlignment.center: 1,
    PrintAlignment.right: 2,
  }[alignment]!;
}