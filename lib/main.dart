import 'package:flutter/material.dart';
import 'package:madcamp_week_2/views/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '냠냠',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        fontFamily: 'SpoqaHanSansNeo',
        useMaterial3: true,
      ),
      home: const Navigation(),
    );
  }
}