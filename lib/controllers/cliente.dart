import 'package:ecomersbaic/config/validador.dart';
import 'package:ecomersbaic/controllers/usuario.dart';

class Cliente extends Usuario {
  //
// id_cliente
// id_usuario
// nombe
// celular
// direccion
// direccion_alt
// correo
// foto

  // ignore: non_constant_identifier_names
  int id_cliente = 0;
  String direccion = "";
  // ignore: non_constant_identifier_names
  String direccion_alt = "";

  get getidclie => this.id_cliente;
  get getdirecc => this.direccion;
  // ignore: non_constant_identifier_names
  get gedirec_a => this.direccion_alt;

  Cliente();

  // Cliente(this.id_cliente, this.nombre, this.celular, this.direccion,
  //     this.direccion_alt, this.correo, this.foto);
  @override
  Cliente.fromJson(Map<String, dynamic> json) {
    id_cliente = (json.containsKey('id_cliente')) ? json['id_cliente'] : 0;
    direccion = (json.containsKey('direccion')) ? json['direccion'] : "";
    direccion_alt =
        (json.containsKey('direccion_alt')) ? json['direccion_alt'] : "";
    //--------------------
    // CORREGIR EN LA BACE DE DATOS -----------------------------
    nombre = (json.containsKey('nombre'))
        ? json['nombre']
        : (json.containsKey('nombe'))
            ? json['nombe']
            : "";
    //------------------------------------------------------------
    celular = (json.containsKey('celular')) ? json['celular'] : 0;
    correo = (json.containsKey('correo')) ? json['correo'] : "";
    foto =
        (json.containsKey('foto')) ? validador().geturlimage(json['foto']) : "";
    idusuario = (json.containsKey('id_usuario')) ? json['id_usuario'] : 0;
    usser = (json.containsKey('usser')) ? json['usser'] : "";
    pass = (json.containsKey('pass')) ? json['pass'] : "";
    tipouser = (json.containsKey('tipo_user')) ? json['tipo_user'] : "";
    estado = (json.containsKey('estado')) ? json['estado'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_cliente'] = id_cliente;
    data['direccion'] = direccion;
    data['direccion_alt'] = direccion_alt;
    //--------------------
    data['nombre'] = nombre;
    data['celular'] = celular;
    data['correo'] = correo;
    data['foto'] = foto;
    data['id_usuario'] = idusuario;
    data['usser'] = usser;
    data['pass'] = pass;
    data['tipo_user'] = tipouser;
    data['estado'] = estado;
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
