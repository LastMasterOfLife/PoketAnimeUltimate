import 'package:flutter/material.dart';
import 'package:poketanime/Componets/Card_Component.dart';

class PescaComponent extends StatelessWidget {
  final List<Map<String, dynamic>> carte;

  PescaComponent({required this.carte});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pescata #${DateTime.now().millisecondsSinceEpoch}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: carte.length,
              itemBuilder: (context, index) {
                return CartaComponent(carta: carte[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CartaComponent extends StatelessWidget {
  final Map<String, dynamic> carta;

  CartaComponent({required this.carta});

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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CardComponent( card: carta),
    );
  }
}
