import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class CardDetailComponent extends StatefulWidget {

  final Map<String, dynamic> card;
  const CardDetailComponent({super.key, required this.card});

  @override
  State<CardDetailComponent> createState() => _CardDetailComponentState();
}

class _CardDetailComponentState extends State<CardDetailComponent> {

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

  @override
  Widget build(BuildContext context) {
    if (widget.card['Rarita'] == 'Comune') {
      return Tilt(
        child: Container(
          width: 300,
          height: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(buildBorder(widget.card['Rarita'])),fit: BoxFit.cover),
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
                      widget.card['Immagine_sfondo'],
                      fit: BoxFit.cover,
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
                      widget.card['Nome'], // Nome del personaggio
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
                          "Abilità: ${widget.card['abilities']}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Attacco: ${widget.card['attack']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Difesa: ${widget.card['defense']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Velocità: ${widget.card['speed']}",
                          style: const TextStyle(fontSize: 16),
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
                        "${widget.card['energy']}",
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
          image: DecorationImage(image: AssetImage(buildBorder(widget.card['Rarita'])),fit: BoxFit.cover),
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
                    widget.card['Immagine_sfondo'],
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
                      widget.card['Immagine_personaggio'],
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
                    widget.card['Nome'], // Nome del personaggio
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
                        "Abilità: ${widget.card['abilities']}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Attacco: ${widget.card['attack']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Difesa: ${widget.card['defense']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Velocità: ${widget.card['speed']}",
                        style: const TextStyle(fontSize: 16),
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
                      "${widget.card['energy']}",
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
