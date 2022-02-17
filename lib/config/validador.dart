import '../config/Cache.dart';

class validador {
  cache memori = cache();
  // valida un nombre, que tenga mas de dos palabra que este vacio
  bool valName(String name) {
    return (name != "" && name.toString().split(" ").length > 1);
  }

  // valida un password, que minimo tenga un numero, letras minusculas y mayusculas y que sea mayor que 8
  bool valpassword(String password) {
    return (password != "" &&
        valpresenMayus(password) &&
        valpresenMinus(password) &&
        valpresenNumber(password) &&
        password.length >= 8);
  }

  // valida un correo, que minimo tenga un @, un sub dominio .com y un dominio de correo ya sea hotmal o gmail
  bool valCorreo(String correo) {
    return (correo != "" &&
        correo.indexOf("@") != -1 &&
        correo.indexOf(".com") != -1);
  }

  // valida un celular, que no sea vacio y que sea de 9 digitos
  bool valCelular(String celular) {
    return (celular != "" && celular.length == 9);
  }

  // valida si la cadena presenta mayusculas - 65 => A -- 90 => Z
  bool valpresenMayus(String cadena) {
    for (var i = 0; i < cadena.length; i++) {
      if (cadena.codeUnitAt(i) >= 65 && cadena.codeUnitAt(i) <= 90) {
        return true;
      }
    }
    return false;
  }

  // valida si la cadena presenta mayusculas - 97 => a -- 122 => z
  bool valpresenMinus(String cadena) {
    for (var i = 0; i < cadena.length; i++) {
      if (cadena.codeUnitAt(i) >= 97 && cadena.codeUnitAt(i) <= 122) {
        return true;
      }
    }
    return false;
  }

  // valida si la cadena presenta numeros - 48 => 0 -- 57 => 9
  bool valpresenNumber(String cadena) {
    for (var i = 0; i < cadena.length; i++) {
      if (cadena.codeUnitAt(i) >= 48 && cadena.codeUnitAt(i) <= 57) {
        return true;
      }
    }
    return false;
  }

  // valida si una cadena esta vacia
  bool valvacio(String cadena) {
    return cadena != "";
  }

  // validadores con numeros
  bool valCoins(double coins) {
    return (coins > 0);
  }

  // validar precio de venta, eñ cual el precio de compra es menor que el de venta
  bool valCoinsVenta(double Compra, double Venta) {
    return (Compra <= Venta && Venta != 0);
  }

  // bora una nueva ruta de imege en caso que sea erronea el dominio.....
  String geturlimage(String domain) {
    return domain
        .replaceAll("localhost:9000", memori.getdomain.toString())
        .replaceAll("192.168.1.158:9000", memori.getdomain.toString());
  }
}

void main() async {
  validador val = validador();
  print("nombre - ${val.valName("carlos")}");
}
