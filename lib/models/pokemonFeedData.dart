import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'pokeModel.dart';

class PokemonFeedData with ChangeNotifier {
  late bool isLoading;
  bool isRequestError = false;
  List<PokeModel> pokeList = [];

  Future<void> getHomeData() async {
    int pokeNumber = 151;

    List<PokeModel> tempList = [];
    isRequestError = false;
    for (int index = 1; index <= pokeNumber; index++) {
      try {
        isLoading = true;
        Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$index');
        final response = await http.get(url);
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        tempList.add(PokeModel.fromJson(responseData));
      } catch (e) {
        throw (e);
      }
    }
    if (tempList.length == pokeNumber) {
      pokeList = tempList;
      isLoading = false;
      notifyListeners();
      inspect(pokeList);
    }
  }
}
