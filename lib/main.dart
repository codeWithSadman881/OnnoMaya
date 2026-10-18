import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // লগইন স্ক্রিন ইম্পোর্ট

void main() {
  runApp(const FoodResqApp());
}

class FoodResqApp extends StatelessWidget {
  const FoodResqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnnoMaya',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // রোল সিলেকশনের বদলে লগইন স্ক্রিন সেট করা হলো
    );
  }
}