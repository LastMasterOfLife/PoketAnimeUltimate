import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:poketanime/Componets/Pesca_Component.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poketanime/PescaMistery/Mescolamento_screen.dart';

class PescaMisteriosaScreen extends StatefulWidget {
  @override
  _PescaMisteriosaScreenState createState() => _PescaMisteriosaScreenState();
}

class _PescaMisteriosaScreenState extends State<PescaMisteriosaScreen> {
  List<List<Map<String, dynamic>>> listaPescate = [];
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _caricaCarte();
    //_init();
  }

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

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _caricaCarte() async {
    for (int i = 0; i < 5; i++) {
      try {
        final response = await http.get(Uri.parse('https://mocki.io/v1/f2bfd528-17d7-4070-87af-217fcdf7f0ff'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> cardsList = data['cards'] ?? [];
          cardsList.shuffle();

          setState(() {
            listaPescate.add(
              cardsList.take(4).map((carta) {
                return {
                  "id" : carta['Id'] ?? "",
                  "name": carta['Nome'] ?? "Nome sconosciuto",
                  "image": carta['Immagine_sfondo'] ?? "https://via.placeholder.com/150", // Placeholder image
                  "type": carta['Rarita'] ?? "Comune",
                  'character': carta['Immagine_personaggio'] ?? '',
                  'abilities': carta['abilities'] ?? '',
                  'attack': carta['attack'] ?? '',
                  'defense': carta['defense'] ?? '',
                  'speed': carta['speed'] ?? '',
                  'energy': carta['energy'] ?? '',
                };
              }).toList(),
            );
          });
        } else {
          throw Exception('Errore nel recupero delle carte: ${response.statusCode}');
        }
      } catch (e) {
        print("Errore: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesca misteriosa"),
      ),
      body: ListView.builder(
        itemCount: listaPescate.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MescolamentoScreen(pesca: listaPescate[index])));
            },
              child: PescaComponent(carte: listaPescate[index]));
        },
      ),
    );
  }
}
