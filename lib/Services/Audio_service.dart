import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playBackgroundMusic(String audioUrl) async {
    try {
      // Carica e avvia la musica
      await _audioPlayer.setUrl(audioUrl);
      _audioPlayer.setLoopMode(LoopMode.all); // Imposta la musica in loop
      _audioPlayer.play();
    } catch (e) {
      print('Errore nel caricamento della musica: $e');
    }
  }

  static Future<void> stopBackgroundMusic() async {
    await _audioPlayer.stop();
  }
}