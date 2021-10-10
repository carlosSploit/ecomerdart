import 'package:ecomersbaic/controllers/TipTrabajador.dart';
import 'package:ecomersbaic/controllers/usuario.dart';

class Trabajador extends Usuario {
  //
// id_cliente
// id_usuario
// nombe
// celular
// direccion
// direccion_alt
// correo
// foto

  int idtrabajador = 0;
  TipTrabajador tiptran = TipTrabajador.fromJson({});

  get getidtrabaja => this.idtrabajador;
  TipTrabajador get gettiptranba => this.tiptran;

  // Cliente(this.id_cliente, this.nombre, this.celular, this.direccion,
  //     this.direccion_alt, this.correo, this.foto);
  @override
  Trabajador.fromJson(Map<String, dynamic> json) {
    idtrabajador =
        (json.containsKey('id_trabajador')) ? json['id_trabajador'] : 0;

    tiptran = TipTrabajador.fromJson({
      "id_tiptrabajador": (json.containsKey("id_tiptrabajador"))
          ? json['id_tiptrabajador']
          : (json.containsKey("id_tipotrabaja"))
              ? json['id_tipotrabaja']
              : 0,
      "nomb_tipo": (json.containsKey("nomb_tipo"))
          ? json['nomb_tipo']
          : (json.containsKey("nametipo"))
              ? json['nametipo']
              : ""
    });
    //--------------------
    // CORREGIR EN LA BACE DE DATOS -----------------------------
    nombre = (json.containsKey('nombre'))
        ? json['nombre']
        : (json.containsKey('nombe'))
            ? json['nombe']
            : "";
    //------------------------------------------------------------
    celular = (json.containsKey('celular'))
        ? json['celular']
        : (json.containsKey('numero'))
            ? json['numero']
            : 0;
    correo = (json.containsKey('correo')) ? json['correo'] : "";
    foto = (json.containsKey('foto')) ? json['foto'] : "";
    idusuario = (json.containsKey('id_usuario')) ? json['id_usuario'] : 0;
    usser = (json.containsKey('usser')) ? json['usser'] : "";
    pass = (json.containsKey('pass')) ? json['pass'] : "";
    tipouser = (json.containsKey('tipo_user')) ? json['tipo_user'] : "";
    estado = (json.containsKey('estado')) ? json['estado'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_trabajador'] = idtrabajador;
    data['tipotrabajo'] = tiptran;
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
