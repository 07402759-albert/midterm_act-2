import 'package:flutter/material.dart';

/// Atom: an icon with consistent sizing.
class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 48, this.color});

  final IconData icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Icon(icon, size: size, color: color);
}
