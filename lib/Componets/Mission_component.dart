import 'package:flutter/material.dart';
import 'package:poketanime/Colors.dart';

class MissionComponent extends StatefulWidget {
  final int index;
  final String title;
  final String descrizione;

  final String? riconpensa;
  final String? num;

  final bool block;

  const MissionComponent({super.key, required this.title, required this.descrizione, required this.block, required this.index, this.riconpensa, this.num});

  @override
  State<MissionComponent> createState() => _MissionComponentState();
}

class _MissionComponentState extends State<MissionComponent> {
  @override
  Widget build(BuildContext context) {

    switch(widget.index) {
      case 0:
        {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  gradient: widget.block ? const LinearGradient(
                      colors: [primary,primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  ) : const LinearGradient(
                      colors: [terziario,quaternario],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  ),
                  border: Border.all(color: bianco,width: 2)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.title),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 95,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: secondary,
                        border: Border.all(color: bianco,width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(widget.descrizione)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      case 1:
        {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 185,
              decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  gradient: widget.block ? const LinearGradient(
                      colors: [primary,primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  ) : const LinearGradient(
                      colors: [terziario,quaternario],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  ),
                  border: Border.all(color: bianco,width: 2)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.title),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: secondary,
                        border: Border.all(color: bianco,width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Image(image: AssetImage(widget.riconpensa ?? 'assets/icons/consumabili/emblem_cardex.png',),height: 50,width: 50,),
                              ),
                              Text(widget.num ?? '0'),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(widget.descrizione,softWrap: true,maxLines: 3,)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      default: {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
                color: secondary,
                borderRadius: const BorderRadius.all(Radius.circular(18)),
                gradient: widget.block ? const LinearGradient(
                    colors: [primary,primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                ) : const LinearGradient(
                    colors: [terziario,quaternario],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                ),
                border: Border.all(color: bianco,width: 2)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.title),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 95,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondary,
                      border: Border.all(color: bianco,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(widget.descrizione)),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }


  }
}

