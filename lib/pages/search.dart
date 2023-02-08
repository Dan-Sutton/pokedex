import 'package:flutter/material.dart';
import 'package:pokedex/pages/pokeInfo.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

String searchText = '';
bool hasSearched = false;

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 35,
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          children: [
            TextField(
              onChanged: ((value) => setState(() {
                    searchText = value;
                  })),
              onSubmitted: ((value) {
                print(searchText);
                setState(() {
                  hasSearched = true;
                  // searchText = '';
                });
              }),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  prefixIcon: Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.search),
                    width: 18,
                  )),
            ),
            hasSearched
                ? Text(
                    searchText,
                    style: TextStyle(color: Colors.black),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
