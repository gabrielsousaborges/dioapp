import 'package:dioapp/pages/configuracoes/configuracao_shared_page.dart';
import 'package:dioapp/pages/configuracoes/configuracoes_hive_page.dart';
import 'package:dioapp/pages/dados_cadastrais/dados_cadastrais_hive.dart';
import 'package:dioapp/pages/login_page.dart';
import 'package:dioapp/pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';
import 'package:dioapp/pages/numeros_aleatorios/numeros_aleatorios_shared_pages.dart';
import 'package:dioapp/pages/posts_page.dart';
import 'package:dioapp/pages/tarefa/tarefa_http_page.dart';
import 'package:dioapp/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 0, 97, 146),
                  child: Image.asset("assets/LogoCaveiraWhite.png")),
              accountName: Text("Teste"),
              accountEmail: Text("email@email.com"),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  builder: (BuildContext b) {
                    return Wrap(
                      children: [
                        ListTile(
                          title: Text("Camera"),
                          leading: Icon(Icons.camera_alt),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text("Galeria"),
                          leading: Icon(Icons.photo_camera_back),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Dados"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DadosCadastraisHivePage()));
            },
          ),
          Divider(),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.build_circle_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Configurações"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfiguracoesHivePage()));
            },
          ),
          Divider(),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.content_paste),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Termos de Uso e Privacidade"),
                ],
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                builder: (BuildContext b) {
                  return GestureDetector(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Column(
                        children: [
                          TextLabel(texto: "Termo de Uso e Privacidade"),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "O incentivo ao avanço tecnológico, assim como a percepção das dificuldades faz parte de um processo de gerenciamento das condições inegavelmente apropriadas. É claro que a valorização de fatores subjetivos facilita a criação dos procedimentos normalmente adotados. Podemos já vislumbrar o modo pelo qual o consenso sobre a necessidade de qualificação afeta positivamente a correta previsão do sistema de formação de quadros que corresponde às necessidades. Caros amigos, o início da atividade geral de formação de atitudes estende o alcance e a importância do levantamento das variáveis envolvidas.",
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
          Divider(),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.numbers),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Gerador de numeros"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (bc) => NumerosAleatoriosHivePage()));
            },
          ),
          Divider(),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.post_add),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Posts"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (bc) => PostPage()));
            },
          ),
          Divider(),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.task),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Back4App"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (bc) => TarefaHTTPPage()));
            },
          ),
          Divider(),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Sair"),
                ],
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext b) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerLeft,
                      elevation: 8,
                      title: TextLabel(texto: "Meu APP"),
                      content: Wrap(
                        children: [
                          Text("Voce saira do aplicativo!"),
                          Text("Deseja realmente sair do APP ?"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: TextLabel(
                            texto: "Não",
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: TextLabel(texto: "Sim"),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
