import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // ফায়ারবেসের ওয়েব কনফিগারেশনের জন্য এটি প্রয়োজন
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ফ্লাটার ওয়েবের জন্য অপশনসহ ফায়ারবেস ইনিশিয়ালাইজ করা
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const LoginScreen(),
    );
  }
}