import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? fontSize;
  final Widget? child;
  final Color? color;
  const SaveButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.fontSize,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFfa9e18),
        ),
        child: Center(
          child: child ??
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize ?? (10),
                  fontWeight: FontWeight.w500,
                ),
              ),
        ),
      ),
    );
  }
}
