import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/helpers/stringExtension.dart';
import 'package:pokedex/pages/pokeInfo.dart';
import '../helpers/pokeTypeColor.dart';

class PokeTile extends StatelessWidget {
  final dynamic poke;
  final BuildContext context;

  PokeTile(this.poke, this.context, {super.key});

  final _box = Hive.box('localStore');

  void addLikePokemon(id, name) {
    _box.put(id, name);
    print(_box.get(id));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PokeInfo(data: poke, color: setTileColor(poke.type1))));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: setTileColor(poke.type1)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '# ${poke.id}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Text(
                  '${poke.name}'.capitalize(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(poke.type1),
                    SizedBox(width: 5),
                    if (poke.type2 != null) Text(poke.type2),
                  ],
                )
              ],
            ),
            Positioned(
              right: 30,
              bottom: -35,
              child: Image.network(
                poke.image,
                scale: 0.7,
              ),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  addLikePokemon(poke.id, poke.name);
                },
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
