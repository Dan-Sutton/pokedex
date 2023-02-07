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

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<PokemonFeedData>(context, listen: false).getHomeData();
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
            SafeArea(
              child: Text(
                'Poké',
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
                  : RefreshIndicator(
                      onRefresh: () => _refreshData(context),
                      child: ListView(
                        children: [
                          Column(
                            children: pokeData
                                .map((item) => PokeTile(item, context))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
