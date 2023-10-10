import 'package:dioapp/model/tarefa.dart';
import 'package:dioapp/model/tarefa_hive_model.dart';
import 'package:dioapp/model/tarefa_sqlite_model.dart';
import 'package:dioapp/repository/sqlite/tarefa_sqlite_repository.dart';
import 'package:dioapp/repository/tarefa_hive_repository.dart';
import 'package:dioapp/repository/tarefa_repository.dart';
import 'package:flutter/material.dart';

class TarefaSQLitePage extends StatefulWidget {
  const TarefaSQLitePage({super.key});

  @override
  State<TarefaSQLitePage> createState() => _TarefaSQLitePageState();
}

class _TarefaSQLitePageState extends State<TarefaSQLitePage> {
  TarefaSQLiteRepository tarefaRepository = TarefaSQLiteRepository();
  var descricaoController = TextEditingController();
  var _tarefas = <TarefaSQLiteModel>[];
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefas = await tarefaRepository.obterDados(apenasNaoConcluidos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        await tarefaRepository.salvar(TarefaSQLiteModel(
                            0, descricaoController.text, false));
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
                  itemCount: _tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var tarefa = _tarefas[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        tarefaRepository.remover(tarefa.id);

                        obterTarefas();
                      },
                      key: Key(tarefa.descricao),
                      child: ListTile(
                        trailing: Switch(
                          onChanged: (bool value) async {
                            tarefa.concluido = value;

                            tarefaRepository.atualizar(tarefa);
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
