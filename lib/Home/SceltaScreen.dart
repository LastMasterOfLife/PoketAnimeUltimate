import 'dart:math';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Home/Card_Visual.dart';
import 'package:poketanime/Home/Card_exaple.dart';
import 'package:poketanime/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Sceltascreen extends StatefulWidget {
  const Sceltascreen({super.key});

  @override
  State<Sceltascreen> createState() => _SceltascreenState();
}

class _SceltascreenState extends State<Sceltascreen> {
  final List<Map<String, String>> objects = [
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
  ];


  int _currentIndex = 6; // Traccia l'indice corrente della slide

   List<Map<String,String>> generate(List<Map<String, String>> card) {

    final random = Random();
    final selectedCards = <Map<String, String>>{};

    // Continua a selezionare elementi finché non ne hai 3 unici
    while (selectedCards.length < 3) {
      int randomIndex = random.nextInt(card.length);
      selectedCards.add(card[randomIndex]);
    }

    return selectedCards.toList();
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //image: DecorationImage(image: AssetImage('assets/Sfondi/sfondo_pachetto.png')),
          color: Color(0xFFCEC1FE),
        ),
          child: Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                    initialPage: 6,
                    viewportFraction: 0.4,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: objects.map((object) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) => CardVisual()));
                                },
                                child: Image.asset(
                                  object['fileName']!,
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                  const Center(
                                    child:
                                    Icon(Icons.error, color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          )
      ),
    );
  }
}
