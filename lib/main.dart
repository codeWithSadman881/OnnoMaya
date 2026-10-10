import 'package:flutter/material.dart';
import 'screens/role_selection_screen.dart'; // রোল সিলেকশন স্ক্রিন ইম্পোর্ট করা হলো

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
      home: const RoleSelectionScreen(), // হোম স্ক্রিনের বদলে রোল সিলেকশন স্ক্রিন সেট করা হলো
    );
  }
}