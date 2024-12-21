import 'package:poketanime/Home/Card_exaple.dart';
import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  // Lista di immagini e stati di blocco
  final List<Map<String, dynamic>> items = [
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/gojo_card.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/toji_fushiguro_card.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/yuuji_itadori_card.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/nanami_card.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/rika.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/nobara_kugisaki.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/aoi_todo.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/megumi_fushiguro.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/Yuta & Rika.jpg', 'locked': true},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/hanami.jpg', 'locked': false},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/mahito.jpg', 'locked': true},
    {'image': 'assets/KaisenPack/cards/comune/backgrounds/jogo.jpg', 'locked': true},

  ];

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 50.0;
    const double itemWidth = 30.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 container per riga
            crossAxisSpacing: 9.0, // Spazio orizzontale tra i container
            mainAxisSpacing: 20.0, // Spazio verticale tra i container
            childAspectRatio: itemWidth / itemHeight
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return gridItem(item['image'], item['locked'], itemHeight,itemWidth,index);
          },
        ),
      ),
    );
  }

  Widget gridItem(String imagePath, bool locked, double height, double width, int index) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.purple,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: () {
                if (!locked) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardExample(index: index,)));
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            if (locked)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
          ],
        ),
      ),
    );
  }

}
