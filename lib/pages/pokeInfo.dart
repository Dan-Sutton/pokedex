import 'package:flutter/material.dart';

class PokeInfo extends StatefulWidget {
  final dynamic data;

  const PokeInfo({Key? key, this.data}) : super(key: key);

  @override
  _PokeInfoState createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  @override
  Widget build(BuildContext context) {
    print(widget.data.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(child: Text(widget.data.name)),
    );
  }
}
