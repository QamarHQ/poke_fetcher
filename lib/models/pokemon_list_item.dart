class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'],
      url: json['url'],
    );
  }
}
