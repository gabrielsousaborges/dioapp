import 'package:dioapp/model/card_detail.dart';
import 'package:dioapp/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class CardDetailPage extends StatelessWidget {
  final CardDetail cardDetail;
  const CardDetailPage({super.key, required this.cardDetail});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: cardDetail.id,
        child: Scaffold(
          // appBar: AppBar(),
          body: Padding(
            padding:
                EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/LogoCaveiraWhite.png',
                        height: 30,
                      ),
                      TextLabel(texto: cardDetail.title),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Text(
                    cardDetail.text,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
