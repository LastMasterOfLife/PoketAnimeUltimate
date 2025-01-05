import 'package:flutter/material.dart';
import 'package:poketanime/Collection/Collection_Screen.dart';
import 'package:poketanime/Componets/Card_Component.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';

class RiassuntospaccettamentoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cards;

  const RiassuntospaccettamentoScreen({super.key, required this.cards});

  @override
  State<RiassuntospaccettamentoScreen> createState() =>
      _RiassuntospaccettamentoScreenState();
}

class _RiassuntospaccettamentoScreenState extends State<RiassuntospaccettamentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riassunto Spaccettamento'),
      ),
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.cards.length,
        itemBuilder: (context, index) {
          final card = widget.cards[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CardComponent( card: card),
            )
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Estrai gli ID delle carte e convertirli a String se sono int
          final cardIds = widget.cards.map<String>((card) {  // Impostato il tipo esplicitamente come String
            var id = card['id'];
            return id is int ? id.toString() : id;  // Converte id a stringa se è un intero
          }).toList();

          // Naviga alla CustomerscaffoldScreen passando cardIds
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerscaffoldScreen(cardIds: cardIds,index: 1),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
