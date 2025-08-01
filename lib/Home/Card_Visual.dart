import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:http/http.dart' as http;
import 'package:poketanime/Home/RiassuntoSpaccettamento_screen.dart';

import '../Services/ApiPoint/ListAPI.dart';

class CardVisual extends StatefulWidget {
  final int index;
  const CardVisual({super.key, required this.index});

  @override
  State<CardVisual> createState() => _CardVisualState();
}

class _CardVisualState extends State<CardVisual> {
  List<Map<String, dynamic>> cards = [];
  late List<bool> visibility;
  String buildBorder(String rarita) {
    String path = "";

    switch (rarita) {
      case "Comune":
        path = "assets/Border/comune.jpg";
        break;
      case "Rara":
        path = "assets/Border/rare.jpg";
        break;
      case "UltraRara":
        path = "assets/Border/gold.jpg";
        break;
      default:
        path = "assets/Border/comune.jpg";
    }

    return path;
  }

  Future<void> fetchCards(int index) async {
    var url = Uri.parse(JujutsuKaisenPack); // Default URL Jujutsu Kaisen

    switch(index) {
      case 0: // Mushoku Tensei
        url = Uri.parse('');
        break;
      case 1: // Jujutsu Kaisen
        url = Uri.parse(JujutsuKaisenPack);
        break;
      case 2: // Demon Slayer
        url = Uri.parse(DemonSlayerPack);
        break;
      default:
    }

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
            'Rarety': item['Rarita'] ?? '',
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
    fetchCards(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty || visibility == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
                            builder: (context) => RiassuntospaccettamentoScreen(cards: cards,pack: widget.index,),
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
    if (card['Rarety'] == 'Comune') {
      return Tilt(
        child: Container(
          width: 300,
          height: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(buildBorder(card['Rarety'])),fit: BoxFit.cover),
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
                Positioned(
                  top: 10,
                  left: 15,
                  right: 15,
                  child: Center(
                    child: Text(
                      card['fileName'],
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
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Attacco: ${card['attack']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Difesa: ${card['defense']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Velocità: ${card['speed']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 15,
                  child: Row(
                    children: [
                      const Icon(Icons.bolt, color: Colors.yellow, size: 24),
                      Text(
                        "${card['energy']}",
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
    return Tilt(
      child: Container(
        width: 300,
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: AssetImage(buildBorder(card['Rarety'])),fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.all(10), // Spazio per il bordo
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    card['background'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: TiltParallax(
                  size: const Offset(20, 20),
                  child: Container(
                    child: Image.asset(
                      card['character'],
                      scale: 0.05,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 15,
                right: 15,
                child: Center(
                  child: Text(
                    card['fileName'],
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
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Attacco: ${card['attack']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Difesa: ${card['defense']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Velocità: ${card['speed']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 15,
                child: Row(
                  children: [
                    const Icon(Icons.bolt, color: Colors.yellow, size: 24),
                    Text(
                      "${card['energy']}",
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
