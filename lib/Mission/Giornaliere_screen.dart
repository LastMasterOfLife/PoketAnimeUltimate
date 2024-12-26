
import 'package:flutter/material.dart';
import 'package:poketanime/Componets/Neu_box.dart';

class GiornaliereScreen extends StatefulWidget {
  const GiornaliereScreen({super.key});

  @override
  State<GiornaliereScreen> createState() => _GiornaliereScreenState();
}

class _GiornaliereScreenState extends State<GiornaliereScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/Sfondi/sky_g.jpg'),fit: BoxFit.cover)
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Center(child: Text('tempo')),
            )
          ],
        )
      ),
    );
  }
}
