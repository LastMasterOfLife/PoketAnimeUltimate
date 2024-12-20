
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class RiassuntospaccettamentoScreen extends StatefulWidget {

  final List<Map<String, dynamic>> cards;
  const RiassuntospaccettamentoScreen({super.key, required this.cards});

  @override
  State<RiassuntospaccettamentoScreen> createState() => _RiassuntospaccettamentoScreenState();
}

class _RiassuntospaccettamentoScreenState extends State<RiassuntospaccettamentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuova Schermata'),
      ),
      body: ListView.builder(
        itemCount: widget.cards.length,
        itemBuilder: (context, index) {
          final card = widget.cards[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(card['fileName']),
              subtitle: Text(card['description']),
              leading: Image.asset(card['character']),
              trailing: Image.asset(card['background']),
            ),
          );
        },
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
