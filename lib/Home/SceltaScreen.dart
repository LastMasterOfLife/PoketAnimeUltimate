import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Home/Card_Visual.dart';
import 'package:poketanime/Home/Card_exaple.dart';
import 'package:poketanime/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Sceltascreen extends StatefulWidget {

  final int index;
  const Sceltascreen({super.key, required this.index});

  @override
  State<Sceltascreen> createState() => _SceltascreenState();
}

class _SceltascreenState extends State<Sceltascreen> {
   List<Map<String, dynamic>> objects = [
     /*
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

      */
  ];

   @override
  void initState() {
    super.initState();
    scelta(widget.index);
  }

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


   void scelta(int index) {
     switch (index) {
       case 0:
         for (int i = 0; i < 20; i++) {
           objects.add({'fileName': 'assets/img_pack/mushoku_tensei_pack.jpg'});
         }
         break;
       case 1:
         for (int i = 0; i < 20; i++) {
           objects.add({'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'});
         }
         break;
       case 2:
         for (int i = 0; i < 20; i++) {
           objects.add({'fileName': 'assets/img_pack/demon_slayer_pack.jpg'});
         }
         break;
       default:
         for (int i = 0; i < 20; i++) {
           objects.add({'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'});
         }
         break;
     }
   }


   @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                                          builder: (contex) => CardVisual(index: widget.index,)));
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
