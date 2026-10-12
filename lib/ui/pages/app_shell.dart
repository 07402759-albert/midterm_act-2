import 'package:flutter/material.dart';
import 'breeds_page.dart';
import 'live_dog_page.dart';

/// Holds the bottom navigation and swaps between the two screens.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  // Only the selected page is built, so the live feed stops polling when you
  // leave that tab.
  static const _pages = [BreedsPage(), LiveDogPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Breeds'),
          NavigationDestination(icon: Icon(Icons.pets), label: 'Live'),
        ],
      ),
    );
  }
}
