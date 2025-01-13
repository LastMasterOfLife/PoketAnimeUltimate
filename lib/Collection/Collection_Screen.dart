import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:poketanime/Home/Card_exaple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionScreen extends StatefulWidget {
  final List<dynamic>? cardIds;
  const CollectionScreen({super.key, this.cardIds = const []});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late SharedPreferences prefs;
  int selectedIndex = 0;
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_clearPreferences();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    await fetchCards();
    _loadSavedCardIds();
  }

  Future<void> fetchCards() async {
    try {
      final url = Uri.parse('https://mocki.io/v1/f2bfd528-17d7-4070-87af-217fcdf7f0ff');
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

  Future<void> _saveCardId(String cardId) async {
    List<String> savedCardIds = prefs.getStringList('savedCardIds') ?? [];
    if (!savedCardIds.contains(cardId)) {
      savedCardIds.add(cardId);
      await prefs.setStringList('savedCardIds', savedCardIds);
    }
  }

  void _loadSavedCardIds() {
    List<String> savedCardIds = prefs.getStringList('savedCardIds') ?? [];
    for (var item in items) {
      if (savedCardIds.contains(item['id'])) {
        item['locked'] = false;
        item['discovered'] = true;
      }
    }
    setState(() {});
  }

  void _unlockSavedCards() {
    widget.cardIds?.forEach((cardId) async {
      await _saveCardId(cardId.toString());
    });
    _loadSavedCardIds();
  }

  Future<void> _clearPreferences() async {
    // Ottieni l'istanza di SharedPreferences
    prefs = await SharedPreferences.getInstance();

    // Cancella tutte le preferenze salvate
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CardExample(index: index)));
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
