import 'package:flutter/material.dart';
import 'package:poketanime/Componets/Card_Component.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiassuntospaccettamentoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cards;
  final int pack;

  const RiassuntospaccettamentoScreen({super.key, required this.cards, required this.pack});

  @override
  State<RiassuntospaccettamentoScreen> createState() =>
      _RiassuntospaccettamentoScreenState();
}

class _RiassuntospaccettamentoScreenState extends State<RiassuntospaccettamentoScreen> {

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveCardIds() async {
    final cardIds = widget.cards.map<String>((card) {
      var id = card['id'];
      return id is int ? id.toString() : id;
    }).toList();

    await prefs.setStringList('savedCardIds', cardIds);
  }



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
          final cardIds = widget.cards.map<String>((card) {
            var id = card['id'];
            return id is int ? id.toString() : id;
          }).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerscaffoldScreen(cardIds: cardIds,index: 1,pack: widget.pack,),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
