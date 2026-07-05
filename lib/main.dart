import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RutasPanamaApp());
}

class RutasPanamaApp extends StatelessWidget {
  const RutasPanamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rutas Panamá',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006B5E)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
