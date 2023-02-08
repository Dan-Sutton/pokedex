import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemonFeedData.dart';
import 'package:pokedex/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //Init local storage
  await Hive.initFlutter();

  var box = await Hive.openBox('localStore');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        builder: (context, child) {
          return Home();
        },
        create: (context) => PokemonFeedData(),
      ),
    );
  }
}
