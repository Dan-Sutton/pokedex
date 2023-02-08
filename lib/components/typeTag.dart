import 'package:flutter/material.dart';

class TypeTag extends StatelessWidget {
  final String text;
  const TypeTag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black, width: 1.3)),
        child: Text(text));
  }
}
