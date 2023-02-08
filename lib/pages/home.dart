import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/components/pokemonTile.dart';
import 'package:pokedex/models/pokeModel.dart';
import 'package:pokedex/pages/saved.dart';
import 'package:provider/provider.dart';

import '../models/pokemonFeedData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    Provider.of<PokemonFeedData>(context, listen: false).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PokemonFeedData>(context);
    final pokeData = data.pokeList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'PokéDex',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 35,
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 10,
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.favorite,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Saved()))
                  .then((value) => {setState(() {})});
            },
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          children: [
            Expanded(
              child: data.isLoading
                  ? Center(
                      child: SizedBox(
                      width: 150,
                      child: Image.network(
                        'https://media.tenor.com/fSsxftCb8w0AAAAi/pikachu-running.gif',
                      ),
                    ))
                  : ListView(
                      controller: controller,
                      children: [
                        Column(
                          children: pokeData.asMap().entries.map((
                            item,
                          ) {
                            if (item.key == pokeData.length - 1) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<PokemonFeedData>(context,
                                            listen: false)
                                        .getMoreData();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF63747A),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 3,
                                            blurRadius: 4,
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Text(
                                      'Load More Pokémon',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return PokeTile(item.value, context);
                            }
                          }).toList(),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
