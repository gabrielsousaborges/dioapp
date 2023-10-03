import 'dart:math';

class GeradorNumeroAleatorio {
  static int gerarNumeroAleatorio(int numeroMaximo) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(numeroMaximo);
  }
}
