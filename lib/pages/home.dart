import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemonFeedData.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    context.read<PokemonFeedData>().fetchData;
    return Scaffold(body: Center(
      child: Consumer<PokemonFeedData>(builder: (context, value, child) {
        return value.map.length == 0 && !value.error
            ? CircularProgressIndicator()
            : value.error
                ? Text(
                    'Soemthing went wrong ${value.errorMessage}',
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    itemCount: value.map['results'].length,
                    itemBuilder: (context, index) {
                      return Text('Hello');
                    });
      }),
    ));
  }
}
