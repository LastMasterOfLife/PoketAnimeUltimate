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
    final url = Uri.parse('https://mocki.io/v1/a41e7a76-0694-48ed-8943-2a9dfce772dc');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        final cardsList = data['cards'] as List<dynamic>;
        cardsList.shuffle();
        cards = cardsList.take(4).map((item) {
          return {
            'id' : item['Id'] ?? '',
            'fileName': item['Nome'] ?? '',
            'description': item['Descrizione'] ?? '',
            'background': item['Immagine_sfondo'] ?? '',
            'character': item['Immagine_personaggio'] ?? '',
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

    return Container(
      decoration: BoxDecoration(color: bianco),
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(reversedCards.length, (uiIndex) {
          // Mappiamo l'indice UI (invertito) all'indice logico
          final logicalIndex = reversedCards.length - 1 - uiIndex;
          final card = reversedCards[uiIndex];

          return Visibility(
            visible: reversedVisibility[uiIndex],
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // Aggiorna lo stato usando l'indice logico
                  visibility[logicalIndex] = false;

                  // Naviga alla nuova schermata al tap sull'ultima carta logica
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
    );
  }


  Widget buildCard(Map<String, dynamic> card) {
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
