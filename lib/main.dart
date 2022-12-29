import 'package:flutter/material.dart';
import 'package:nomad_webtoon/webtoon/model/webtoon_model.dart';
import 'package:nomad_webtoon/webtoon/screen/home_screen.dart';
import 'package:nomad_webtoon/webtoon/services/api_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0xFFE7626C),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: Scaffold(
        body: HomeScreen(),
      )
    );
  }
}

