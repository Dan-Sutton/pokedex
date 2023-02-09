import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/components/infoCard.dart';
import 'package:pokedex/components/pokemonTile.dart';
import 'package:pokedex/pages/pokeInfo.dart';
import 'package:http/http.dart' as http;

import '../models/pokeModel.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String errorMessage = "Pokémon doesn't exist!";
  bool error = false;

  dynamic pokeInfo;

  final fieldText = TextEditingController();

  void fetchPokeData(index) async {
    try {
      Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$index');
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      setState(() {
        pokeInfo = PokeModel.fromJson(responseData);
        error = false;
      });
    } catch (e) {
      setState(() {
        error = true;
      });

      // throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Search",
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
        child: Column(
          children: [
            TextField(
              controller: fieldText,
              onSubmitted: ((value) {
                fetchPokeData(value.toLowerCase());
                fieldText.clear();
              }),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  prefixIcon: Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.search),
                    width: 18,
                  )),
            ),
            pokeInfo == null && !error
                ? const Center(
                    child: Text(
                      'Search for a Pokémon',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )
                : error
                    ? Center(
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                    : Expanded(
                        child: InfoCard(data: pokeInfo),
                      )
          ],
        ),
      ),
    );
  }
}
