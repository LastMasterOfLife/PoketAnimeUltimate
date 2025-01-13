import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';

class MenuComponent extends StatefulWidget {
  final bool visible;
  final VoidCallback onClose;
  const MenuComponent({super.key, required this.visible, required this.onClose});

  @override
  State<MenuComponent> createState() => _MenuComponentState();
}

class _MenuComponentState extends State<MenuComponent> {
  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: Container(
            color: Colors.black.withOpacity(0.65),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 57,
          child: Material(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30)
            ),
            child: Container(
              decoration:  BoxDecoration(
                color: secondary.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
                )
              ),
              height: 550,
              width: 300,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("ID cliente",style: TextStyle(
                          color: grigio
                        ),),
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: bianco,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: grigio)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                            child: Text("000001"),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bianco.withOpacity(1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: bianco,width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: grigio.withOpacity(0.2), //Colors.grey.shade500,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(2, 2)
                            ),
                            BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(-2, -3)
                            ),
                          ]
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
                        color: bianco,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: bianco,width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: grigio.withOpacity(0.2), //Colors.grey.shade500,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(2, 2)
                            ),
                            BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(-2, -3)
                            ),
                          ]
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(3)),

                            ),
                            height: 40,
                              width: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                                    child: Image.asset('assets/icons/pass.png',scale: 1.5,fit: BoxFit.cover,)),
                              )),
                          SizedBox(width: 30,),
                          Text("Pass base",style: TextStyle(color: grigio,fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      leading: Image.asset('assets/icons/oggetti_icon.png',scale: 1.8,color: nero.withOpacity(0.5),),
                      title: const Text('Oggetti',style: TextStyle(fontSize: 15,color: grigio),),
                      onTap: () {
                        // Logica per impostazioni
                        //widget.onClose(); // Chiudi il menu
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: bianco.withOpacity(0.6),
                          boxShadow: [
                            BoxShadow(
                                color: grigio.withOpacity(0.2), //Colors.grey.shade500,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(2, 2)
                            ),
                            BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(-2, -3)
                            ),
                          ]
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.email_outlined,size: 30,color: nero.withOpacity(0.5),),
                            title: const Text('Novità', style: TextStyle(fontSize: 15, color: grigio)),
                            onTap: () {
                              // Logica per impostazioni
                              //widget.onClose(); // Chiudi il menu
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/icons/present.png',scale: 15.5,color: nero.withOpacity(0.5),),
                            title: const Text('Regali',style: TextStyle(fontSize: 15, color: grigio),),
                            onTap: () {
                              // Logica per informazioni
                              widget.onClose(); // Chiudi il menu
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.info,size: 30,color: nero.withOpacity(0.5),),
                            title: const Text('Info utili',style: TextStyle(fontSize: 15, color: grigio)),
                            onTap: () {
                              // Logica per informazioni
                              //widget.onClose(); // Chiudi il menu
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.settings,size: 30,color: nero.withOpacity(0.5),),
                            title: const Text('Altro',style: TextStyle(fontSize: 15, color: grigio)),
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
