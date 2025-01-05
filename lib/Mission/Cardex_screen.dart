import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Componets/Mission_component.dart';
import 'package:http/http.dart' as http;

class CardexScreen extends StatefulWidget {
  const CardexScreen({super.key});

  @override
  State<CardexScreen> createState() => _CardexScreenState();
}

class _CardexScreenState extends State<CardexScreen> {
  List<Map<String, String>> missions = [];
  List<bool> hiddenFlags = [];
  bool block = false; // bl     ock = false  ancora da completare
  int tapCount = 0;

  @override
  void initState() {
    super.initState();
    fetchMissions();
  }


  Future<void> fetchMissions() async {
    final url = Uri.parse('https://mocki.io/v1/f2bfd528-17d7-4070-87af-217fcdf7f0ff');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['mission'] != null && data['mission'] is List) {
          setState(() {
            missions = (data['mission'] as List<dynamic>)
                .map((item) => {
              'title': item['title'] as String,
              'descrizione': item['Descrizione'] as String,
              'riconpensa': item['riconpensa'] as String,
              'num': item['num'] as String
            })
                .toList();
            hiddenFlags = List<bool>.filled(missions.length, false);
          });
        } else {
          print('La chiave "mission" è mancante o non è una lista.');
        }
      } else {
        throw Exception('Errore nel caricamento dei dati: ${response.statusCode}');
      }
    } catch (e) {
      print('Errore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Sfondi/sky_g.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(child: Text('tempo')),
            ),
            Expanded(
              child: tapCount >= missions.length
                  ? const Center(
                child: Text(
                  'Non ci sono più missioni Cardex!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              )
                  : missions.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: missions.length,
                itemBuilder: (context, index) {
                  if (hiddenFlags[index]) return const SizedBox.shrink();
                  final mission = missions[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: !block
                          ? null
                          : () {
                        if (!hiddenFlags[index]) {
                          setState(() {
                            hiddenFlags[index] = true;
                            tapCount++;
                          });
                        }
                      },
                      child: MissionComponent(
                        title: mission['title']!,
                        descrizione: mission['descrizione']!,
                        block: block,
                        index: 1,
                        riconpensa: mission['riconpensa'],
                        num: mission['num'],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
