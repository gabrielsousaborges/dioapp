import 'dart:convert';

import 'package:dioapp/model/viacep_model.dart';
import 'package:dioapp/repository/viacep_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController(text: "");
  var viaCepModel = ViaCEPModel();
  var viaCepRepository = ViaCepRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text(
                "Consulta de CEP",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                maxLength: 8,
                onChanged: (String value) async {
                  var cep = value.replaceAll(new RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {});
                    viaCepModel = await viaCepRepository.consultarCEP(cep);
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                viaCepModel.logradouro ?? "",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "${viaCepModel.localidade ?? ""} - ${viaCepModel.uf ?? ""}",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {},
        ),
      ),
    );
  }
}
