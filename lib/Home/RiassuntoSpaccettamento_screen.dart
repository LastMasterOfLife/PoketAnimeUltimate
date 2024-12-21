import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:poketanime/Collection/Collection_Screen.dart';

class RiassuntospaccettamentoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cards;

  const RiassuntospaccettamentoScreen({super.key, required this.cards});

  @override
  State<RiassuntospaccettamentoScreen> createState() =>
      _RiassuntospaccettamentoScreenState();
}

class _RiassuntospaccettamentoScreenState
    extends State<RiassuntospaccettamentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riassunto Spaccettamento'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Estrai gli ID delle carte e naviga alla nuova pagina
          final cardIds = widget.cards.map((card) => card['id']).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectionScreen(cardIds: cardIds),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}