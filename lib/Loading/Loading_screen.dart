
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final _player = AudioPlayer();

  Future<void> _init() async {
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAsset("assets/Audio/pescamisteriosa.mp3");
      // Start playing the audio
      await _player.play();
      // Optional: Set the audio to loop
      await _player.setLoopMode(LoopMode.all);
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void navigazione(){
    // Naviga automaticamente alla pagina di Login dopo 3 secondi
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomerscaffoldScreen()),
      );
    });
  }




  @override @override
  void initState() {
    super.initState();
    navigazione();
    _init();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Animaker", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40
            ),)),
          ],
        ),
      ),
    );
  }
}


