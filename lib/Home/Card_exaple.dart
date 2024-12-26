import 'dart:convert'; // Per lavorare con JSON
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:http/http.dart' as http;

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


  List<Widget> buildStars(String rarita) {
    int starCount = 0;

    switch (rarita) {
      case "Comune":
        starCount = 1;
        break;
      case "Rara":
        starCount = 3;
        break;
      case "Speciale":
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
                child: buildCard(card),
              ),
              // Nome
              Text(
                card['Nome'] ?? 'Sconosciuto',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 10),
              // Rarità con stelle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildStars(card['Rarita'] ?? ''),
              ),
              const SizedBox(height: 10),
              // Descrizione
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  card['Descrizione'] ?? '',
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

  Widget buildCard(Map<String, dynamic> card) {
    return Tilt(
      child: Container(
        width: 300,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(image: AssetImage('assets/Border/comune.jpg'),fit: BoxFit.cover),
          /*
          gradient: const LinearGradient(
            colors: [Colors.yellow, Colors.orange], // Colori del gradiente
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      
           */
        ),
        child: Container(
          margin: const EdgeInsets.all(10), // Spazio per il bordo
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              // Sfondo della carta
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    card['Immagine_sfondo'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Immagine del personaggio
              Positioned(
                top: 20,
                left: 50,
                right: 50,
                bottom: 20,
                child: TiltParallax(
                  size: const Offset(20, 20),
                  child: Container(
                    child: Image.asset(
                      card['Immagine_personaggio'] ?? '',
                      fit: BoxFit.contain,
                      scale: 4.5,
                    ),
                  ),
                ),
              ),
              // Nome del personaggio
              Positioned(
                top: 10,
                left: 15,
                right: 15,
                child: Center(
                  child: Text(
                    card['Nome'] ?? '', // Nome del personaggio
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          color: Colors.black,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Statistiche
              Positioned(
                bottom: 40,
                left: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Abilità: ${card['abilities'] ?? ''}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Attacco: ${card['attack'] ?? ''}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Difesa: ${card['defense'] ?? ''}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Velocità: ${card['speed'] ?? ''}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              // Energia in basso
              Positioned(
                bottom: 10,
                right: 15,
                child: Row(
                  children: [
                    const Icon(Icons.bolt, color: Colors.yellow, size: 24),
                    Text(
                      "${card['energy'] ?? ''}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
