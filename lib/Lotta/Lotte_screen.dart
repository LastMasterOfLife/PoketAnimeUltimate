import 'package:flutter/material.dart';

class LotteScreen extends StatefulWidget {
  const LotteScreen({super.key});

  @override
  State<LotteScreen> createState() => _LotteScreenState();
}

class _LotteScreenState extends State<LotteScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 150,),
        Center(
          child: Text('Lotte',style: TextStyle(fontSize: 50),),
        )
      ],
    );
  }
}
