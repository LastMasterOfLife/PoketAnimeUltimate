import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool start = false; // Rimosso `late` poiché non necessario qui.

  final _player = AudioPlayer();

  Future<void> _init() async {
    // Ascolta gli errori durante la riproduzione
    _player.playbackEventStream.listen(
          (event) {},
      onError: (Object e, StackTrace stackTrace) {
        debugPrint('Errore durante la riproduzione: $e');
      },
    );
    try {
      await _player.setAsset("assets/Audio/pescamisteriosa.mp3");
      // Avvia la riproduzione dell'audio
      await _player.setLoopMode(LoopMode.all);
      await _player.play();
    } on PlayerException catch (e) {
      debugPrint("Errore durante il caricamento della sorgente audio: ${e.message}");
    }
  }

  void _navigateAfterDelay() {
    // Naviga automaticamente alla pagina di Login dopo 5 secondi
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        start = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
    _init();
  }


  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: start
          ? GestureDetector(
        onTap: () {
          //_player.stop();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CustomerscaffoldScreen()),
          );
        },
        child: const Center(
          child: Text(
            "Tocca per continuare",
            style: TextStyle(fontSize: 30),
          ),
        ),
      )
          : const SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Animaker",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
