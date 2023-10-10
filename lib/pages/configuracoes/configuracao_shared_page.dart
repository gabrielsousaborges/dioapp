import 'package:dioapp/services/app_storage.dart';
import 'package:flutter/material.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({super.key});

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() =>
      _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState
    extends State<ConfiguracoesSharedPreferencesPage> {
  AppStorageService storage = AppStorageService();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;
  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  void carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracaoUsuario();
    alturaController.text = (await storage.getConfiguracaoAltura()).toString();
    receberNotificacoes = await storage.getConfiguracaoNotificacao();
    temaEscuro = await storage.getConfiguracaoTema();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configuracoes"),
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
                    receberNotificacoes = value;
                  });
                },
                value: receberNotificacoes,
              ),
              SwitchListTile(
                title: Text("Tema escuro"),
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
                  });
                },
                value: temaEscuro,
              ),
              TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    await storage.setConfiguracaoAltura(
                        double.tryParse(alturaController.text) ?? 0);
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
                  await storage
                      .setConfiguracaoUsuario(nomeUsuarioController.text);
                  await storage.setConfiguracaoNotificacao(receberNotificacoes);
                  await storage.setConfiguracaoTema(temaEscuro);

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
