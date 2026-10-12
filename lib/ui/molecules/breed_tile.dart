import 'package:flutter/material.dart';
import '../../models/breed.dart';
import '../atoms/app_text.dart';

/// Molecule: one row showing a breed name and how many sub-breeds it has.
class BreedTile extends StatelessWidget {
  const BreedTile({super.key, required this.breed});

  final Breed breed;

  String get _title =>
      breed.name[0].toUpperCase() + breed.name.substring(1);

  @override
  Widget build(BuildContext context) {
    final subs = breed.subBreeds.length;
    return ListTile(
      leading: CircleAvatar(child: Text(breed.name[0].toUpperCase())),
      title: AppText(_title),
      subtitle: AppText(
        subs == 0 ? 'No sub-breeds' : '$subs sub-breed${subs == 1 ? '' : 's'}',
        variant: AppTextVariant.caption,
      ),
    );
  }
}
