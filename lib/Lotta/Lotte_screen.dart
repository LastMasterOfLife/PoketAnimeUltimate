import 'package:flutter/material.dart';
import 'package:poketanime/Componets/Neu_box.dart';

class LotteScreen extends StatefulWidget {
  const LotteScreen({super.key});

  @override
  State<LotteScreen> createState() => _LotteScreenState();
}

class _LotteScreenState extends State<LotteScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.75,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Sfondi/solo_leveling.jpg'),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
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
                            child: Center(child: Text('Eventi'))
                        )
                    )
                ),
                SizedBox(width: 40,),
                Expanded(
                    child: NeuBox(
                        child: SizedBox(
                            height: 50,
                            child: Center(child: Text('Vs Amici'))
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
