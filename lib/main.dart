import 'package:flutter/material.dart';
import 'package:poketanime/Loading/Loading_screen.dart';
import 'package:poketanime/Services/Audio_service.dart';

void main() {
  runApp(const MyApp());
  AudioService.playBackgroundMusic('assets/Audio/phone_anime.mp3');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoadingScreen(),
    );
  }
}
