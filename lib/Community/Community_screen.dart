import 'dart:math';
import 'package:flutter/material.dart';
import 'package:poketanime/Componets/Neu_box.dart';
import 'package:poketanime/colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('C O M M U N I T Y')),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.65,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Sfondi/amin.jpg'),
                fit: BoxFit.cover
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.15,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                Expanded(
                    child: NeuBox(
                        child: SizedBox(
                          height: 50,
                            child: Center(child: Text('Amici'))
                        )
                    )
                ),
                SizedBox(width: 40,),
                Expanded(
                    child: NeuBox(
                        child: SizedBox(
                          height: 50,
                            child: Center(child: Text('Scambi'))
                        )
                    )
                ),
                SizedBox(width: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
