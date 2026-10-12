import 'package:flutter/material.dart';
import '../../models/dog_photo.dart';
import '../atoms/app_text.dart';

/// Organism: a card with the photo, breed name, and update number.
class DogPhotoCard extends StatelessWidget {
  const DogPhotoCard({super.key, required this.photo, required this.number});

  final DogPhoto photo;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              photo.url,
              fit: BoxFit.cover,
              // Image loading can fail too (e.g. airplane mode). Never crash.
              loadingBuilder: (c, child, progress) => progress == null
                  ? child
                  : const Center(child: CircularProgressIndicator()),
              errorBuilder: (c, e, s) =>
                  const Center(child: Icon(Icons.broken_image, size: 48)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                AppText(photo.breed, variant: AppTextVariant.title),
                const SizedBox(height: 4),
                AppText('Update #$number', variant: AppTextVariant.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
