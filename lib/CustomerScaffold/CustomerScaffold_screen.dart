import 'package:flutter/material.dart';
import 'package:poketanime/Collection/Collection_Screen.dart';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Home/Switch_Pack.dart';

class CustomerscaffoldScreen extends StatefulWidget {
  final List<String>? cardIds;
  final int? index;

  const CustomerscaffoldScreen({super.key, this.cardIds, this.index});

  @override
  State<CustomerscaffoldScreen> createState() => _CustomerscaffoldScreenState();
}

class _CustomerscaffoldScreenState extends State<CustomerscaffoldScreen> {
  int _selectedIndex = 0;

  // Liste di schermate (o widget) per ogni elemento della barra
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0;
    // Aggiungi le schermate dinamicamente nella lista
    _pages.add(SwitchPack());
    _pages.add(CollectionScreen(cardIds: widget.cardIds ?? [])); // Passa cardIds a CollectionScreen
    _pages.add(SwitchPack());
    _pages.add(SwitchPack());
    _pages.add(SwitchPack());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          backgroundColor: secondary,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            return const TextStyle(color: Colors.white);
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            return const IconThemeData(
              color: Colors.black,
            );
          }),
        ),
        child: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: AnimatedScale(
                scale: _selectedIndex == 0 ? 1.5 : 1.0,
                duration: Duration(milliseconds: 200),
                child: const Icon(Icons.home_filled),
              ),
              label: "",
            ),
            NavigationDestination(
              icon: AnimatedScale(
                scale: _selectedIndex == 1 ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: const Image(
                  image: AssetImage('assets/icons/navigation_bar/collezione_icon.png'),
                  width: 30, height: 30,
                ),
              ),
              label: "",
            ),
            NavigationDestination(
              icon: AnimatedScale(
                scale: _selectedIndex == 2 ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: const Image(
                  image: AssetImage('assets/icons/navigation_bar/scambi_icon.png'),
                  width: 30, height: 30,
                ),
              ),
              label: '',
            ),
            NavigationDestination(
              icon: AnimatedScale(
                scale: _selectedIndex == 3 ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: const Image(
                  image: AssetImage('assets/icons/navigation_bar/lotta_icon.png'),
                  width: 30, height: 30,
                ),
              ),
              label: '',
            ),
            NavigationDestination(
              icon: AnimatedScale(
                scale: _selectedIndex == 4 ? 1.5 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const ClipOval(
                      child: Image(image: AssetImage('assets/icons/navigation_bar/Uzui Tengen_baby.jpg'), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              label: "",
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
      ),
    );
  }
}
