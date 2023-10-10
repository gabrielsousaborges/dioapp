import 'dart:io';

import 'package:dioapp/model/dados_cadastrais_model.dart';
import 'package:dioapp/model/tarefa_hive_model.dart';
import 'package:dioapp/pages/http.dart';
import 'package:dioapp/pages/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationCacheDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}
