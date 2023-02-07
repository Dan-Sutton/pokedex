import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/components/pokeAbout.dart';
import 'package:pokedex/components/textPill.dart';
import 'package:pokedex/helpers/stringExtension.dart';
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
          backgroundColor: widget.color,
          title: Text("${widget.data.name}".capitalize()),
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
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230,
                        child: Image.network(
                            '${pokeInfo['sprites']['front_default']}',
                            scale: 0.1, frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                          return child;
                        }, loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                      ),
                      const Divider(
                        color: Color(0xFF63747A),
                        thickness: 2,
                        endIndent: 20,
                        indent: 20,
                      ),
                      CarouselSlider(
                        items: [
                          PokeAbout(
                            color: widget.color,
                            pokeInfo: pokeInfo,
                          )
                        ],
                        options: CarouselOptions(
                          enlargeFactor: 0,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 1.0,
                          initialPage: 1,
                        ),
                      )
                    ],
                  ),
                )));
  }
}