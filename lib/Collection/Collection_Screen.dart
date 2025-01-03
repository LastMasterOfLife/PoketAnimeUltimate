import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Home/Card_exaple.dart';

class CollectionScreen extends StatefulWidget {
  final List<dynamic>? cardIds;
  const CollectionScreen({super.key, this.cardIds = const []});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  String searchQuery = "";
  final TextEditingController searchController = TextEditingController();

  Future<void> fetchCards() async {
    final url = Uri.parse(
        'https://mocki.io/v1/e1635e8e-c11a-48a5-b355-51bc60f10a12');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final cardsList = data['cards'] as List<dynamic>;
      setState(() {
        items = cardsList.map((item) {
          final itemId = item['Id'].toString();
          final isDiscovered = widget.cardIds?.contains(itemId) ?? false;
          final isLocked = !isDiscovered;
          return {
            'id': itemId,
            'name': item['Name'] ?? '',
            'image': item['Immagine_sfondo'] ?? '',
            'locked': isLocked,
            'discovered': isDiscovered,
          };
        }).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Errore nel recupero delle carte');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 50.0;
    const double itemWidth = 30.0;

    List<Map<String, dynamic>> filteredItems = items.where((item) => item['name'].toLowerCase().trim().contains(searchController.text.toLowerCase().trim())).toList();

    print('Items caricati: $items');

    print('Query di ricerca: ${searchController.text}');
    print('Items filtrati: $filteredItems');


    return Scaffold(
      extendBodyBehindAppBar: true,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchController.text = value;
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cerca un personaggio...',
                hintStyle: TextStyle(color: bianco),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: primary,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: itemWidth / itemHeight,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];

                  print('Card IDs passed: ${widget.cardIds}');
                  print('Current card ID: ${item['id']}');

                  return gridItem(
                    item['image'],
                    item['locked'],
                    item['discovered'],
                    itemHeight,
                    itemWidth,
                    index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget gridItem(String imagePath, bool locked, bool discovered, double height,
      double width, int index) {
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
                if (!locked && discovered) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardExample(index: index),
                    ),
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imagePath.startsWith('http')
                    ? Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  loadingBuilder:
                      (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                        child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image,
                        color: Colors.red);
                  },
                )
                    : Image.asset(
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
            if (!locked && discovered)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30,
              ),
          ],
        ),
      ),
    );
  }
}
