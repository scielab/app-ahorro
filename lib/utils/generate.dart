import 'dart:math';


String generateNumberAvatar() {
  final random = Random();
  const letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < 10; i++) {
    final letraAleatoria = letras[random.nextInt(letras.length)];
    buffer.write(letraAleatoria);
  }
  return buffer.toString();

}