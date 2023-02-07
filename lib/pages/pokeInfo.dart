import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/pokemonFeedData.dart';

class PokeInfo extends StatefulWidget {
  final dynamic data;
  final Color color;

  const PokeInfo({Key? key, this.data, required this.color}) : super(key: key);

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
            : Container(
                color: widget.color.withOpacity(0.35),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.network(
                          '${pokeInfo['sprites']['front_default']}',
                          scale: 0.3, frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      }, loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokeInfo['types'].map<Widget>((type) {
                          return Container(
                              child: Text('${type['type']['name']}'));
                        }).toList()),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Height: ${pokeInfo['height'] / 10}m"),
                          Text("Weight: ${pokeInfo['weight'] / 10}kg")
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokeInfo['abilities'].map<Widget>((ability) {
                          return Container(
                              child: Text('${ability['ability']['name']}'));
                        }).toList()),
                  ],
                )));
  }
}
