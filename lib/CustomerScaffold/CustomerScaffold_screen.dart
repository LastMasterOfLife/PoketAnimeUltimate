import 'package:flutter/material.dart';
import 'package:poketanime/Collection/Collection_Screen.dart';
import 'package:poketanime/Colors.dart';
import 'package:poketanime/Componets/menu_component.dart';
import 'package:poketanime/Home/Switch_Pack.dart';
import 'package:poketanime/Community/Community_screen.dart';
import 'package:poketanime/Lotta/Lotte_screen.dart';
import 'package:poketanime/Menu/Menu_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class CustomerscaffoldScreen extends StatefulWidget {
  final List<String>? cardIds;
  final int? index;
  final int? pack;

  const CustomerscaffoldScreen({super.key, this.cardIds, this.index, this.pack});

  @override
  State<CustomerscaffoldScreen> createState() => _CustomerscaffoldScreenState();
}

class _CustomerscaffoldScreenState extends State<CustomerscaffoldScreen> {
  int _selectedIndex = 0;

  bool _isMenuOverlayVisible = false;
  final List<Widget> _pages = [];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startBackgroundMusic();
    _selectedIndex = widget.index ?? 0;
    _isMenuOverlayVisible = false;
    _pages.add(const SwitchPack());
    _pages.add(CollectionScreen(cardIds: widget.cardIds ?? [], index: widget.pack ?? 1));
    _pages.add(const CommunityScreen());
    _pages.add(const LotteScreen());
    _pages.add(MenuScreen(isMenuOverlayVisible: _isMenuOverlayVisible));
  }

  void _startBackgroundMusic() async {
    print("Inizializzazione della musica");
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.setVolume(1.0);
    await _audioPlayer.play(AssetSource('Audio/caricamento.mp3'));
    print("Musica avviata");
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      setState(() {
        _isMenuOverlayVisible = !_isMenuOverlayVisible;
      });
    } else {
      setState(() {
        _selectedIndex = index;
        _isMenuOverlayVisible = false;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                    duration: const Duration(milliseconds: 200),
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
                      width: 30,
                      height: 30,
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
                      width: 30,
                      height: 30,
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
                      width: 30,
                      height: 30,
                    ),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: AnimatedScale(
                    scale: _selectedIndex == 4 ? 1.5 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.menu),
                  ),
                  label: "",
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
            ),
          ),
        ),
        // Menù laterale
        if (_isMenuOverlayVisible)
          Stack(
            children: [
              MenuComponent(visible: _isMenuOverlayVisible, onClose: () {
                setState(() {
                  _isMenuOverlayVisible = false;
                });
              }),
            ],
          ),
      ],
    );
  }
}
