import 'package:ecomersbaic/controllers/Producto.dart';

class Analitic {
  int id = 0;
  String fecha = "";
  double ganacia  = 0.0;
  Producto datosExter = Producto.fromJson({});

  String get getfecha => this.fecha;
  double get getganan => this.ganacia;
  Producto get getdatosex => this.datosExter;

  Analitic();

  Analitic.fromJson(Map<String, dynamic> json) {
    fecha = (json.containsKey('fecha')) ? json['fecha'].toString().split("T")[0] : "0000/00/00";
    ganacia = (json.containsKey('ganacia')) ? json['ganacia'] * 1.0 : 0.0;
    datosExter = Producto.fromJson({
      "id_producto" : (json.containsKey('id_produc')) ? json['id_produc'] : 0,
      "nombre": (json.containsKey('nombre')) ? json['nombre'] : "",
      "stock": (json.containsKey('cant')) ? json['cant'] : 0,
      "foto": (json.containsKey('foto')) ? json['foto'] : ""
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fecha'] = fecha;
    data['ganacia'] = ganacia;
    data['datosExter'] = datosExter.toJson();
    return data;
  }
}
