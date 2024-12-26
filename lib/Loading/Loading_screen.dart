
import 'package:flutter/material.dart';
import 'package:poketanime/CustomerScaffold/CustomerScaffold_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void navigazione(){
    // Naviga automaticamente alla pagina di Login dopo 3 secondi
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CustomerscaffoldScreen()),
      );
    });
  }




  @override @override
  void initState() {
    super.initState();
    navigazione();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Animaker", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40
            ),)),
          ],
        ),
      ),
    );
  }
}


