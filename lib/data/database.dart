import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/models/pokeModel.dart';

class SavedDataBase {
  List<dynamic> savedPokeList = [];

  final _box = Hive.box('pokeStore2');

  void loadData() {
    if (_box.get('POKELIST') == null) {
      _box.put('POKELIST', savedPokeList);
    } else {
      savedPokeList = _box.get('POKELIST');
    }
  }

  void updateDatabase() {
    _box.put('POKELIST', savedPokeList);
    print(_box.get('POKELIST'));
  }
}
