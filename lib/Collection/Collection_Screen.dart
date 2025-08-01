import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poketanime/Home/Card_exaple.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Colors.dart';
import '../Services/ApiPoint/ListAPI.dart';

class CollectionScreen extends StatefulWidget {
  final List<dynamic>? cardIds;
  final int? index;
  const CollectionScreen({super.key, this.cardIds = const [], required this.index});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late SharedPreferences prefs;
  int selectedIndex = 1;
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();
  bool JJK = true;
  bool Tensei = false;
  bool Slayer = false;
  String Apipoint = "";

  @override
  void initState() {
    super.initState();
    //_clearPreferences();
    _initSharedPreferences();
    Apipoint = JujutsuKaisenPack;
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    await fetchCards(JujutsuKaisenPack);
    _loadSavedCardIds("savedCardIdsJK");
  }

  Future<void> fetchCards(String apiUrl) async {
    try {
      final url = Uri.parse(apiUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('cards')) {
          final cardsList = data['cards'] as List<dynamic>;
          setState(() {
            items = cardsList.map((item) {
              final itemId = item['Id'].toString();
              return {
                'id': itemId,
                'name': item['Nome'] ?? '',
                'image': item['Immagine_sfondo'] ?? '',
                'locked': true,
                'discovered': false,
              };
            }).toList();
            isLoading = false;
          });
          for (var item in items) {
            if (widget.cardIds?.contains(item['id']) ?? false) {
              await _saveCardId(item['id'], widget.index!);
            }
          }
        } else {
          throw Exception('Chiave "cards" non trovata nella risposta API');
        }
      } else {
        throw Exception('Errore nel recupero delle carte');
      }
    } catch (e) {
      print('Errore durante il recupero delle carte: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveCardId(String cardId, int index) async {
    String key;
    switch (index) {
      case 0:
        key = 'savedCardIdsMT';
        break;
      case 1:
        key = 'savedCardIdsJK';
        break;
      case 2:
        key = 'savedCardIdsDS';
        break;
      default:
        throw ArgumentError('Index non valido: $index');
    }

    List<String> savedCardIds = prefs.getStringList(key) ?? [];

    if (!savedCardIds.contains(cardId)) {
      savedCardIds.add(cardId);
      await prefs.setStringList(key, savedCardIds);
    }
  }


  void _loadSavedCardIds(String key) {
    List<String> savedCardIds = prefs.getStringList(key) ?? [];
    for (var item in items) {
      if (savedCardIds.contains(item['id'])) {
        item['locked'] = false;
        item['discovered'] = true;
      }
    }
    setState(() {});
  }


  Future<void> _clearPreferences() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    print('Tutti gli elementi sono stati eliminati dalle SharedPreferences');
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 50.0;
    const double itemWidth = 30.0;

    List<Map<String, dynamic>> filteredItems = searchController.text.isEmpty
        ? items
        : items.where((item) =>
        item['name']
            .toLowerCase()
            .trim()
            .contains(searchController.text.toLowerCase().trim())).toList();


    return Scaffold(
      extendBodyBehindAppBar: true,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filteredItems = items.where((item) =>
                      item['name']
                          .toLowerCase()
                          .trim()
                          .contains(value.toLowerCase().trim())).toList();
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cerca un personaggio...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                      onPressed: () async {
                        setState(() {
                          selectedIndex = 1;
                          Apipoint = JujutsuKaisenPack;
                          if (!JJK) {
                            JJK = !JJK;
                          }
                          Tensei = false;
                          Slayer = false;
                        });
                        await fetchCards(JujutsuKaisenPack);
                        _loadSavedCardIds("savedCardIdsJK");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: JJK ? terziario.withOpacity(0.9) : Colors.white,
                        elevation: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Jiujizu Kaisen',style: TextStyle(fontSize: 20,color: JJK ? bianco : nero),),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                          Apipoint = "";
                          if (!Tensei) {
                            Tensei = !Tensei;
                          }
                          JJK = false;
                          Slayer = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Tensei ? terziario.withOpacity(0.9) : Colors.white,
                          elevation: 8
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Mushoku Tensei',style: TextStyle(fontSize: 20,color: Tensei ? bianco : nero),),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          selectedIndex = 2;
                          Apipoint = DemonSlayerPack;
                          if (!Slayer) {
                            Slayer = !Slayer;
                          }
                          JJK = false;
                          Tensei = false;
                        });
                        await fetchCards(DemonSlayerPack);
                        _loadSavedCardIds("savedCardIdsDS");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Slayer ? terziario.withOpacity(0.9) : Colors.white,
                          elevation: 8
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Demon Slayer',style: TextStyle(fontSize: 20,color: Slayer ? bianco : nero),),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CardExample(index: index,Apipoint: Apipoint ?? "https://mocki.io/v1/f2bfd528-17d7-4070-87af-217fcdf7f0ff",)));
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
                  color: Colors.black.withOpacity(0.7),
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
