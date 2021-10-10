import 'Producto.dart';

class DettallCa {
// {
//     "direccion": "av san martin 260 buenos aires",
//     "direccion_alt": "la alborada mz g lote 32",
//     "montV": 200,
//     "montoC": 220,
//     "estado_pedido": 2,
//     "cantp": 1,
//     "fecha_entrega": "2021-09-14T05:00:00.000Z"
//   }

  int iddetalle = 0;
  Producto p = Producto(0, "");
  int cant = 0;
  double precioP = 0;

  get getiddetall => this.iddetalle;
  Producto get getproduc => this.p;
  get getcant => this.cant;
  get getprecioP => this.precioP;

  DettallCa();
  //Dettallv(this.id_pedido, this.fecha_entrega, this.estado_pedido, this.vent);

  DettallCa.fromJson(Map<String, dynamic> json) {
    iddetalle = (json.containsKey("id_detalle")) ? json['id_detalle'] : 0;
    //print("ventas------------------------------------------------------------");
    //print(json);
    p = Producto.fromJson({
      "id_producto": (json.containsKey("id_produc"))
          ? json['id_produc']
          : (json.containsKey("id_producto"))
              ? json['id_producto']
              : 0,
      "nombre": (json.containsKey("nombre")) ? json['nombre'] : "",
      "descripccion":
          (json.containsKey("descripccion")) ? json['descripccion'] : "",
      "foto": (json.containsKey("foto")) ? json['foto'] : "",
      "love": (json.containsKey("lover")) ? json['lover'] : 0,
      "precV": (json.containsKey("precV")) ? json['precV'] : 0
    });
    //print("------------------------------------------------------------------");
    //montoC = double.parse(json['montoC'].toString());
    cant = (json.containsKey("cant")) ? json['cant'] : 0;
    precioP = (json.containsKey("precT")) ? json['precT'] * 1.0 : 0;
    //cantidadp = json['cantidadp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_detalle'] = iddetalle;
    data['precioP'] = precioP;
    data['cant'] = cant;
    data['producto'] = p.toJson();
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