import 'dart:convert'; // Per lavorare con JSON
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:http/http.dart' as http;

class CardExample extends StatefulWidget {
  final int index; // Id della carta
  const CardExample({super.key, required this.index});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  late Future<Map<String, dynamic>> cardData;

  @override
  void initState() {
    super.initState();
    cardData = fetchCardData(widget.index);
  }

  // Funzione per ottenere i dati della carta specifica
  Future<Map<String, dynamic>> fetchCardData(int id) async {
    const String apiUrl = "https://mocki.io/v1/0bb0c579-882e-4d78-96c6-c009179e2e13";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final cards = data['cards'] as List;
      return cards.firstWhere((card) => card['Id'] == id, orElse: () => throw Exception("Carta non trovata"));
    } else {
      throw Exception("Errore durante la richiesta: ${response.statusCode}");
    }
  }

  // Funzione per generare le stelle in base alla rarità
  List<Widget> buildStars(String rarita) {
    int starCount = 0;

    switch (rarita) {
      case "Comune":
        starCount = 1; // Una stella
        break;
      case "Rara":
        starCount = 3; // Tre stelle
        break;
      case "Speciale":
        starCount = 5; // Cinque stelle
        break;
      default:
        starCount = 0; // Nessuna stella per rarità sconosciuta
    }

    return List.generate(
      starCount,
          (index) => const Icon(
        Icons.star,
        color: Colors.amber,
        size: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli Carta'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: cardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Errore: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Nessun dato trovato"));
          }

          final card = snapshot.data!;
          return Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  child: Tilt(
                    borderRadius: BorderRadius.circular(5),
                    tiltConfig: const TiltConfig(angle: 15),
                    lightConfig: const LightConfig(
                      minIntensity: 0.1,
                    ),
                    shadowConfig: const ShadowConfig(
                      minIntensity: 0.05,
                      maxIntensity: 0.4,
                      offsetFactor: 0.08,
                      minBlurRadius: 10,
                      maxBlurRadius: 15,
                    ),
                    childLayout: ChildLayout(outer: [
                      Positioned(
                          top: -40,
                          child: TiltParallax(
                              size: const Offset(-20, -20),
                              child: Image.asset(card['Immagine_personaggio'],scale: 2,))),

                    ]),
                    child: Image.asset(card['Immagine_sfondo']),
                  ),
                ),
              ),
              // Nome
              Text(
                card['Nome'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 10),
              // Rarità con stelle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildStars(card['Rarita']),
              ),
              const SizedBox(height: 10),
              // Descrizione
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  card['Descrizione'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
