import 'package:flutter/material.dart';
import '../../models/breed.dart';
import '../molecules/breed_tile.dart';

/// Organism: the scrolling list of breeds. It receives data. It never fetches it.
class BreedList extends StatelessWidget {
  const BreedList({super.key, required this.breeds});

  final List<Breed> breeds;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: breeds.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => BreedTile(breed: breeds[i]),
    );
  }
}
