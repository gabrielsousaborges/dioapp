import 'dart:math';

import 'package:dioapp/services/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;
  late Box boxNumerosAleatorios;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    quantidadeCliques = boxNumerosAleatorios.get('quantidadeCliques') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Numeros Aleatorios HIVE"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              numeroGerado == null
                  ? "Nenhum numero gerado"
                  : numeroGerado.toString(),
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              quantidadeCliques == null
                  ? "Nenhum clique"
                  : quantidadeCliques.toString(),
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              quantidadeCliques = quantidadeCliques + 1;
            });
            boxNumerosAleatorios.put('numeroGerado', numeroGerado);
            boxNumerosAleatorios.put('quantidadesCliques', quantidadeCliques);
          },
        ),
      ),
    );
  }
}
