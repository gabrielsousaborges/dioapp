import 'package:dioapp/model/dados_cadastrais_model.dart';
import 'package:dioapp/repository/dados_cadastrais_repository.dart';
import 'package:dioapp/repository/linguagens_repository.dart';
import 'package:dioapp/repository/nivel_repository.dart';
import 'package:dioapp/services/app_storage.dart';
import 'package:dioapp/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({super.key});

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();

  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dataNascimentoController =
      TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  bool salvando = false;

  List<DropdownMenuItem> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i,
        ),
      );
    }

    return itens;
  }

  @override
  void initState() {
    niveis = nivelRepository.RetornaNiveis();
    linguagens = linguagensRepository.RetornaLinguagens();

    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.carregar();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();
    dadosCadastraisRepository.obterDados();
    nomeController.text = dadosCadastraisModel.nome ?? "";
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null
        ? ""
        : dadosCadastraisModel.dataNascimento.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus Dados")),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  TextLabel(texto: "Nome"),
                  TextField(
                    controller: nomeController,
                  ),
                  TextLabel(texto: "Data de Nascimento"),
                  TextField(
                    controller: dataNascimentoController,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1950, 1, 1),
                          lastDate: DateTime(2023, 12, 31));
                      if (data != null) {
                        dataNascimentoController.text = data.toString();
                        dadosCadastraisModel.dataNascimento = data;
                      }
                    },
                  ),
                  TextLabel(texto: "Nivel de Experiencia"),
                  Column(
                    children: niveis
                        .map(
                          (nivel) => RadioListTile(
                            dense: true,
                            title: Text(nivel.toString()),
                            selected:
                                dadosCadastraisModel.nivelExperiencia == nivel,
                            value: nivel.toString(),
                            groupValue: dadosCadastraisModel.nivelExperiencia,
                            onChanged: (value) {
                              setState(() {
                                dadosCadastraisModel.nivelExperiencia =
                                    value.toString();
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  TextLabel(texto: "Linguagens Preferidas"),
                  Column(
                    children: linguagens
                        .map((e) => CheckboxListTile(
                            dense: true,
                            title: Text(e),
                            value: dadosCadastraisModel.linguagens.contains(e),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  dadosCadastraisModel.linguagens.add(e);
                                });
                              } else {
                                setState(() {
                                  dadosCadastraisModel.linguagens.remove(e);
                                });
                              }
                            }))
                        .toList(),
                  ),
                  TextLabel(texto: "Tempo de Experiencia"),
                  DropdownButton(
                      value: dadosCadastraisModel.tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(10),
                      onChanged: (value) {
                        setState(() {
                          dadosCadastraisModel.tempoExperiencia =
                              int.parse(value.toString());
                        });
                      }),
                  TextLabel(
                      texto:
                          "Pretenção Salarial : R\$ ${dadosCadastraisModel.salario?.round().toString()}"),
                  Slider(
                      value: dadosCadastraisModel.salario ?? 0,
                      min: 0,
                      max: 10000,
                      onChanged: (double value) {
                        setState(() {
                          dadosCadastraisModel.salario = value;
                        });
                      }),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          salvando = false;
                        });

                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("O nome deve ser preenchido!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.dataNascimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Data de nascimento invalida!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.nivelExperiencia == null ||
                            dadosCadastraisModel.nivelExperiencia!.trim() ==
                                "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content:
                                Text("Nivel selecionado deve ser selecionado!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.linguagens.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Selecione ao menos uma linguagem!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.salario == null ??
                            dadosCadastraisModel.salario == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Pretencao salarial dever ser maior que zero!"),
                          ));
                          return;
                        }

                        dadosCadastraisModel.nome = nomeController.text;
                        dadosCadastraisRepository.salvar(dadosCadastraisModel);
                        setState(() {
                          salvando = true;
                        });

                        Future.delayed(Duration(seconds: 3), () async {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Dados Salvos!"),
                          ));
                          setState(() {
                            salvando = false;
                          });
                        });
                      },
                      child: Text('Salvar'))
                ],
              ),
      ),
    );
  }
}
