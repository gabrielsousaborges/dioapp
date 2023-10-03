import 'package:dioapp/shared/widgets/app_images.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.logoUser),
          title: Text("User 1"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Olá"),
              Text("10:10"),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (item) {},
            itemBuilder: (BuildContext b) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(value: "menu1", child: Text("Opção 1")),
                PopupMenuItem<String>(value: "menu1", child: Text("Opção 2")),
                PopupMenuItem<String>(value: "menu1", child: Text("Opção 3")),
              ];
            },
          ),
          isThreeLine: true,
        ),
        Container(
          color: Colors.amberAccent,
        ),
        Container(
          color: Colors.red,
        ),
      ],
    );
  }
}
