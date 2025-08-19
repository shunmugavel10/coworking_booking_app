import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget body;
  final int currentIndex;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go('/home'); break;
            case 1: context.go('/map'); break;
            case 2: context.go('/my-bookings'); break;
            case 3: context.go('/notifications'); break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.notifications_none), selectedIcon: Icon(Icons.notifications), label: 'Alerts'),
        ],
      ),
    );
  }
}
