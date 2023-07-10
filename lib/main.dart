import 'package:flutter/material.dart';
import 'package:week2/page/navigation.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '냠냠',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        fontFamily: 'SpoqaHanSansNeo',
        useMaterial3: true,
      ),
      home: const NavigationPage(),
    );
  }
}