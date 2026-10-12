import 'package:flutter/material.dart';

/// Atom: one button used everywhere. Restyle all buttons by editing this file.
class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: Text(label));
  }
}
