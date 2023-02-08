import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: db.savedPokeList.map<Widget>((poke) {
            return Text(poke.toString());
          }).toList(),
        ),
      ),
    );
  }
}
