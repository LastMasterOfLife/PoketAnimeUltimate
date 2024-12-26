import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:http/http.dart' as http;
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Home/RiassuntoSpaccettamento_screen.dart';

class CardVisual extends StatefulWidget {
  const CardVisual({super.key});

  @override
  State<CardVisual> createState() => _CardVisualState();
}

class _CardVisualState extends State<CardVisual> {
  List<Map<String, dynamic>> cards = [];
  late List<bool> visibility;

  Future<void> fetchCards() async {
    final url = Uri.parse('https://mocki.io/v1/0bb0c579-882e-4d78-96c6-c009179e2e13');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        final cardsList = data['cards'] as List<dynamic>;
        cardsList.shuffle();
        cards = cardsList.take(4).map((item) {
          return {
            'id': item['Id'] ?? '',
            'fileName': item['Nome'] ?? '',
            'description': item['Descrizione'] ?? '',
            'background': item['Immagine_sfondo'] ?? '',
            'character': item['Immagine_personaggio'] ?? '',
            'abilities': item['abilities'] ?? '',
            'attack': item['attack'] ?? '',
            'defense': item['defense'] ?? '',
            'speed': item['speed'] ?? '',
            'energy': item['energy'] ?? '',
          };
        }).toList();
        visibility = List<bool>.filled(cards.length, true);
      });
    } else {
      throw Exception('Errore nel recupero delle carte');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty || visibility == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Invertiamo l'ordine solo per la visualizzazione
    final reversedCards = List.from(cards.reversed);
    final reversedVisibility = List.from(visibility.reversed);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Tilt(
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(reversedCards.length, (uiIndex) {
              final logicalIndex = reversedCards.length - 1 - uiIndex;
              final card = reversedCards[uiIndex];

              return Visibility(
                visible: reversedVisibility[uiIndex],
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      visibility[logicalIndex] = false;
                      if (logicalIndex == cards.length - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiassuntospaccettamentoScreen(cards: cards),
                          ),
                        );
                      }
                    });
                  },
                  child: buildCard(card),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildCard(Map<String, dynamic> card) {
    return Container(
      width: 300,
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Colors.yellow, Colors.orange], // Colori del gradiente
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                  card['background'],
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
                    card['character'],
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
                  card['fileName'], // Nome del personaggio
                  style: TextStyle(
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Abilità: ${card['abilities']}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Attacco: ${card['attack']}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Difesa: ${card['defense']}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Velocità: ${card['speed']}",
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
                  Icon(Icons.bolt, color: Colors.yellow, size: 24),
                  Text(
                    "${card['energy']}",
                    style: TextStyle(
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
    );
  }

}
