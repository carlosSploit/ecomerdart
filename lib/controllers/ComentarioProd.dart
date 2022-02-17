import '../controllers/Producto.dart';
import '../controllers/cliente.dart';

class ComentarioProd {
  Producto pro = Producto.fromJson({});
  Cliente clien = Cliente.fromJson({});
  int idcoment = 0;
  String fechamess = "";
  String meng = "";

  int get getidcar => this.idcoment;
  String get getfechmess => this.fechamess;
  String get getmeg => this.meng;
  Cliente get getclien => this.clien;
  Producto get getprod => this.pro;

  ComentarioProd(this.idcoment, this.fechamess, this.meng);

  ComentarioProd.fromJson(Map<String, dynamic> json) {
    idcoment = (json.containsKey('idcoment')) ? json['idcoment'] : 0;
    fechamess = (json.containsKey('fecha_mess'))
        ? json['fecha_mess']
        : (json.containsKey('fecha'))
            ? json['fecha']
            : "";
    meng = (json.containsKey('messe'))
        ? json['messe']
        : (json.containsKey('mensaje'))
            ? json['mensaje']
            : "";
    clien = Cliente.fromJson({
      'id_cliente': (json.containsKey('id_clie')) ? json['id_clie'] : 0,
      'nombe': (json.containsKey('nombe')) ? json['nombe'] : "",
      'foto': (json.containsKey('foto')) ? json['foto'] : ""
    });
    pro = Producto.fromJson({
      'id_produc': (json.containsKey('id_pro')) ? json['id_pro'] : 0,
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['idcoment'] = idcoment;
    data['fechamess'] = fechamess;
    return data;
  }
}
