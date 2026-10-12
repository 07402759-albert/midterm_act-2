import 'package:flutter/material.dart';
import '../atoms/app_icon.dart';
import '../atoms/app_text.dart';

/// Molecule: icon + message for "worked, but nothing to show".
class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppIcon(Icons.pets, color: Colors.black38),
          const SizedBox(height: 12),
          AppText(message, variant: AppTextVariant.caption),
        ],
      ),
    );
  }
}
