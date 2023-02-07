import 'package:flutter/material.dart';

class PokeInfo extends StatefulWidget {
  const PokeInfo({Key? key}) : super(key: key);

  @override
  _PokeInfoState createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(child: Text('TEST')),
    );
  }
}
