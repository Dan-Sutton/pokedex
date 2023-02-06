import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PokemonTile extends StatefulWidget {
  final Map tileData;
  const PokemonTile({Key? key, required this.tileData}) : super(key: key);

  @override
  State<PokemonTile> createState() => _PokemonTileState();
}

bool loading = true;
Map pokeData = {};

class _PokemonTileState extends State<PokemonTile> {
  @override
  Widget build(BuildContext context) {
    bool _error = false;
    String _errorMessage = "";

    void getPokeData() async {
      final response = await get(
        Uri.parse('${widget.tileData['url']}'),
      );
      if (response.statusCode == 200) {
        try {
          _error = false;
          setState(() {
            loading = false;
            pokeData = jsonDecode(response.body);
          });
        } catch (e) {
          _error = true;
          _errorMessage = e.toString();
          setState(() {
            pokeData = {};
          });
        }
      } else {
        _error = true;
        _errorMessage = 'Something went wrong.';
        setState(() {
          pokeData = {};
        });
      }
    }

    if (loading) {
      getPokeData();
    }

    return loading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: Row(
                children: [
                  Text('#${pokeData['id']}'),
                  Text(widget.tileData['name']),
                  Image.network('${pokeData['sprites']['front_default']}'),
                ],
              ),
            ),
          );
  }
}
