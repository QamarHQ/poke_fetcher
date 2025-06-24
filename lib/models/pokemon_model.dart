class PokemonModel {
  final String name;
  final String imageUrl;
  final int id;
  final int height;
  final int weight;
  final int baseExperience;
  final List<String> types;
  final Map<String, int> stats;

  PokemonModel({
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.types,
    required this.stats,
  });

  factory PokemonModel.fromJSON(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      id: json['id'],
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'],
      types: List<String>.from(json['types'].map((t) => t['type']['name'])),
      stats: {
        for (var stat in json['stats'])
          stat['stat']['name']: stat['base_stat'],
      },
    );
  }
}

