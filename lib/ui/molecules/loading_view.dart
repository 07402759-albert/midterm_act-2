import 'package:flutter/material.dart';
import '../atoms/app_text.dart';
import '../atoms/loading_spinner.dart';

/// Molecule: spinner + label. Used for "waiting" on both screens.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LoadingSpinner(),
          const SizedBox(height: 16),
          AppText(label, variant: AppTextVariant.caption),
        ],
      ),
    );
  }
}
