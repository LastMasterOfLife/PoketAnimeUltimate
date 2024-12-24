
import 'package:flutter/material.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';
//import 'package:audioplayers/audioplayers.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  //late AudioPlayer player = AudioPlayer();
  void navigazione(){
    // Naviga automaticamente alla pagina di Login dopo 3 secondi
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomerscaffoldScreen()),
      );
    });
  }

  /*
  void _playMusic() async {
    await player.play(AssetSource('assets/Audio/caricamento.mp3'));
  }

   */
  @override @override
  void initState() {
    super.initState();
    //_playMusic();
    navigazione();
  }

  /*
  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

   */

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


