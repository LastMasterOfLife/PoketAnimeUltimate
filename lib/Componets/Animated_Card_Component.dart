import 'package:flutter/material.dart';

class AnimatedCardComponent extends StatelessWidget {
  final bool isFlipped;
  final Widget frontWidget;
  const AnimatedCardComponent({super.key, required this.isFlipped, required this.frontWidget});

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
