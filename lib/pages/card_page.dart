import 'package:dioapp/model/card_detail.dart';
import 'package:dioapp/pages/card_detail_page.dart';
import 'package:dioapp/repository/card_detail_repository.dart';
import 'package:dioapp/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetail? cardDetail;
  var cardDetailRepository = CardDetailRepository();
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    cardDetail = await cardDetailRepository.retornaCard();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          child: cardDetail == null
              ? LinearProgressIndicator()
              : GestureDetector(
                  child: Hero(
                    tag: cardDetail!.id,
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black87,
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/LogoCaveiraWhite.png',
                                    height: 30,
                                  ),
                                  TextLabel(texto: cardDetail!.title),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              cardDetail!.text,
                              textAlign: TextAlign.justify,
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                child: Text(
                                  "Ler Mais",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardDetailPage(
                          cardDetail: cardDetail!,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
