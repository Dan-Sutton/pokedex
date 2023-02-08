import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../components/pokemonTile.dart';
import '../data/database.dart';
import '../models/pokeModel.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final _box = Hive.box('pokeStore3');
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
              children: db.savedPokeList.map<Widget>((pokemon) {
                dynamic pokeModel = PokeModel(
                    id: pokemon['id'],
                    name: pokemon['name'],
                    image: pokemon['image'],
                    type1: pokemon['type1'],
                    type2: pokemon['type2']);
                return PokeTile(pokeModel, context);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
