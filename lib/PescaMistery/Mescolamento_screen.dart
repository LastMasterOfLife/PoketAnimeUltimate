import 'package:flutter/material.dart';
import 'package:poketanime/Componets/Animated_Card_Component.dart';
import 'package:poketanime/Componets/Pesca_Component.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';
import 'package:poketanime/PescaMistery/Mescolamento_screen.dart';

class MescolamentoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> pesca;

  const MescolamentoScreen({super.key, required this.pesca});

  @override
  State<MescolamentoScreen> createState() => _MescolamentoScreenState();
}

class _MescolamentoScreenState extends State<MescolamentoScreen> {
  late List<bool> isFlipped;

  @override
  void initState() {
    super.initState();

    // Inizializza lo stato delle carte come non ruotate
    isFlipped = List<bool>.filled(widget.pesca.length, false);

    // Ruota tutte le carte dopo 1.5 secondi
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        isFlipped = List<bool>.filled(widget.pesca.length, true);
      });
    });
  }

  void _onCardTap(int index) {
    setState(() {
      isFlipped[index] = false;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isFlipped = List<bool>.filled(widget.pesca.length, false);
      });
    });


    final String cardId = widget.pesca[index]['id'].toString();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerscaffoldScreen(
            index: 1,
            cardIds: [cardId],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: widget.pesca.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _onCardTap(index),
                child: AnimatedCardComponent(
                  isFlipped: isFlipped[index],
                  frontWidget: CartaComponent(carta: widget.pesca[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
/*
class AnimatedCard extends StatelessWidget {
  final bool isFlipped;
  final Widget frontWidget;

  const AnimatedCard({
    Key? key,
    required this.isFlipped,
    required this.frontWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: isFlipped ? 1 : 0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        final angle = value * 3.1416; // Ruota di 180°
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(angle),
          child: value < 0.5
              ? frontWidget // Mostra il fronte
              : Container(
            decoration: const BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Center(
              child: Text(""),
            ),
          ),
        );
      },
    );
  }
}

 */
