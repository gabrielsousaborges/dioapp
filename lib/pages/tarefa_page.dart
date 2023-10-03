import 'package:dioapp/model/tarefa.dart';
import 'package:dioapp/repository/tarefa_repository.dart';
import 'package:flutter/material.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var descricaoController = TextEditingController();
  var tarefaRepository = TarefaRepository();
  var _tarefas = <Tarefa>[];
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    if (apenasNaoConcluidos) {
      _tarefas = await tarefaRepository.listarTarefasNaoConcluidas();
    } else {
      _tarefas = await tarefaRepository.listarTarefas();
    }
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
                        await tarefaRepository.adicionaTarefa(
                            Tarefa(descricaoController.text, false));
                        Navigator.pop(context);
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
                        await tarefaRepository.removeTarefa(tarefa.id);

                        obterTarefas();
                      },
                      key: Key(tarefa.id),
                      child: ListTile(
                        trailing: Switch(
                          onChanged: (bool value) async {
                            await tarefaRepository.alteraTarefa(
                                tarefa.id, value);
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
