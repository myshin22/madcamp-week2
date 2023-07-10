import 'package:flutter/material.dart';
import 'package:week2/page/sample.page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.search),
        selectedIcon:
            Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
        label: '탐색',
      ),
      NavigationDestination(
          icon: const Icon(Icons.bookmark_outline),
          selectedIcon: Icon(Icons.bookmark,
              color: Theme.of(context).colorScheme.primary),
          label: '저장'),
      NavigationDestination(
          icon: const Icon(Icons.add_box_outlined),
          selectedIcon:
              Icon(Icons.add_box, color: Theme.of(context).colorScheme.primary),
          label: '작성'),
      NavigationDestination(
        icon: const Icon(Icons.account_circle_outlined),
        selectedIcon: Icon(Icons.account_circle,
            color: Theme.of(context).colorScheme.primary),
        label: '프로필',
      ),
    ];
    final body = [
      const SamplePage(),
      const SamplePage(),
      const SamplePage(),
      const SamplePage()
    ];
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: destinations),
      body: body[currentPageIndex],
    );
  }
}
