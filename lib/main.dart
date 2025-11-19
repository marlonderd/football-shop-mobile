import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/screens/login.dart'; // Pastikan arahnya ke login.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Football Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(secondary: const Color.fromARGB(255, 118, 69, 224)),
          useMaterial3: true,
        ),
        // PERBAIKAN: Mulai dari LoginPage, bukan MyHomePage
        home: const LoginPage(),
      ),
    );
  }
}