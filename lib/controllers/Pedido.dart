import 'venta.dart';

class Pedido {
// {
//     "direccion": "av san martin 260 buenos aires",
//     "direccion_alt": "la alborada mz g lote 32",
//     "montV": 200,
//     "montoC": 220,
//     "estado_pedido": 2,
//     "cantp": 1,
//     "fecha_entrega": "2021-09-14T05:00:00.000Z"
//   }

  int idpedido = 0;
  String fechaentrega = "";
  int estadopedido = 0;
  Venta vent = Venta(0, 0, 0, 0, "fecha", 0);

  get getidpro => this.idpedido;
  get getfechent => this.fechaentrega;
  get getestapedi => this.estadopedido;
  Venta get getvent => this.vent;

  Pedido(this.idpedido, this.fechaentrega, this.estadopedido, this.vent);

  Pedido.fromJson(Map<String, dynamic> json) {
    idpedido = (json.containsKey("id_pedido")) ? json['id_pedido'] : 0;
    //print("ventas------------------------------------------------------------");
    //print(json);
    vent = Venta.fromJson({
      "id_venta": (json.containsKey("id_venta")) ? json['id_venta'] : 0,
      "montoC": (json.containsKey("montoC")) ? json['montoC'] : 0,
      "montV": (json.containsKey("montV")) ? json['montV'] : 0,
      "montoT": (json.containsKey("monto_t")) ? json['monto_t'] : 0,
      "fecha": (json.containsKey("fecha")) ? json['fecha'] : 0,
      "cantidadp": (json.containsKey("cantp"))
          ? json['cantp']
          : (json.containsKey("cantidadp"))
              ? json['cantidadp']
              : 0,
      "id_cliente": (json.containsKey('id_cliente')) ? json['id_cliente'] : 0,
      "direccion": (json.containsKey('direccion')) ? json['direccion'] : "",
      "direccion_alt":
          (json.containsKey('direccion_alt')) ? json['direccion_alt'] : "",
      "nombre": (json.containsKey('nombre'))
          ? json['nombre']
          : (json.containsKey('nombe'))
              ? json['nombe']
              : "",
      "lugar": (json.containsKey("lugar")) ? json['lugar'] : ""
    });
    //print("------------------------------------------------------------------");
    //montoC = double.parse(json['montoC'].toString());
    fechaentrega = json['fecha_entrega'].toString().split("T")[0];
    estadopedido =
        (json.containsKey("estado_pedido")) ? json['estado_pedido'] : 0;
    //cantidadp = json['cantidadp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_pedido'] = idpedido;
    data['fecha_entrega'] = fechaentrega;
    data['estado_pedido'] = estadopedido;
    data['venta'] = vent.toJson();
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