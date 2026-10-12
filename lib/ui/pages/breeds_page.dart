import 'package:flutter/material.dart';
import '../../models/breed.dart';
import '../../services/dog_api.dart';
import '../molecules/empty_view.dart';
import '../molecules/error_view.dart';
import '../molecules/loading_view.dart';
import '../organisms/breed_list.dart';
import '../templates/screen_template.dart';

/// SCREEN 1 - The Order (Future + FutureBuilder)
class BreedsPage extends StatefulWidget {
  const BreedsPage({super.key});

  @override
  State<BreedsPage> createState() => _BreedsPageState();
}

class _BreedsPageState extends State<BreedsPage> {
  late Future<List<Breed>> _breedsFuture;

  @override
  void initState() {
    super.initState();
    // Created ONCE. build() can run many times; initState runs once.
    _breedsFuture = DogApi.fetchBreeds();
  }

  // Retry deliberately swaps in a fresh Future, from a button, not from build().
  void _retry() {
    setState(() => _breedsFuture = DogApi.fetchBreeds());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: 'Breed Book',
      body: FutureBuilder<List<Breed>>(
        future: _breedsFuture,
        builder: (context, snap) {
          // Order matters: waiting -> error -> empty -> data
          if (snap.connectionState == ConnectionState.waiting) {
            return const LoadingView(label: 'Fetching breeds...');
          }
          if (snap.hasError) {
            return ErrorView(message: '${snap.error}', onRetry: _retry);
          }
          final breeds = snap.data ?? [];
          if (breeds.isEmpty) {
            return const EmptyView(message: 'No breeds found.');
          }
          return BreedList(breeds: breeds);
        },
      ),
    );
  }
}
