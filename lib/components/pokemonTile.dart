import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokeInfo.dart';

class PokeTile extends StatelessWidget {
  final dynamic poke;
  final BuildContext context;

  const PokeTile(this.poke, this.context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PokeInfo()));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.red),
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
                  poke.name,
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
            const Positioned(
              right: 0,
              child: Icon(
                Icons.favorite_border_outlined,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
