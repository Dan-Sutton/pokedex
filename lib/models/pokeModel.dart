import 'package:flutter/material.dart';

class PokeModel with ChangeNotifier {
  var id;
  var name;
  var image;
  var type1;
  var type2;

  PokeModel({
    this.id,
    this.name,
    this.image,
    this.type1,
    this.type2,
  });

  factory PokeModel.fromJson(Map<String, dynamic> json) {
    String pokeId = json['id'].toString();
    final List types = json['types'];
    if (types.length == 1) {
      return PokeModel(
        id: pokeId,
        name: json['name'],
        image: json['sprites']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: null,
      );
    } else {
      return PokeModel(
        id: pokeId,
        name: json['name'],
        image: json['sprites']['front_default'],
        type1: json['types'][0]['type']['name'],
        type2: json['types'][1]['type']['name'],
      );
    }
  }
}
