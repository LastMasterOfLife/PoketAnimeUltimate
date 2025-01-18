import 'dart:convert'; // Per lavorare con JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Componets/Card_Detail_Component.dart';

class CardExample extends StatefulWidget {
  final int index;
  final int? pack;

  const CardExample({super.key, required this.index, required this.pack});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  late Future<Map<String, dynamic>> cardData;

  @override
  void initState() {
    super.initState();
    smistamento(widget.pack);
    cardData = fetchCardData(widget.index,smistamento(widget.pack));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final card = await cardData;
        if (mounted) {
          showCardModal(card);
        }
      } catch (e) {
        // Gestione dell'errore durante il caricamento della modale
        debugPrint("Errore durante la visualizzazione della modale: $e");
      }
    });
  }

  String smistamento(int? index){
    var URL = "https://mocki.io/v1/f2bfd528-17d7-4070-87af-217fcdf7f0ff";
    switch(index) {
      case 0:
        URL = "";
        break;
      case 1:
        URL = "https://mocki.io/v1/f2bfd528-17d7-4070-87af-217fcdf7f0ff";
        break;
      case 2:
        URL = "https://mocki.io/v1/1a3e18b7-8c0a-4d4a-bb2f-2273f388994c";
        break;
      default:
    }
    debugPrint("index: $index");
    debugPrint("URL selezionato: $URL");
    return URL;
  }

  // Funzione per ottenere i dati della carta specifica
  Future<Map<String, dynamic>> fetchCardData(int id,String apiUrl) async {
    //const String apiUrl = "https://mocki.io/v1/f2bfd528-17d7-4070-87af-217fcdf7f0ff";
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

  void showCardModal(Map<String, dynamic> card) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.1,
        maxChildSize: 0.8,
        builder: (_, controller) => Container(
          decoration:  BoxDecoration(
            color: primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.symmetric(horizontal: BorderSide(color: Colors.blue.shade900, width: 5))
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    card['Nome'] ?? 'Sconosciuto',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildStars(card['Rarita'] ?? ''),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Descrizione: ${card['Descrizione'] ?? ''}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Abilità: ${card['abilities'] ?? ''}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Attacco: ${card['attack'] ?? ''}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Difesa: ${card['defense'] ?? ''}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Velocità: ${card['speed'] ?? ''}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
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


                ],
              ),
            ),
          ),
        ),
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
          return Stack(
            children: [
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: CardDetailComponent(card: card),
                ),
              ),
              Positioned(
                bottom: 1,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    try {
                      final card = await cardData;
                      if (mounted) {
                        showCardModal(card);
                      }
                    } catch (e) {
                      debugPrint("Errore durante il caricamento della modale: $e");
                    }
                  },
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.9),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                      ),
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.blue.shade900,width: 5))
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Mostra Dettagli",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
