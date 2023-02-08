import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/helpers/stringExtension.dart';
import 'package:pokedex/pages/pokeInfo.dart';
import '../helpers/pokeTypeColor.dart';

class PokeTile extends StatefulWidget {
  final dynamic poke;
  final BuildContext context;

  PokeTile(this.poke, this.context, {super.key});

  @override
  State<PokeTile> createState() => _PokeTileState();
}

class _PokeTileState extends State<PokeTile> {
  final _box = Hive.box('localStore');

//Write like to database
  void addLikePokemon(id, name) {
    _box.put(id, name);
    print(_box.get(id));
  }

  void removeLikePokemon(id) {
    _box.delete(id);
  }

  

  @override
  Widget build(BuildContext context) {
   bool liked = _box.get(widget.poke.id) == null ? false : true;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokeInfo(
                    data: widget.poke,
                    color: setTileColor(widget.poke.type1))));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: setTileColor(widget.poke.type1)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '# ${widget.poke.id}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Text(
                  '${widget.poke.name}'.capitalize(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(widget.poke.type1),
                    SizedBox(width: 5),
                    if (widget.poke.type2 != null) Text(widget.poke.type2),
                  ],
                )
              ],
            ),
            Positioned(
              right: 30,
              bottom: -35,
              child: Image.network(
                widget.poke.image,
                scale: 0.7,
              ),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  addLikePokemon(widget.poke.id, widget.poke.name);
                  setState(() {
                    !liked;
                  });
                },
                child: Icon(
                  liked ? Icons.favorite : Icons.favorite_border_outlined,
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
