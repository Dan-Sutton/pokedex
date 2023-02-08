import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/components/pokemonTile.dart';
import 'package:pokedex/pages/saved.dart';
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => Saved(
                            pokeInfo: pokeData,
                          ))).then((value) => {setState(() {})});
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
