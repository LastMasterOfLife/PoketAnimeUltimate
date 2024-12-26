import 'package:flutter/material.dart';


class NeuBox extends StatelessWidget {
  final Widget child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.6), //Colors.grey.shade500,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(2, 2)
          ),
          BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(-2, -3)
          ),
        ]
      ),
      padding: EdgeInsets.all(5),
      child: child,
    );
  }
}
