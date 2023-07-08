import 'package:flutter/material.dart';
import 'package:madcamp_week_2/views/bookmark_screen.dart';
import 'package:madcamp_week_2/views/feed_screen.dart';
import 'package:madcamp_week_2/views/profile_screen.dart';
import 'package:madcamp_week_2/views/search_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        indicatorColor: Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search_outlined,
                color: Theme.of(context).colorScheme.primary),
            label: '검색',
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt_outlined,
                color: Theme.of(context).colorScheme.primary),
            label: '친구',
          ),
          NavigationDestination(
              icon: const Icon(Icons.bookmark_outline),
              selectedIcon: Icon(Icons.bookmark_outline,
                  color: Theme.of(context).colorScheme.primary),
              label: '저장'),
          NavigationDestination(
            icon: const Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle_outlined,
                color: Theme.of(context).colorScheme.primary),
            label: '프로필',
          ),
        ],
      ),
      body: <Widget>[
        SearchScreen(),
        FeedScreen(),
        BookmarkScreen(),
        ProfileScreen()
        // Container(
        //   color: Colors.red,
        //   alignment: Alignment.center,
        //   child: const Text('Page 1'),
        // ),
        // Container(
        //   color: Colors.green,
        //   alignment: Alignment.center,
        //   child: const Text('Page 2'),
        // ),
        // Container(
        //   color: Colors.blue,
        //   alignment: Alignment.center,
        //   child: const Text('Page 3'),
        // ),
        // Container(
        //   color: Colors.blue,
        //   alignment: Alignment.center,
        //   child: const Text('Page 4'),
        // ),
      ][currentPageIndex],
    );
  }
}
