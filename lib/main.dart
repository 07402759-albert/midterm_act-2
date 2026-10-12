import 'package:flutter/material.dart';
import 'ui/pages/app_shell.dart';

void main() => runApp(const PawprintApp());

class PawprintApp extends StatelessWidget {
  const PawprintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawprint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.brown,
      ),
      home: const AppShell(),
    );
  }
}
