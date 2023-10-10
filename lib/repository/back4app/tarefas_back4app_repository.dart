import 'package:dio/dio.dart';
import 'package:dioapp/model/tarefas_back4app_model.dart';
import 'package:dioapp/repository/back4app/back4app_custon_dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TarefasBack4AppRepository {
  final _custonDio = Back4AppCustonDio();

  Future<TarefasBack4AppModel> obterTarefas(bool naoConcluidas) async {
    var url = "/Tarefas";

    if (naoConcluidas) {
      url = url + "?where={\"concluido\":false}";
    }
    var result = await _custonDio.dio.get(url);

    return TarefasBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _custonDio.dio
          .post("/Tarefas", data: tarefaBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw (e);
    }
  }

  Future<void> atualizar(TarefaBack4AppModel tarefaBack4AppModel) async {
    try {
      await _custonDio.dio.put("/Tarefas/${tarefaBack4AppModel.objectId}",
          data: tarefaBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw (e);
    }
  }

  Future<void> remover(String id) async {
    try {
      await _custonDio.dio.delete("/Tarefas/$id");
    } catch (e) {
      throw (e);
    }
  }
}
