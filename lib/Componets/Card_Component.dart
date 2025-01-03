import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class CardComponent extends StatefulWidget {
  final Map<String, dynamic> card;
  const CardComponent({super.key, required this.card});

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {

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
    if (widget.card['type'] == 'Comune') {
      return Tilt(
        child: Container(
          width: 300,
          height: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage(buildBorder(widget.card['type'])),fit: BoxFit.cover),
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
                      widget.card['image'],
                      fit: BoxFit.cover,
                    ),
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
          image: DecorationImage(image: AssetImage(buildBorder(widget.card['type'])),fit: BoxFit.cover),
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
                    widget.card['image'],
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
                      widget.card['character'],
                      fit: BoxFit.contain,
                      scale: 0.10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
