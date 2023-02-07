import 'package:flutter/material.dart';

import 'textPill.dart';

class PokeMoves extends StatelessWidget {
  const PokeMoves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: const [
        TextPill(
          color: Color(0xFF63747A),
          text: 'TEST',
          textColor: Colors.white,
        )
      ],
    ));
  }
}
