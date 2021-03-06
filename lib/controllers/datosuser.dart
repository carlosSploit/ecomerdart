import '../config/validador.dart';

class Datosuser {
  int idclient = 0;
  int idtrabajador = 0;
  int idcarrito = 0;
  int iduser = 0;
  int idinterface = 0;
  String tipouse = "";
  String foto = "";

  int get getidclient => this.idclient;
  int get getidtrabajador => this.idtrabajador;
  int get getidcarrito => this.idcarrito;
  int get getiduser => this.iduser;
  int get getidinterface => this.idinterface;
  String get gettiouse => this.tipouse;
  String get getfoto => this.foto;

  Datosuser();

  Datosuser.fromJson(Map<String, dynamic> json) {
    this.idclient = (json.containsKey("idclient")) ? json['idclient'] : 0;
    this.idtrabajador =
        (json.containsKey("idtrabajador")) ? json['idtrabajador'] : 0;
    this.idcarrito = (json.containsKey("idcarrito")) ? json['idcarrito'] : 0;
    this.iduser = (json.containsKey("iduser")) ? json['iduser'] : 0;
    this.idinterface =
        (json.containsKey("idinterface")) ? json['idinterface'] : 0;
    this.tipouse = (json.containsKey("tipouse")) ? json['tipouse'] : "";
    this.foto =
        (json.containsKey("foto")) ? validador().geturlimage(json['foto']) : "";
    //cantidadp = json['cantidadp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['idclient'] = idclient;
    data['idtrabajador'] = idtrabajador;
    data['idcarrito'] = idcarrito;
    data['idinterface'] = idinterface;
    data['iduser'] = iduser;
    data['tipouse'] = tipouse;
    data['foto'] = foto;
    return data;
  }
}
