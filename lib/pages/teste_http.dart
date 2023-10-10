import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpTestePage extends StatefulWidget {
  const HttpTestePage({super.key});

  @override
  State<HttpTestePage> createState() => _HttpTestePageState();
}

class _HttpTestePageState extends State<HttpTestePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            var response = await http.get(Uri.parse(
                "https://www.dnh.bet/compra/651ea654ba225314520231005"));
            print(response.body);
            print(response.statusCode);
          },
        ),
      ),
    );
  }
}
