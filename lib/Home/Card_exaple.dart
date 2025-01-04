import 'dart:convert'; // Per lavorare con JSON
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:http/http.dart' as http;
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Componets/Card_Detail_Component.dart';

class CardExample extends StatefulWidget {
  final int index;

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
    const String apiUrl =
        "https://mocki.io/v1/e1635e8e-c11a-48a5-b355-51bc60f10a12";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final cards = data['cards'] as List;
        return cards.firstWhere((card) => card['Id'] == id,
            orElse: () => throw Exception("Carta non trovata"));
      } else {
        throw Exception("Errore durante la richiesta: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Errore durante il fetch dei dati: $e");
    }
  }

  List<Widget> buildStars(String rarita) {
    int starCount;
    switch (rarita) {
      case "Comune":
        starCount = 1;
        break;
      case "Rara":
        starCount = 3;
        break;
      case "UltraRara":
        starCount = 5;
        break;
      default:
        starCount = 0;
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

  String buildBorder(String rarita) {
    switch (rarita) {
      case "Comune":
        return "assets/Border/comune.jpg";
      case "Rara":
        return "assets/Border/rare.jpg";
      case "UltraRara":
        return "assets/Border/gold.jpg";
      default:
        return "assets/Border/comune.jpg";
    }
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
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: CardDetailComponent(card: card),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 270,
                  width: 350,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          card['Nome'] ?? 'Sconosciuto',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildStars(card['Rarita'] ?? ''),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: bianco.withOpacity(0.7),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      card['Descrizione'] ?? '',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16,color: grigio),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Text(
                                    "Abilità: ${card['abilities'] ?? ''}",
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold,color: grigio),
                                  ),

                                  const SizedBox(height: 20),

                                  Text("Attacco: ${card['attack'] ?? ''}",
                                      style: const TextStyle(fontSize: 16,color: grigio)),

                                  const SizedBox(height: 20),

                                  Text("Difesa: ${card['defense'] ?? ''}",
                                      style: const TextStyle(fontSize: 16,color: grigio)),

                                  const SizedBox(height: 20),

                                  Text("Velocità: ${card['speed'] ?? ''}",
                                      style: const TextStyle(fontSize: 16 ,color: grigio)),

                                  const SizedBox(height: 20),

                                  Row(
                                    children: [
                                      const Icon(Icons.bolt, color: Colors.yellow, size: 24),
                                      Text(
                                        "${card['energy']}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: grigio,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
