import 'package:dioapp/model/configuracoes_model.dart';
import 'package:dioapp/repository/configuracoes_repository.dart';
import 'package:dioapp/services/app_storage.dart';
import 'package:flutter/material.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configuracoes HIVE"),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(hintText: "Nome Usuario"),
                  controller: nomeUsuarioController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Altura"),
                  controller: alturaController,
                ),
              ),
              SwitchListTile(
                title: Text("Receber Notificações"),
                onChanged: (value) {
                  setState(() {
                    configuracoesModel.receberNotificacoes = value;
                  });
                },
                value: configuracoesModel.receberNotificacoes,
              ),
              SwitchListTile(
                title: Text("Tema escuro"),
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.temaEscuro = value;
                  });
                },
                value: configuracoesModel.temaEscuro,
              ),
              TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    configuracoesModel.altura =
                        double.parse(alturaController.text);
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("MEU APP"),
                            content: Text("Informar uma altura valida"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Sair"),
                              )
                            ],
                          );
                        });
                    return;
                  }
                  configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                  configuracoesRepository.salvar(configuracoesModel);
                  Navigator.pop(context);
                },
                child: Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
