import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Componets/Neu_box.dart';
import 'package:poketanime/Home/HomeScreen.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_Mission_screen.dart';
import 'package:poketanime/PescaMistery/Pesca_Misterriosa_screen.dart';
import 'package:poketanime/Vetrina/Vetrina_screen.dart';

class SwitchPack extends StatefulWidget {
  const SwitchPack({super.key});

  @override
  State<SwitchPack> createState() => _SwitchPackState();
}

class _SwitchPackState extends State<SwitchPack> {
   List<Map<String, dynamic>> objects = [];


  Future<void> fetchCards() async {
    final url = Uri.parse('https://mocki.io/v1/e331d864-b3ed-4c52-b5fc-a5cd044b823a');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        final cardsList = data['pack'] as List<dynamic>;
        objects = cardsList.take(100).map((item) {
          return {
            'id': item['Id'] ?? '',
            'path': item['path'] ?? '',
          };
        }).toList();
      });
    } else {
      throw Exception('Errore nel recupero delle carte');
    }
  }

  int _currentIndex = 1;

  int _seconds = 30;
  late Timer _timer;
  bool _showTimer = true;

  int _seconds2 = 30;
  late Timer _timer2;
  bool _showTimer2 = true;

  int _seconds3 = 30;
  late Timer _timer3;
  bool _showTimer3 = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
    fetchCards();
  }


  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          _showTimer = !_showTimer;
          if (!_showTimer) {
            _startTimer2();
          }  
        }
      });
    });
  }
  void _startTimer2() {
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds2--;
        if (_seconds2 == 0) {
          _showTimer2 = !_showTimer2;
          _timer2.cancel();
          if (!_showTimer2) {
            _startTimer3();
          }  
        }
      });
    });
  }
  void _startTimer3() {
    _timer3 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds3--;
        if (_seconds3 == 0) {
          _showTimer3 = !_showTimer3;
          if (_seconds3 == 28800) {
            _startTimer();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Sfondi/sfondo_pachetto.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 0,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VetrinaScreen()));
                        },
                        child: Container(
                          width: 100,
                          height: 70,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.transparent,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: Offset(5, 5))
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(15))),
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(2)),
                                      border:
                                          Border.all(color: terziario, width: 1)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: bianco,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: secondary, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.shade200,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Alpha Pack',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Transform.rotate(
                        angle: 18 * pi/180,
                        child: Container(
                            child: Image.asset(
                          'assets/icons/consumabili/cless_icon.png',
                          scale: 10,
                        )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 445,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 255,
                              initialPage: 1,
                              viewportFraction: 0.3,
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (contex) => Homescreen(index: _currentIndex),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          object['path']!,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) => const Center(
                                            child: Icon(Icons.error, color: Colors.red),
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
                          decoration: const BoxDecoration(color: Colors.transparent),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedBorder(
                                color:  _showTimer ? Colors.grey.shade400 : nero,
                                strokeWidth: 1,
                                dashPattern: _showTimer ? [2,4] : [100,0], // lunghezza, spazio
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5),
                                child: Container(
                                  height: 70,
                                  width: 45,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: _showTimer
                                              ? Colors.grey.shade400.withOpacity(0.6) // Colore grigio con opacità quando il timer è attivo
                                              : null, // Nessun colore se non visibile
                                          gradient: !_showTimer
                                              ? LinearGradient(
                                            colors: [
                                              Colors.purpleAccent.shade100, // Viola chiaro
                                              Colors.lightBlueAccent.shade100, // Azzurrino
                                            ],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          )
                                              : null, // Nessun gradiente quando il timer è attivo
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: _showTimer
                                            ? Center(child: Text('$_seconds')) : Center(child: Image.asset('assets/icons/benda_icon.png',fit: BoxFit.contain,width: 40,height: 40,)),
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 5,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: _showTimer
                                                ? Colors.grey.shade400.withOpacity(0.6) // Colore grigio con opacità quando il timer è attivo
                                                : null, // Nessun colore se non visibile
                                            gradient: !_showTimer
                                                ? LinearGradient(
                                              colors: [
                                                Colors.purpleAccent.shade100, // Viola chiaro
                                                Colors.lightBlueAccent.shade100, // Azzurrino
                                              ],
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                            )
                                                : null,
                                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              DottedBorder(
                                color:  _showTimer2 ? Colors.grey.shade400 : nero,
                                strokeWidth: 1,
                                dashPattern: _showTimer2 ? [2,4] : [100,0], // lunghezza, spazio
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(5),
                                child: Container(
                                  height: 70,
                                  width: 45,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: _showTimer2
                                              ? Colors.grey.shade400.withOpacity(0.6) // Colore grigio con opacità quando il timer è attivo
                                              : null, // Nessun colore se non visibile
                                          gradient: !_showTimer2
                                              ? LinearGradient(
                                            colors: [
                                              Colors.purpleAccent.shade100, // Viola chiaro
                                              Colors.lightBlueAccent.shade100, // Azzurrino
                                            ],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          )
                                              : null, // Nessun gradiente quando il timer è attivo
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: _showTimer2
                                        ? Center(child: Text('$_seconds2')) : Center(child: Image.asset('assets/icons/benda_icon.png',fit: BoxFit.contain,width: 40,height: 40,)),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 5,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: _showTimer2
                                                ? Colors.grey.shade400.withOpacity(0.6) // Colore grigio con opacità quando il timer è attivo
                                                : null, // Nessun colore se non visibile
                                            gradient: !_showTimer2
                                                ? LinearGradient(
                                              colors: [
                                                Colors.purpleAccent.shade100, // Viola chiaro
                                                Colors.lightBlueAccent.shade100, // Azzurrino
                                              ],
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                            )
                                                : null,
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              DottedBorder(
                                color:  _showTimer3 ? Colors.grey.shade400 : nero,
                                strokeWidth: 1,
                                dashPattern: _showTimer3 ? [2,4] : [100,0], // lunghezza, spazio
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5),
                                child: Container(
                                  height: 70,
                                  width: 45,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 13,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: _showTimer3
                                              ? Colors.grey.shade400.withOpacity(0.6) // Colore grigio con opacità quando il timer è attivo
                                              : null, // Nessun colore se non visibile
                                          gradient: !_showTimer3
                                              ? LinearGradient(
                                            colors: [
                                              Colors.purpleAccent.shade100, // Viola chiaro
                                              Colors.lightBlueAccent.shade100, // Azzurrino
                                            ],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          )
                                              : null, // Nessun gradiente quando il timer è attivo
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: _showTimer3
                                            ? Center(child: Text('$_seconds3')) : Center(child: Image.asset('assets/icons/benda_icon.png',fit: BoxFit.contain,width: 40,height: 40,)),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 5,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: _showTimer3
                                                ? Colors.grey.shade400.withOpacity(0.6) // Colore grigio con opacità quando il timer è attivo
                                                : null, // Nessun colore se non visibile
                                            gradient: !_showTimer3
                                                ? LinearGradient(
                                              colors: [
                                                Colors.purpleAccent.shade100, // Viola chiaro
                                                Colors.lightBlueAccent.shade100, // Azzurrino
                                              ],
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                            )
                                                : null,
                                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) =>
                                        Homescreen(index: _currentIndex,active: true,)));
                          },
                          child: Container(
                            decoration:  BoxDecoration(
                                color: primary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: _showTimer || _showTimer2 || _showTimer3 ? Colors.transparent : quaternario,
                                  blurRadius: _showTimer || _showTimer2 || _showTimer3 ? 0 : 8,
                                  spreadRadius: _showTimer || _showTimer2 || _showTimer3 ? 0 : 1
                                )
                              ]
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Apri una busta',
                                style: TextStyle(fontSize: 25, color: bianco),
                              ),
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
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: NeuBox(
                          child: Container(
                            height: 140,
                            width: 110,
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerscaffoldMissionScreen()));
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Image.asset(
                                          color: nero,
                                          'assets/icons/mission_icon.png',
                                          fit: BoxFit.contain,
                                          scale: 6.5,
                                        ))),
                                Text(
                                  'Missioni',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: NeuBox(
                          child: Container(
                            height: 140,
                            width: 110,
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerscaffoldMissionScreen()));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: Image.asset(
                                          color: nero,
                                          'assets/icons/oggetti_icon.png',
                                          fit: BoxFit.contain,
                                          scale: 0.5,
                                        ))),
                                const Text(
                                  'Oggetti',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                    child: NeuBox(
                      child: Container(
                        height: 140,
                        width: 110,
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PescaMisteriosaScreen()));
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Image.asset(
                                      color: nero,
                                      'assets/icons/cards_icon.png',
                                      fit: BoxFit.contain,
                                      scale: 2.5,
                                    ))),
                            const Text(
                              'Pesca misteriosa',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                      const SizedBox(
                        width: 10,
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
