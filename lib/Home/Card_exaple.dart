import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class CardExample extends StatefulWidget {
  const CardExample({super.key});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {

  int cardRarity = 4; // da 1 a 5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Center(
            child: Container(
              width: 300,
              height: 300,
              child: Tilt(
                borderRadius: BorderRadius.circular(5),
                tiltConfig: const TiltConfig(angle: 15),
                lightConfig: const LightConfig(
                  minIntensity: 0.1,
                ),
                shadowConfig: const ShadowConfig(
                  minIntensity: 0.05,
                  maxIntensity: 0.4,
                  offsetFactor: 0.08,
                  minBlurRadius: 10,
                  maxBlurRadius: 15,
                ),
                childLayout: ChildLayout(outer: [
                  Positioned(
                    top: -40,
                    child: TiltParallax(
                      size: const Offset(-20, -20),
                      child: Image.asset(
                        'assets/KaisenPack/cards/comune/characters/gojo_card_personaggio.png',scale: 2,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 70,
                    child: TiltParallax(
                      size: const Offset(25, 25),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: FloatingActionButton(
                          onPressed: () {},
                          elevation: 0.0,
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ]),
                child: Image.asset('assets/KaisenPack/cards/comune/backgrounds/gojo_card.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              color: const Color(0xD3FFFFFF),
              borderRadius: BorderRadius.circular(30),
              shape: BoxShape.rectangle,
              border: Border.all(color: const Color(0xFF7AB0ED), width: 2),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Gojo Satoru',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cardRarity,
                        (index) => const Icon(
                      Icons.star_border,
                      color: Colors.yellow,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Center(
                    child: Text('Si pensa Sia il personaggio \n più forte dell\'intero anime', style: TextStyle(fontSize: 15),)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
