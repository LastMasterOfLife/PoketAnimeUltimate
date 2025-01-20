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
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isMenuOverlayVisible = false;
            });
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
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
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("Opzione 1"),
                    onTap: () {
                      setState(() {
                        widget.isMenuOverlayVisible = false;
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Opzione 2"),
                    onTap: () {
                      // Azione per Opzione 2
                      setState(() {
                        widget.isMenuOverlayVisible = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
