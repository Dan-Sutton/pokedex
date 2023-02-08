import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/components/pokeAbout.dart';
import 'package:pokedex/components/pokeMoves.dart';
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

  CarouselController buttonCarouselController = CarouselController();
  Map pokeInfo = {};
  int activePage = 0;

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

  final _box = Hive.box('pokeStore1');

//Write like to database
  void addLikePokemon(id, name) {
    _box.put(id, name);
  }

//Delete like from database
  void removeLikePokemon(id) {
    _box.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    bool liked = _box.get(widget.data.id) == null ? false : true;
    fetchPokeData(widget.data.id);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(
            "${widget.data.name}".capitalize(),
            style: const TextStyle(
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
                        child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                  left: 20,
                                  top: 20,
                                  child: Text('#${widget.data.id}',
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800))),
                              Positioned(
                                  right: 20,
                                  top: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!liked) {
                                        addLikePokemon(
                                            widget.data.id, widget.data.name);
                                        setState(() {
                                          !liked;
                                        });
                                      } else {
                                        removeLikePokemon(widget.data.id);
                                        setState(() {
                                          !liked;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      liked
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      size: 33,
                                    ),
                                  )),
                              Image.network(
                                  '${pokeInfo['sprites']['front_default']}',
                                  scale: 0.1, frameBuilder: (context, child,
                                      frame, wasSynchronouslyLoaded) {
                                return child;
                              }, loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                            ]),
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
                          ),
                          PokeMoves(
                            pokeInfo: pokeInfo,
                            color: widget.color,
                          ),
                        ],
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          enlargeFactor: 0,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 0.95,
                          initialPage: 0,
                          onPageChanged: (page, reason) {
                            setState(() {
                              activePage = page;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                buttonCarouselController.jumpToPage(0);
                              },
                              child: Icon(
                                Icons.circle,
                                size: activePage == 0 ? 25 : 20,
                                color: activePage == 0
                                    ? Colors.white
                                    : widget.color,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  buttonCarouselController.jumpToPage(1);
                                },
                                child: Icon(
                                  Icons.circle,
                                  size: activePage == 1 ? 25 : 20,
                                  color: activePage == 1
                                      ? Colors.white
                                      : widget.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )));
  }
}
