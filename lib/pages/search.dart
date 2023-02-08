import 'dart:convert';

import 'package:flutter/material.dart';
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
  String searchText = '';
  bool hasSearched = false;

  dynamic pokeInfo;

  void fetchPokeData(index) async {
    Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$index');
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;

    setState(() {
      pokeInfo = PokeModel.fromJson(responseData);
    });
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
              onChanged: ((value) => setState(() {
                    searchText = value;
                  })),
              onSubmitted: ((value) {
                fetchPokeData(searchText);
                // hasSearched = true;
                // searchText = '';
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
            pokeInfo == null
                ? Text(
                    'Search for a Pokémon',
                    style: TextStyle(color: Colors.black),
                  )
                : Expanded(
                    child: PokeInfo(data: pokeInfo),
                  )
          ],
        ),
      ),
    );
  }
}
