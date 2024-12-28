import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  late final bool isMenuOverlayVisible;
  MenuScreen({super.key, required this.isMenuOverlayVisible});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Sfondo trasparente per rilevare il tap fuori
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isMenuOverlayVisible = false; // Nascondi il menu
            });
          },
          child: Container(
            color: Colors.black.withOpacity(0.5), // Sfondo semitrasparente
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {}, // Evita che il tap dentro il rettangolo nasconda il menu
            child: Container(
              width: 250,
              height: double.infinity,
              margin: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Opzione 1"),
                    onTap: () {
                      // Azione per Opzione 1
                      setState(() {
                        widget.isMenuOverlayVisible = false; // Nascondi il menu
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Opzione 2"),
                    onTap: () {
                      // Azione per Opzione 2
                      setState(() {
                        widget.isMenuOverlayVisible = false; // Nascondi il menu
                      });
                    },
                  ),
                  // Aggiungi altre opzioni qui
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
