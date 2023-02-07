import 'package:flutter/material.dart';
import 'package:pokedex/components/pokemonTile.dart';
import 'package:provider/provider.dart';

import '../models/pokemonFeedData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          children: [
            const SafeArea(
              child: Text(
                'PokéDex',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 35,
                ),
              ),
            ),
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
                      children: [
                        Column(
                          children: pokeData.asMap().entries.map((
                            item,
                          ) {
                            if (item.key == pokeData.length - 1) {
                              return Image.network(
                                'https://i.imgur.com/rbMq6sW.gif',
                                scale: 7,
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
