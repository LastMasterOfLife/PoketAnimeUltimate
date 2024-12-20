
import 'package:poketanime/Colors.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_objects/flutter_3d_objects.dart';
import 'package:poketanime/Home/SceltaScreen.dart';
import 'package:vector_math/vector_math_64.dart' as math hide Colors;

class Homescreen extends StatefulWidget {
  final int index;

  const Homescreen({super.key, required this.index});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<Map<String, dynamic>> objects = [
    {
      'fileName': 'assets/pacchetto_Mushoku_Tensei.obj',
      'rotation': math.Vector3(0, -90, 0),
      'scale': math.Vector3(6, 6, 6),
    },
    {
      'fileName': 'assets/3DPack/Jiujizu_Kaisen/pacchetto_Jujutsu_kaisen_castom.obj',
      'rotation': math.Vector3(0, -90, 0),
      'scale': math.Vector3(6, 6, 6),
    },
    {
      'fileName': 'assets/pacchetto_Demon_Slayer.obj',
      'rotation': math.Vector3(0, -90, 0),
      'scale': math.Vector3(6, 6, 6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedObject = objects[widget.index];

    return Scaffold(
      body: Stack(
        children: [
          // Sfondo
          Image(image: AssetImage('assets/Sfondi/sfondo_pachetto.png'), fit: BoxFit.cover, width: double.infinity),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 300,
                      child: Cube(
                        onSceneCreated: (Scene scene) {
                          scene.world.add(
                            Object(
                              fileName: selectedObject['fileName'],
                              position: math.Vector3.zero(),
                              rotation: math.Vector3(0, -90, 0),
                              lighting: true,
                              scale: math.Vector3(8, 8, 8),
                              isAsset: true,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      context,
                      label: 'Apri 10 buste',
                      fontSize: 20,
                      onPressed: () {},
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(width: 20),
                    _buildButton(
                      context,
                      label: 'Apri una busta',
                      fontSize: 20,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Sceltascreen(),
                        ),
                      ),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      context,
                      label: 'Tassi di comparsa',
                      onPressed: () {},
                      isPrimary: false,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerscaffoldScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        shape: const CircleBorder(),
                        backgroundColor: bianco,
                        elevation: 8,
                        shadowColor: primary.withOpacity(0.5),
                      ),
                      child: const Icon(Icons.arrow_back, color: nero),
                    ),
                    const SizedBox(width: 20),
                    _buildButton(
                      context,
                      label: 'Scegli un\'altra busta\ndi espansione',
                      onPressed: () => showModal(context),
                      fontSize: 13,
                      textAlign: TextAlign.center,
                      isPrimary: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9, // Dimensione iniziale della modale
          minChildSize: 0.1, // Dimensione minima della modale
          maxChildSize: 0.9, // Dimensione massima della modale
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: bianco,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft, // Posiziona in alto a sinistra
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Homescreen(index: 1),));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 110,
                        height: 90,
                        decoration: BoxDecoration(
                          color: secondary,
                          border: Border.all(color: terziario,width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: Column(
                          children: [
                            const Text('Alpha Pack'),
                            Image.asset('assets/ImgEspansione/alpha_pack_collect.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Chiudi la modale
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      backgroundColor: terziario,
                    ),
                    child: const Text("Chiudi", style: TextStyle(color: secondary),),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildButton(
      BuildContext context, {
        required String label,
        required VoidCallback onPressed,
        bool isPrimary = true,
        double fontSize = 15,
        TextAlign textAlign = TextAlign.left,
        OutlinedBorder? shape,
      }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: isPrimary ? EdgeInsets.symmetric(vertical: 12, horizontal: 20) : EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        backgroundColor: isPrimary ? terziario : bianco,
        shape: shape ?? const RoundedRectangleBorder(),
        elevation: 8,
        shadowColor: primary.withOpacity(0.5),
      ),
      child: Text(
        label,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
          color: isPrimary ? secondary : nero.withOpacity(0.4),
        ),
      ),
    );
  }
}
