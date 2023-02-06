class Pokemon {
  final int id;
  final String name;
  final String img;

  Pokemon({
    required this.id,
    required this.name,
    required this.img,
  });

  factory Pokemon.fromJson(dynamic json) {
    return Pokemon(
        id: json['is'] as int,
        name: json['name'] as String,
        img: json['sprites']['front_default'] as String);
  }

  static List<Pokemon> pokemonFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Pokemon.fromJson(data);
    }).toList();
  }
}
