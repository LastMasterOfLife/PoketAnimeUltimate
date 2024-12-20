import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:http/http.dart' as http;

class CardVisual extends StatefulWidget {
  const CardVisual({super.key});

  @override
  State<CardVisual> createState() => _CardVisualState();
}

class _CardVisualState extends State<CardVisual> {
  List<Map<String, dynamic>> cards = [];  // Cambia il tipo in Map<String, dynamic>
  int currentIndex = 0;

  // Recupera i dati delle carte dall'API
  Future<void> fetchCards() async {
    final url = Uri.parse('https://mocki.io/v1/ab2e5e4b-3692-4cb3-b57e-f36839e7e7be');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        // Estrai la lista di carte dalla chiave 'cards'
        final cardsList = data['cards'] as List<dynamic>;
        cards = cardsList.take(4).map((item) {
          return {
            'fileName': item['Nome'] ?? '',
            'description': item['Descrizione'] ?? '',
            'background': item['Immagine_sfondo'] ?? '',
            'character': item['Immagine_personaggio'] ?? '',
          };
        }).toList();
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
    if (cards.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = (currentIndex + 1) % cards.length;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(cards.length, (index) {
          final card = cards[index];
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: index == currentIndex ? 50 : 60 + index * 10,
            left: index == currentIndex ? 20 : 30 + index * 5,
            child: Opacity(
              opacity: index == currentIndex ? 1.0 : 1.0,
              child: buildCard(card, index == currentIndex),
            ),
          );
        }),
      ),
    );
  }

  Widget buildCard(Map<String, dynamic> card, bool isTopCard) {
    return Container(
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
              child: Image.asset(
                card['character'],
                scale: 2,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 70,
            child: TiltParallax(
              size: const Offset(25, 25),
              child: SizedBox(
                width: 48,
                height: 48,
                child: FloatingActionButton(
                  onPressed: () {},
                  elevation: 0.0,
                  child: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        ]),
        child: Image.asset(
          card['background'],
        ),
      ),
    );
  }
}
