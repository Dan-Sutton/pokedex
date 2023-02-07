import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextPill extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double width;
  final String? subtitle;
  const TextPill(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      this.fontSize = 20,
      this.width = 110,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(15), color: color),
        child: Center(
          child: Column(
            children: [
              
              Text(
                text,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
              subtitle != null
                  ? Text(
                      subtitle!,
                      style: TextStyle(
                          fontSize: fontSize - 2,
                          fontWeight: FontWeight.w400,
                          color: textColor),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
