import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/helpers/stringExtension.dart';
import 'package:pokedex/pages/pokeInfo.dart';
import '../data/database.dart';
import '../helpers/pokeTypeColor.dart';

class PokeTile extends StatefulWidget {
  final dynamic poke;
  final BuildContext context;

  PokeTile(this.poke, this.context, {super.key});

  @override
  State<PokeTile> createState() => _PokeTileState();
}

class _PokeTileState extends State<PokeTile> {
  final _box = Hive.box('pokeStore2');
  SavedDataBase db = SavedDataBase();

  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool liked = db.savedPokeList.any((savedPoke) {
      if (savedPoke['id'] == widget.poke.id) {
        return true;
      } else {
        return false;
      }
    });
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokeInfo(
                        data: widget.poke,
                        color: setTileColor(widget.poke.type1))))
            .then((value) => {setState(() {})});
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
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
                  if (!liked) {
                    db.savedPokeList.add({
                      'id': widget.poke.id,
                      'name': widget.poke.name,
                      'image': widget.poke.image,
                      'type1': widget.poke.type1,
                      'type2': widget.poke.type2
                    });
                    setState(() {
                      !liked;
                      db.updateDatabase();
                    });
                    db.updateDatabase();
                  } else {
                    db.savedPokeList
                        .removeWhere((poke) => poke['id'] == widget.poke.id);
                    setState(() {
                      !liked;
                      db.updateDatabase();
                    });
                  }
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
