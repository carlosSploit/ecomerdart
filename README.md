# ecomersbaic

A new Flutter project.

## Ejecutar Tdd

En caso que quieras ejecutar un tdd en la aplicacion, para luego hacerle mejoras o reusar dichos metodos. Tienes que crear un archivo dart, con el nombre que termine en \_test dentro de la carpeta test.

Por otro lado al realizar esto, se tendra que colocar codigo para ejecutar un tdd, como el metodo test, que es un metodo para aplicar un test unitario, por otro lado tambien se usa el metodo expect, o metodo de espera, que presenta dos paramtros, que son lo que se calcula o se comprueba, y lo esperado por esa comprobacion. Esto se ve reflejado en el siguiente ejemplo:

```
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
```

Ya teniendo nuestro test hecho, solo nos quedaria ejecutar el archivo, por el cual se tendra que usarse un comando de ejecucion. Considerando que el archivo de ejecucion se llama suma_test.dart, el comando seria el siguiente:

```
flutter test test/suma_test.dart
```
