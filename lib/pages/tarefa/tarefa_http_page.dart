import 'package:dioapp/model/tarefa.dart';
import 'package:dioapp/model/tarefa_hive_model.dart';
import 'package:dioapp/model/tarefa_sqlite_model.dart';
import 'package:dioapp/model/tarefas_back4app_model.dart';
import 'package:dioapp/repository/back4app/tarefas_back4app_repository.dart';
import 'package:dioapp/repository/sqlite/tarefa_sqlite_repository.dart';
import 'package:dioapp/repository/tarefa_hive_repository.dart';
import 'package:dioapp/repository/tarefa_repository.dart';
import 'package:flutter/material.dart';

class TarefaHTTPPage extends StatefulWidget {
  const TarefaHTTPPage({super.key});

  @override
  State<TarefaHTTPPage> createState() => _TarefaHTTPPageState();
}

class _TarefaHTTPPageState extends State<TarefaHTTPPage> {
  TarefasBack4AppRepository tarefaRepository = TarefasBack4AppRepository();
  var descricaoController = TextEditingController();
  var _tarefasBack4App = TarefasBack4AppModel([]);
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefasBack4App = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Http Back4App")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          descricaoController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: Text("Adicionar Tarefa"),
                  content: TextField(
                    controller: descricaoController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar")),
                    TextButton(
                      onPressed: () async {
                        await tarefaRepository.criar(TarefaBack4AppModel.criar(
                            descricaoController.text, false));
                        Navigator.pop(context);
                        obterTarefas();
                        setState(() {});
                      },
                      child: Text("Salvar"),
                    ),
                  ],
                );
              });
        },
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Apenas não concluidos",
                    style: TextStyle(fontSize: 14),
                  ),
                  Switch(
                      value: apenasNaoConcluidos,
                      onChanged: (bool value) {
                        apenasNaoConcluidos = value;
                        obterTarefas();
                      })
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _tarefasBack4App.tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var tarefa = _tarefasBack4App.tarefas[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        await tarefaRepository.remover(tarefa.objectId);

                        obterTarefas();
                      },
                      key: Key(tarefa.descricao),
                      child: ListTile(
                        trailing: Switch(
                          onChanged: (bool value) async {
                            tarefa.concluido = value;

                            await tarefaRepository.atualizar(tarefa);
                            obterTarefas();
                          },
                          value: tarefa.concluido,
                        ),
                        title: Text(tarefa.descricao),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
