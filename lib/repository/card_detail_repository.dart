import 'package:dioapp/model/card_detail.dart';

class CardDetailRepository {
  Future<CardDetail> retornaCard() async {
    await Future.delayed(Duration(seconds: 3));
    return CardDetail(
      1,
      "Meu Card",
      "https://github.com/gabrielsousaborges",
      "Todas estas questões, devidamente ponderadas, levantam dúvidas sobre se o início da atividade geral de formação de atitudes pode nos levar a considerar a reestruturação das direções preferenciais no sentido do progresso.",
    );
  }
}
