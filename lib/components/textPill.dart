import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextPill extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double width;
  const TextPill(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      this.fontSize = 20,
      this.width = 110});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: textColor),
          ),
        ));
  }
}
