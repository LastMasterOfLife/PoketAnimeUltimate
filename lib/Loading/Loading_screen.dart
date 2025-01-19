import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart'; // Importa audioplayers
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool start = false;
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  VideoPlayerController? _currentController; // Modifica: ora è nullable

  final AudioPlayer _audioPlayer = AudioPlayer(); // Aggiungi l'AudioPlayer

  @override
  void initState() {
    super.initState();
    _initializeVideos();
    _startBackgroundMusic(); // Avvia la musica di sottofondo
    _navigateAfterDelay();
  }

  Future<void> _initializeVideos() async {
    _controller1 = VideoPlayerController.asset('assets/Video/video1.mp4');
    _controller2 = VideoPlayerController.asset('assets/Video/video2.mp4');
    _controller3 = VideoPlayerController.asset('assets/Video/video3.mp4');

    await _controller1.initialize();
    _controller1.setLooping(false);
    _controller1.setVolume(0.0);
    _controller1.play();

    setState(() {
      _currentController = _controller1;
    });

    _controller1.addListener(() {
      if (_controller1.value.position >= _controller1.value.duration) {
        _playNextVideo(_controller2);
      }
    });
  }

  void _playNextVideo(VideoPlayerController nextController) async {
    _currentController?.pause();
    _currentController?.seekTo(Duration.zero);

    await nextController.initialize();
    nextController.setLooping(false);
    nextController.setVolume(0.0);
    nextController.play();

    setState(() {
      _currentController = nextController;
    });

    nextController.addListener(() {
      if (nextController.value.position >= nextController.value.duration) {
        if (nextController == _controller1) {
          _playNextVideo(_controller2);
        } else if (nextController == _controller2) {
          _playNextVideo(_controller3);
        } else {
          _playNextVideo(_controller1);
        }
      }
    });
  }

  void _startBackgroundMusic() async {
    // Riproduci la musica in loop
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.setVolume(1.0);
    await _audioPlayer.play(AssetSource('assets/Audio/caricamento.mp3'));// Sostituisci con il percorso corretto

  }

  void _navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        start = true;
      });
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _audioPlayer.dispose(); // Disabilita il player quando lo screen viene distrutto
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: start
            ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomerscaffoldScreen(),
            ),
          );
        }
            : null,
        child: Stack(
          children: [
            if (_currentController != null && _currentController!.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _currentController!.value.size.width,
                    height: _currentController!.value.size.height,
                    child: VideoPlayer(_currentController!),
                  ),
                ),
              ),
            if (start)
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    "Tocca per continuare",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
            if (!start)
              const Center(
                child: Text(
                  "Animaker",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
