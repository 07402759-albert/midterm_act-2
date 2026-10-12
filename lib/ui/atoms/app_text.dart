import 'package:flutter/material.dart';

enum AppTextVariant { title, body, caption }

/// Atom: styled text. No logic, just presentation.
class AppText extends StatelessWidget {
  const AppText(this.text,
      {super.key, this.variant = AppTextVariant.body, this.center = false});

  final String text;
  final AppTextVariant variant;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final style = switch (variant) {
      AppTextVariant.title =>
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      AppTextVariant.body => const TextStyle(fontSize: 15),
      AppTextVariant.caption =>
        const TextStyle(fontSize: 13, color: Colors.black54),
    };
    return Text(text,
        style: style, textAlign: center ? TextAlign.center : TextAlign.start);
  }
}
