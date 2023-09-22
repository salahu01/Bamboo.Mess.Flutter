part of '../printer.dart';

@immutable
final class PrintText {
  final String text;
  final bool bold;
  final PrintAlignment alignment;
  final double underLineHeight;
  final int size;
  final bool underLine;

  const PrintText(
    this.text, {
    this.bold = false,
    this.underLine = false,
    this.size = 12,
    this.underLineHeight = 4,
    this.alignment = PrintAlignment.center,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'bold': bold,
        'alignment': setAlignment(alignment),
        'underLineHeight': underLineHeight,
        'size': size,
        'underline': underLine,
      };
}
