import 'package:hive_flutter/hive_flutter.dart';

class SavedDataBase {
  List savedPokeList = [];

  final _box = Hive.box('pokeStore1');

  void loadData() {
    savedPokeList = _box.get('POKELIST');
  }

  void updateDatabase() {
    _box.put('POKELIST', savedPokeList);
  }
}
