import 'cliente.dart';

class Venta {
  int idventa = 0;
  double montoT = 0;
  double montoC = 0;
  double montV = 0;
  String lugar = "desconocido";
  String fecha = "";
  int cantidadp = 0;
  double montoigv = 0.0;
  Cliente clie = Cliente();

  int get getidvent => this.idventa;
  double get getmontoc => this.montoC;
  double get getmontoT => this.montoT;
  double get getmontoigv => montoigv;
  String get getlugar => this.lugar;
  get getmontoV => this.montV;
  String get getfech => this.fecha;
  get getcant => this.cantidadp;
  get getclien => this.clie;

  Venta(this.idventa, this.montoC, this.montV, this.montoT, this.fecha,
      this.cantidadp);

  Venta.fromJson(Map<String, dynamic> json) {
    idventa = (json.containsKey("id_venta")) ? json['id_venta'] : 0;
    montoC = (json.containsKey("montoC"))
        ? double.parse(json['montoC'].toString())
        : 0;
    montoT = (json.containsKey("montoT"))
        ? double.parse(json['montoT'].toString())
        : 0;
    montV = (json.containsKey("montV"))
        ? double.parse(json['montV'].toString())
        : 0;
    fecha = (json.containsKey("fecha"))
        ? json['fecha'].toString().split("T")[0]
        : "";
    montoigv = (json.containsKey("montoigv")) ? json['montoigv'] * 1.0 : 0.0;
    cantidadp = (json.containsKey("cantidadp")) ? json['cantidadp'] : 0;
    lugar = (json.containsKey("lugar")) ? json['lugar'] : "";
    // insercion concatenada para clientes
    //#########################################################################

    clie = Cliente.fromJson({
      "id_cliente": (json.containsKey('id_cliente')) ? json['id_cliente'] : 0,
      "direccion": (json.containsKey('direccion')) ? json['direccion'] : "",
      "direccion_alt":
          (json.containsKey('direccion_alt')) ? json['direccion_alt'] : "",
      "nombre": (json.containsKey('nombre'))
          ? json['nombre']
          : (json.containsKey('nombe'))
              ? json['nombe']
              : ""
    });
    //#########################################################################
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_venta'] = idventa;
    data['montoC'] = montoC;
    data['montoT'] = montoT;
    data['montV'] = montV;
    data['fecha'] = fecha;
    data['cantidadp'] = cantidadp;
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