import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Mission/Cardex_screen.dart';
import 'package:poketanime/Mission/Giornaliere_screen.dart';

class CustomerscaffoldMissionScreen extends StatefulWidget {
  const CustomerscaffoldMissionScreen({super.key});

  @override
  State<CustomerscaffoldMissionScreen> createState() =>
      _CustomerscaffoldMissionScreenState();
}

class _CustomerscaffoldMissionScreenState
    extends State<CustomerscaffoldMissionScreen> {
  int selectedIndex = 0;
  bool gionaliero = true;
  bool cardex = false;
  bool emblema = false;
  bool premium = false;

  @override
  void initState() {
    super.initState();
     selectedIndex = 0;
     gionaliero = true;
     cardex = false;
     emblema = false;
     premium = false;
  }

  final List<Widget> pages = [
    GiornaliereScreen(),
    CardexScreen(),
    Center(child: Text("Pagina 3", style: TextStyle(fontSize: 24))),
    Center(child: Text("Pagina 4", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height: 670,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.blue),
            child: pages[selectedIndex],
          ),
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                          if (!gionaliero) {
                            gionaliero = !gionaliero;
                          }
                          cardex = false;
                          emblema = false;
                          premium = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gionaliero ? terziario.withOpacity(0.9) : Colors.white,
                        elevation: 8,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Giornaliere'),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                          if (!cardex) {
                            cardex = !cardex;
                          }
                          gionaliero = false;
                          emblema = false;
                          premium  = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: cardex ? terziario.withOpacity(0.9) : Colors.white,
                          elevation: 8
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cardex'),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                          if (!emblema) {
                            emblema = !emblema;
                          }
                          gionaliero = false;
                          cardex = false;
                          premium  = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: emblema ? terziario.withOpacity(0.9) : Colors.white,
                          elevation: 8
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Emblema'),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = 3;
                          if (!premium) {
                            premium = !premium;
                          }
                          gionaliero = false;
                          cardex = false;
                          emblema  = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: premium ? Colors.orangeAccent.withOpacity(1) : Colors.white,
                          elevation: 8
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Premium'),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.3),
                                offset: const Offset(3, 3),
                                blurRadius: 7,
                                spreadRadius: 1)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          size: 50,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
