
import 'package:flutter/material.dart';

class GiornaliereScreen extends StatefulWidget {
  const GiornaliereScreen({super.key});

  @override
  State<GiornaliereScreen> createState() => _GiornaliereScreenState();
}

class _GiornaliereScreenState extends State<GiornaliereScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
              ),
              Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white
                ),
              ),
              Container(
                height: double.infinity,
              )
            ],
          ),
        ),
      ],
    );
  }
}
