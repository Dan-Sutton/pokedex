import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterdex/models/card_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutterdex/models/pokemon.dart';

class PoemonFeedData with ChangeNotifier {
  bool isLoading;
  bool isRequestError = false;
  List<CardModel> pokeList = [];
  List<Pokemon> descList = [];
  Pokemon pokemon = Pokemon();

  Future<void> getHomeData() async {
    int pokeNumber = 151;

    List<CardModel> tempList = [];
    isRequestError = false;
    for (int index = 1; index <= pokeNumber; index++) {
      try {
        isLoading = true;
        Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$index');
        final response = await http.get(url);
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        tempList.add(CardModel.fromJson(responseData));
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
