import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poketanime/Componets/Mission_component.dart';
import 'package:poketanime/colors.dart'; // Assicurati che il nome sia corretto
import 'dart:convert';
class GiornaliereScreen extends StatefulWidget {
  const GiornaliereScreen({super.key});

  @override
  State<GiornaliereScreen> createState() => _GiornaliereScreenState();
}

class _GiornaliereScreenState extends State<GiornaliereScreen> {
  List<Map<String, String>> missions = [];
  List<bool> hiddenFlags = [];
  double _progress = 0.01;
  bool block = false; // block = false  ancora da completare
  int tapCount = 0;

  @override
  void initState() {
    super.initState();
    fetchMissions();
  }

  void _updateProgress() {
    setState(() {
      if (_progress < 1.0) {
        _progress += 0.2;
        if (_progress > 1.0) {
          _progress = 1.0;
        }
      }
    });
  }

  Future<void> fetchMissions() async {
    final url = Uri.parse('https://mocki.io/v1/449ef0a3-60a5-4ab4-82b4-11cd6f3eca5d');
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
                  image: AssetImage('assets/Sfondi/sky_giornaliere.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.grey[300],
                        color: quaternario,
                        minHeight: 10,
                      ),
                    ),
                  ),
                ],
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
                  'Non ci sono più missioni!',
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
                            _updateProgress();
                          });
                        }
                      },
                      child: MissionComponent(
                        title: mission['title']!,
                        descrizione: mission['descrizione']!,
                        block: block,
                        index: 0,
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
