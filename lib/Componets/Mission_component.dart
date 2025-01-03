import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';

class MissionComponent extends StatefulWidget {
  final String title;
  final String descrizione;

  const MissionComponent({super.key, required this.title, required this.descrizione});

  @override
  State<MissionComponent> createState() => _MissionComponentState();
}

class _MissionComponentState extends State<MissionComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
              colors: [terziario,quaternario],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
          border: Border.all(color: bianco,width: 2)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 95,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondary,
                  border: Border.all(color: bianco,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(widget.descrizione)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

