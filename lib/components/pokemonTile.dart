import 'package:flutter/material.dart';

class PokeTile extends StatelessWidget {
  final dynamic poke;
  final BuildContext context;

  const PokeTile(this.poke, this.context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '# ${poke.id}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
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
            // Positioned(right: -40, bottom: -40, child: Image.asset(poke.image)),
          ],
        ),
      ),
    );
  }
}
