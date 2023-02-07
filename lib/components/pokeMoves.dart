import 'package:flutter/material.dart';
import 'package:pokedex/helpers/stringExtension.dart';

import 'textPill.dart';

class PokeMoves extends StatelessWidget {
  final dynamic pokeInfo;
  final Color color;
  const PokeMoves({Key? key, this.pokeInfo, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Moves',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              Column(
                  children: pokeInfo['moves'].map<Widget>((move) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextPill(
                      width: 250,
                      text: move['move']['name'].toString().capitalize(),
                      subtitle:
                          'Learn at level: ${move['version_group_details'][0]['level_learned_at']}',
                      color: color,
                      textColor: Colors.white),
                );
              }).toList()
                  // TextPill(
                  //   color: Color(0xFF63747A),
                  //   text: 'TEST',
                  //   textColor: Colors.white,
                  // )

                  ),
            ],
          ),
        ));
  }
}
