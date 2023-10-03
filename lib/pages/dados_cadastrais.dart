import 'package:dioapp/repository/linguagens_repository.dart';
import 'package:dioapp/repository/nivel_repository.dart';
import 'package:dioapp/services/app_storage.dart';
import 'package:dioapp/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dataNascimentoController =
      TextEditingController(text: "");
  AppStorageService storage = AppStorageService();
  final String CHAVE_DADOS_CADASTRAIS_NOME = "CHAVE_DADOS_CADASTRAIS_NOME";
  final String CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO =
      "CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO";
  final String CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAISNIVEL_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_LINGUAGENS =
      "CHAVE_DADOS_CADASTRAIS_LINGUAGENS";
  final String CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA =
      "CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA";
  final String CHAVE_DADOS_CADASTRAIS_SALARIO =
      "CHAVE_DADOS_CADASTRAIS_SALARIO";

  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var nivelSelecionado = "";
  var linguagens = [];
  List<String> linguagensSelecionadas = [];
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
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
    nomeController.text = await storage.getDadosCadastraisNome();
    dataNascimentoController.text =
        await storage.getDadosCadastraisDataNascimento();
    if (dataNascimentoController.text.isNotEmpty) {
      dataNascimento = DateTime.parse(dataNascimentoController.text);
    }
    nivelSelecionado = await storage.getDadosCadastraisNivelExperiencia();
    linguagensSelecionadas = await storage.getDadosCadastraisLinguagens();
    tempoExperiencia = await storage.getDadosCadastraisTempoExperiencia();
    salarioEscolhido = await storage.getDadosCadastraisSalario();
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
                      if (dataNascimento != null) {
                        dataNascimentoController.text =
                            dataNascimento.toString();
                        dataNascimento = data;
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
                            selected: nivelSelecionado == nivel,
                            value: nivel.toString(),
                            groupValue: nivelSelecionado,
                            onChanged: (value) {
                              setState(() {
                                nivelSelecionado = value.toString();
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
                            value: linguagensSelecionadas.contains(e),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  linguagensSelecionadas.add(e);
                                });
                              } else {
                                setState(() {
                                  linguagensSelecionadas.remove(e);
                                });
                              }
                            }))
                        .toList(),
                  ),
                  TextLabel(texto: "Tempo de Experiencia"),
                  DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(10),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(value.toString());
                        });
                      }),
                  TextLabel(
                      texto:
                          "Pretenção Salarial : R\$ ${salarioEscolhido.round().toString()}"),
                  Slider(
                      value: salarioEscolhido,
                      min: 0,
                      max: 10000,
                      onChanged: (double value) {
                        setState(() {
                          salarioEscolhido = value;
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
                        if (dataNascimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Data de nascimento invalida!"),
                          ));
                          return;
                        }
                        if (nivelSelecionado.trim() == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content:
                                Text("Nivel selecionado deve ser selecionado!"),
                          ));
                          return;
                        }
                        if (linguagensSelecionadas.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Selecione ao menos uma linguagem!"),
                          ));
                          return;
                        }
                        if (salarioEscolhido == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Pretencao salarial dever ser maior que zero!"),
                          ));
                          return;
                        }
                        setState(() {
                          salvando = true;
                        });

                        Future.delayed(Duration(seconds: 3), () async {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Dados Salvos!"),
                          ));

                          await storage
                              .setDadosCadastraisNome(nomeController.text);
                          await storage.setDadosCadastraisDataNascimento(
                              dataNascimento!);
                          await storage.setDadosCadastraisNivelExperiencia(
                              nivelSelecionado);
                          await storage.setDadosCadastraisLinguagens(
                              linguagensSelecionadas);
                          await storage.setDadosCadastraisTempoExperiencia(
                              tempoExperiencia);
                          await storage
                              .setDadosCadastraisSalario(salarioEscolhido);
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
