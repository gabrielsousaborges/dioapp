import 'dart:convert';

import 'package:dioapp/model/viacep_model.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<ViaCEPModel> consultarCEP(String cep) async {
    var response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      return ViaCEPModel.fromJson(json);
    } else {
      return ViaCEPModel();
    }
  }
}
