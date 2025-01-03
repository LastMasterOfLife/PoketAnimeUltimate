import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:poketanime/Componets/Mission_component.dart';

class GiornaliereScreen extends StatefulWidget {
  const GiornaliereScreen({super.key});

  @override
  State<GiornaliereScreen> createState() => _GiornaliereScreenState();
}

class _GiornaliereScreenState extends State<GiornaliereScreen> {
  List<Map<String, String>> missions = [];

  @override
  void initState() {
    super.initState();
    fetchMissions();
  }

  Future<void> fetchMissions() async {
    final url = Uri.parse('https://mocki.io/v1/449ef0a3-60a5-4ab4-82b4-11cd6f3eca5d');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Modifica: Controlla la chiave "mission"
        if (data['mission'] != null && data['mission'] is List) {
          setState(() {
            missions = (data['mission'] as List<dynamic>)
                .map((item) => {
              'title': item['title'] as String,
              'descrizione': item['Descrizione'] as String, // Nota: usa "Descrizione"
            })
                .toList();
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
              child: missions.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: missions.length,
                itemBuilder: (context, index) {
                  final mission = missions[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MissionComponent(
                      title: mission['title']!,
                      descrizione: mission['descrizione']!,
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
