import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:poketanime/Componets/Pesca_Component.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poketanime/PescaMistery/Mescolamento_screen.dart';

import '../Services/ApiPoint/ListAPI.dart';

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
  }


  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _caricaCarte() async {
    for (int i = 0; i < 5; i++) {
      try {
        final response = await http.get(Uri.parse(mysteryPackDS));
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
                  "image": carta['Immagine_sfondo'] ?? "https://via.placeholder.com/150",
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
