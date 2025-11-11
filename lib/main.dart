import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: const Color.fromARGB(255, 118, 69, 224)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
