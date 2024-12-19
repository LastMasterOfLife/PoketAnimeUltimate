import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Home/HomeScreen.dart';


class SwitchPack extends StatefulWidget {
  const SwitchPack({super.key});

  @override
  State<SwitchPack> createState() => _SwitchPackState();
}

class _SwitchPackState extends State<SwitchPack> {

  final List<Map<String, String>> objects = [
    {'fileName': 'assets/img_pack/mushoku_tensei_pack.jpg'},
    {'fileName': 'assets/img_pack/jiujizu_kaisen_pack.jpg'},
    {'fileName': 'assets/img_pack/demon_slayer_pack.jpg'},
  ];

  int _currentIndex = 1; // Traccia l'indice corrente della slide


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
          decoration: BoxDecoration(
           color: Color(0xFFA1DBF8),
          ),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 0,),
                    Container(
                      width: 100,
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.transparent,
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: Offset(5, 5)
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(15)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 90,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: secondary,
                                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                                  border: Border.all(color: terziario,width: 1)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 40,),
                    Container(
                      decoration: BoxDecoration(
                          color: bianco,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: secondary,width: 2)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Alpha Pack', style: TextStyle(fontSize: 20),),
                      ),
                    ),
                    SizedBox(width: 80,),
                    Container(
                        child: Image.asset('assets/icons/clessidre_icon.png',scale: 18,))
                  ],
                ),
              ),
              SizedBox(height: 10,),
              // Carousel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 440,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  child:  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 255,
                            initialPage: 1,
                            viewportFraction: 0.3,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
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

                                          Navigator.push(context, MaterialPageRoute(builder: (contex) => Homescreen(index: _currentIndex)));
                                          
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
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: terziario.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              height: 70,
                              width: 45,
                            ),
                            SizedBox(width: 20,),
                            Container(
                              decoration: BoxDecoration(
                                  color: terziario.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              height: 70,
                              width: 45,
                            ),
                            SizedBox(width: 20,),
                            Container(
                              decoration: BoxDecoration(
                                  color: terziario.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              height: 70,
                              width: 45,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (contex) => Homescreen(index: _currentIndex)));

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Apri una busta', style: TextStyle(fontSize: 25,color: bianco),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Missioni, Oggetti e Pesca Misteriosa
              Container(
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.transparent
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 160,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent, width: 1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.shade200, // Colore dell'ombra
                            spreadRadius: 2, // Quanto si espande l'ombra
                            blurRadius: 10, // Quanto è sfumata l'ombra
                            offset: Offset(5, 5), // Spostamento dell'ombra
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                  child: Image.asset('assets/icons/mission_icon.png',fit: BoxFit.contain, scale: 6.5,))),
                          Text(
                            'Missioni',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: 160,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent, width: 1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.shade200, // Colore dell'ombra
                            spreadRadius: 2, // Quanto si espande l'ombra
                            blurRadius: 10, // Quanto è sfumata l'ombra
                            offset: Offset(5, 5), // Spostamento dell'ombra
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  'assets/icons/oggetti_icon.png',
                                  fit: BoxFit.contain,
                                  scale: 0.5,
                                ),
                              )),
                          Text(
                            'Oggetti',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: 160,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent, width: 1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.shade200, // Colore dell'ombra
                            spreadRadius: 2, // Quanto si espande l'ombra
                            blurRadius: 10, // Quanto è sfumata l'ombra
                            offset: Offset(5, 5), // Spostamento dell'ombra
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  'assets/icons/cards_icon.png',
                                  fit: BoxFit.contain,
                                  scale: 2.5,
                                ),
                              )),
                          Text(
                            'Pesca misteriosa',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
      )
    );
  }
}
