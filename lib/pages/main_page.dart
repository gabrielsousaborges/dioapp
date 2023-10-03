import 'package:dioapp/pages/card_page.dart';
import 'package:dioapp/pages/dados_cadastrais.dart';
import 'package:dioapp/pages/list_view_h.dart';
import 'package:dioapp/pages/list_view_horizontal..dart';
import 'package:dioapp/pages/tarefa_page.dart';
import 'package:dioapp/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meu APP"),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: [
                  CardPage(),
                  ListViewPage(),
                  TarefaPage(),
                ],
              ),
            ),
            BottomNavigationBar(
              currentIndex: posicaoPagina,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: "Pag1",
                  icon: Icon(Icons.pageview),
                ),
                BottomNavigationBarItem(
                  label: "Tarefas",
                  icon: Icon(Icons.list),
                ),
              ],
              onTap: (value) {
                setState(() {
                  pageController.jumpToPage(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
