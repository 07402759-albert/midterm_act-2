import 'package:flutter/material.dart';
import '../atoms/app_button.dart';
import '../atoms/app_icon.dart';
import '../atoms/app_text.dart';

/// Molecule: icon + message + optional Retry button.
/// The Future screen passes onRetry. The Stream screen retries by itself, so
/// it passes a hint instead.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.onRetry, this.hint});

  final String message;
  final VoidCallback? onRetry;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIcon(Icons.wifi_off, color: Colors.redAccent),
            const SizedBox(height: 12),
            const AppText('Something went wrong',
                variant: AppTextVariant.title, center: true),
            const SizedBox(height: 8),
            AppText(message, center: true),
            if (hint != null) ...[
              const SizedBox(height: 8),
              AppText(hint!, variant: AppTextVariant.caption, center: true),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              AppButton(label: 'Retry', onPressed: onRetry!),
            ],
          ],
        ),
      ),
    );
  }
}
