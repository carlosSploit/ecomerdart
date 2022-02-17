import 'package:flutter_test/flutter_test.dart';

// ejecucion del metodo tedd
void main() {
  // entrada y saldia de datos de un mensaje
  test("Probar una suma", () async {
    int a = 1, b = 1;
    // lo que se pasa es la suma y lo que se espera es que sea el resultado 2
    expect((a + b), 2);
  });
}
