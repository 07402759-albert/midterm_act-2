/// One dog breed, e.g. "bulldog" with sub-breeds ["boston", "english", "french"].
class Breed {
  const Breed({required this.name, required this.subBreeds});

  final String name;
  final List<String> subBreeds;

  /// Expects: {"name": "bulldog", "subBreeds": ["boston", "english"]}
  /// Casts happen here, so a wrong key or type fails here and not inside the UI.
  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      name: json['name'] as String,
      subBreeds: (json['subBreeds'] as List<dynamic>).cast<String>(),
    );
  }
}
