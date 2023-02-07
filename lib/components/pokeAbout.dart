import 'package:flutter/material.dart';
import 'package:pokedex/components/textPill.dart';
import 'package:pokedex/helpers/stringExtension.dart';

class PokeAbout extends StatelessWidget {
  final dynamic pokeInfo;
  final Color color;
  const PokeAbout({Key? key, this.pokeInfo, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Type',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: pokeInfo['types'].map<Widget>((type) {
                return TextPill(
                    text: '${type['type']['name']}',
                    color: color,
                    textColor: Colors.white);
              }).toList()),
          const Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 20),
            child: Text(
              'Attributes',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextPill(
                  fontSize: 18,
                  text: "Height: ${pokeInfo['height'] / 10}m",
                  color: Color(0xFF63747A),
                  textColor: Colors.white),
              TextPill(
                  fontSize: 18,
                  text: "Weight: ${pokeInfo['weight'] / 10}kg",
                  color: Color(0xFF63747A),
                  textColor: Colors.white),
            ],
          ),
          const Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 20),
            child: Text(
              'Abilities',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: pokeInfo['abilities'].map<Widget>((ability) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                      child: TextPill(
                          width: 250,
                          fontSize: 18,
                          text: '${ability['ability']['name']}'.capitalize(),
                          color: Color(0xFF63747A),
                          textColor: Colors.white)),
                );
              }).toList()),
        ],
      ),
    );
  }
}
