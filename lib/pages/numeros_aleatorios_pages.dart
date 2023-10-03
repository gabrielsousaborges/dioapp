import 'dart:math';

import 'package:dioapp/services/app_storage.dart';
import 'package:flutter/material.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    quantidadeCliques = await storage.getQuantidadeCliques();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Gerador de numeros aleatorios"),
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
            await storage.setNumeroAleatorio(numeroGerado);
            await storage.setQuantidadeCliques(quantidadeCliques);
          },
        ),
      ),
    );
  }
}
