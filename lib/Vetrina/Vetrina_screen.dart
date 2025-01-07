import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';

class VetrinaScreen extends StatefulWidget {
  const VetrinaScreen({super.key});

  @override
  State<VetrinaScreen> createState() => _VetrinaScreenState();
}

class _VetrinaScreenState extends State<VetrinaScreen> {
  final List<Map<String, dynamic>> items = [];
  static const double itemHeight = 50.0;
  static const double itemWidth = 30.0;

  final BorderRadius containerBorderRadius = const BorderRadius.all(Radius.circular(15));
  final Border containerBorder = Border.all(color: bianco.withOpacity(0.2), width: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nero.withOpacity(0.3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Center(
            child: Container(
              height: 350,
              width: 250,
              decoration: BoxDecoration(
                color: grigio.withOpacity(1.0),
                borderRadius: containerBorderRadius,
                border: containerBorder,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Prima riga con 3 elementi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) {
                          return Container(
                            height: 200,
                            width: 110,
                            decoration: BoxDecoration(
                              color: grigio.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: containerBorder,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: bianco,
                                size: 40,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 10), // Spaziatura tra le righe
                  
                      // Seconda riga con 3 elementi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) {
                          return Container(
                            height: 200,
                            width: 110,
                            decoration: BoxDecoration(
                              color: grigio.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: containerBorder,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: bianco,
                                size: 40,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 10), // Spaziatura tra le righe
                  
                      // Terza riga con 1 elemento centrale
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 110,
                            decoration: BoxDecoration(
                              color: grigio.withOpacity(0.7),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: containerBorder,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: bianco,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(30),
                            backgroundColor: Colors.white,
                            shadowColor: Colors.blueAccent.withOpacity(1),
                            elevation: 10,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 30,
                            color: grigio,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
