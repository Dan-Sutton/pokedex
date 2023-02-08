import 'package:hive_flutter/hive_flutter.dart';

class SavedDataBase {
  List savedPokeList = [];

  final _box = Hive.openBox('pokeStore1');
}
