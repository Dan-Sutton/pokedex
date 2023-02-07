import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/pokemonFeedData.dart';

class PokeInfo extends StatefulWidget {
  final dynamic data;

  const PokeInfo({Key? key, this.data}) : super(key: key);

  @override
  _PokeInfoState createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  @override
  void initState() {
    super.initState();
  }

  Map pokeInfo = {};

  void fetchPokeData(index) async {
    Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$index');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    if (this.mounted) {
      setState(() {
        pokeInfo = responseData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchPokeData(widget.data.id);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.data.name),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: pokeInfo.isEmpty
            ? CircularProgressIndicator()
            : Container(child: Text('${pokeInfo['height']}')));
  }
}
