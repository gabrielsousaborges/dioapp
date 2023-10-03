import 'package:dioapp/model/tarefa.dart';

class TarefaRepository {
  List<Tarefa> _tarefas = [];

  Future<void> adicionaTarefa(Tarefa tarefa) async {
    await Future.delayed(Duration(milliseconds: 100));

    _tarefas.add(tarefa);
  }

  Future<void> alteraTarefa(String id, bool concluido) async {
    await Future.delayed(Duration(milliseconds: 100));

    _tarefas.where((tarefa) => tarefa.id == id).first.concluido = concluido;
  }

  Future<void> removeTarefa(String id) async {
    await Future.delayed(Duration(milliseconds: 100));

    _tarefas.remove(_tarefas.where((tarefa) => tarefa.id == id).first);
  }

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(Duration(milliseconds: 100));
    return _tarefas;
  }

  Future<List<Tarefa>> listarTarefasNaoConcluidas() async {
    await Future.delayed(Duration(milliseconds: 100));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }
}
