import 'cliente.dart';

class Carritocomp {
// {
//     "direccion": "av san martin 260 buenos aires",
//     "direccion_alt": "la alborada mz g lote 32",
//     "montV": 200,
//     "montoC": 220,
//     "estado_pedido": 2,
//     "cantp": 1,
//     "fecha_entrega": "2021-09-14T05:00:00.000Z"
//   }

  // ignore: non_constant_identifier_names
  int id_carrito = 0;
  double montot = 0.0;
  double montotal = 0.0;
  int cantiproduct = 0;
  Cliente clien = Cliente();

  // ignore: non_constant_identifier_names
  get getid_carrito => this.id_carrito;
  get getmontot => this.montot;
  get getmontotal => this.montotal;
  get getcantiproduct => this.cantiproduct;
  get getclien => this.clien;

  Carritocomp();

  Carritocomp.fromJson(Map<String, dynamic> json) {
    id_carrito = (json.containsKey("id_carrito")) ? json['id_carrito'] : 0;
    //print("ventas------------------------------------------------------------");
    //print(json);
    //print("------------------------------------------------------------------");
    //montoC = double.parse(json['montoC'].toString());
    //fecha_entrega = json['fecha_entrega'].toString().split("T")[0];
    montot = (json.containsKey("montot")) ? json['montot'] * 1.0 : 0.0;
    montotal = (json.containsKey("montotal"))
        ? json['montotal'].toDouble() * 1.0
        : 0.0;
    cantiproduct =
        (json.containsKey("cantiproduct")) ? json['cantiproduct'] : 0;
    clien = Cliente.fromJson({
      "id_cliente": (json.containsKey('id_cliente')) ? json['id_cliente'] : 0,
      "direccion": (json.containsKey('direccion')) ? json['direccion'] : "",
      "direccion_alt":
          (json.containsKey('direccion_alt')) ? json['direccion_alt'] : "",
      //--------------------
      // CORREGIR EN LA BACE DE DATOS -----------------------------
      "nombre": (json.containsKey('nombre'))
          ? json['nombre']
          : (json.containsKey('nombe'))
              ? json['nombe']
              : ""
    });
    //cantidadp = json['cantidadp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_carrito'] = id_carrito;
    data['montot'] = montot;
    data['montotal'] = montotal;
    data['cantiproduct'] = cantiproduct;
    data['cliente'] = clien.toJson();
    return data;
  }
}

//  {
  //   "id_pedido": 4,
  //   "montoC": 220,
  //   "fecha": "2021-09-14T05:00:00.000Z",
  //   "estado_pedido": 2,
  //   "cantidadp": 1
  // }