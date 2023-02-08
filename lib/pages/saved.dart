import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/pokemonTile.dart';
import '../data/database.dart';

class Saved extends StatefulWidget {
  final dynamic pokeInfo;
  const Saved({Key? key, this.pokeInfo}) : super(key: key);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final _box = Hive.box('pokeStore1');
  SavedDataBase db = SavedDataBase();

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Pokémon",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 35,
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: ListView(
          children: [
            Column(
              children: widget.pokeInfo.map<Widget>((poke) {
                if (db.savedPokeList.contains(poke.id)) {
                  return PokeTile(poke, context);
                } else {
                  return Container();
                }
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
