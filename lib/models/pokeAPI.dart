import 'package:flutter/material.dart';

import 'pokeModel.dart';

class PokeApi with ChangeNotifier {
  var mainUrl;

  PokeApi({
    this.mainUrl,
  });

  factory PokeApi.getUrl(dynamic json) {
    return PokeApi(
      mainUrl: json['url'],
    );
  }
}
