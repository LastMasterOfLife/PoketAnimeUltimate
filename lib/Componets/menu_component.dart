import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';

class MenuComponent extends StatefulWidget {
  final bool visible;
  final VoidCallback onClose; // Callback per chiudere il menu
  const MenuComponent({super.key, required this.visible, required this.onClose});

  @override
  State<MenuComponent> createState() => _MenuComponentState();
}

class _MenuComponentState extends State<MenuComponent> {
  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox.shrink(); // Non mostra nulla se non visibile
    }
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose, // Chiama la callback per chiudere il menu
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30)
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: bianco,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
                )
              ),
              height: 500,
              width: 300,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("ID cliente",style: TextStyle(
                        color: grigio
                      ),),
                      Container()
                    ],
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: grigio,width: 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: ClipOval(
                              child: Image.asset('assets/icons/avatar/ingris.jpg',fit: BoxFit.cover,),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Text("Nome",style: TextStyle(color: nero,fontSize: 25),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded,color: nero,),
                          SizedBox(width: 20,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: grigio,width: 1)
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Container(
                            height: 40,
                              width: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset('assets/icons/novita.png',scale: 1.5,fit: BoxFit.cover,),
                              )),
                          SizedBox(width: 30,),
                          Text("Pass base",style: TextStyle(color: grigio,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      leading: Image.asset('assets/icons/oggetti_icon.png',scale: 1.5,),
                      title: const Text('Oggetti',style: TextStyle(fontSize: 23),),
                      onTap: () {
                        // Logica per impostazioni
                        //widget.onClose(); // Chiudi il menu
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: bianco.withOpacity(0.6)
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.email_outlined,size: 40,color: nero,),
                            title: const Text('Novità',style: TextStyle(fontSize: 23)),
                            onTap: () {
                              // Logica per impostazioni
                              widget.onClose(); // Chiudi il menu
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/icons/present.png',scale: 10.5,),
                            title: const Text('Regali',style: TextStyle(fontSize: 23),),
                            onTap: () {
                              // Logica per informazioni
                              widget.onClose(); // Chiudi il menu
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.info,size: 40,color: nero,),
                            title: const Text('Info utili'),
                            onTap: () {
                              // Logica per informazioni
                              //widget.onClose(); // Chiudi il menu
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings,size: 40,color: nero,),
                            title: const Text('Altro'),
                            onTap: () {
                              // Logica per impostazioni
                              //widget.onClose(); // Chiudi il menu
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
