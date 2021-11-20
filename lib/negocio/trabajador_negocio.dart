import '../repository/trabajador_repositorio.dart';
import 'package:flutter/cupertino.dart';
import '../controllers/trabajador.dart';
import '../config/validador.dart';

class TrabajadorNegocio {
  TrabajadorRepositorio respo = TrabajadorRepositorio();
  validador val = validador();

  // se usa el objeto cliente para hacer la imprecion en usuario
  Future<List<Trabajador>> getlist(Map<String, dynamic> jsonAtri) async {
    jsonAtri['tipous'] =
        jsonAtri.containsKey('tipous') ? jsonAtri['tipous'].toString() : "";
    jsonAtri['name'] =
        (jsonAtri['name'] != "") ? jsonAtri['name'].toString() : "%20";
    return await respo.getlist(jsonAtri);
  }

  Future<Trabajador> read(Map<String, dynamic> jsonAtri) async {
    jsonAtri['iduser'] =
        jsonAtri.containsKey('iduser') ? jsonAtri['iduser'].toString() : "0";
    return await respo.read(jsonAtri);
  }

  // "nombre": "",
  // "numero": 96928025,
  // "correo": "",
  // "id_tiptraba": 0,
  // "photo": ""

  Future<List<Object>> update(
      Trabajador uss, ValueChanged<int> accionres) async {
    // print(
    //     "nombre ${(uss.getnombre != "" && uss.getnombre.toString().split(" ").length > 1)} celular ${uss.getcelula != 0} correo ${uss.getcorreo != ""} idtrabaja ${uss.getidtrabaja != 0} foto ${uss.getfoto != ""}");
    // print(
    //     "nombre ${uss.getnombre} celular ${uss.getcelula} correo ${uss.getcorreo} idtrabaja ${uss.getidtrabaja} foto ${uss.getfoto}");
    if (val.valName(uss.getnombre) ||
        val.valCelular(uss.getcelula.toString()) ||
        val.valCorreo(uss.getcorreo) ||
        uss.getidtrabaja != 0 ||
        val.valvacio(uss.getfoto)) {
      int resul = await respo.update(uss, accionres);
      return [resul, []];
    } else {
      return [
        400,
        [
          !(val.valName(uss.getnombre) ||
              val.valCelular(uss.getcelula.toString()) ||
              val.valCorreo(uss.getcorreo) ||
              uss.getidtrabaja != 0 ||
              val.valvacio(uss.getfoto))
        ]
      ];
    }
  }

  // "usser": "admin",
  // "pass": "admin",
  // "nombre": "carlos arturo guerrero castillo",
  // "numero": 969280255,
  // "correo": "arturo14212000@gmail.com",
  // "id_tiptraba": 1,
  // "photo": "http://localhost:9000/img/sticker.webp"

  // print("nombre - ${val.valName("carlos arturo")}");
  // print("password - ${val.valpassword("Aa123456")}");
  // print("Correo - ${val.valCorreo("Arturo14212000@gmail.com")}");
  // print("celular - ${val.valCelular("969280255")}");
  // print("nulos - ${val.valvacio("969280255")}");
  // print("coins - ${val.valCoins(10.0)}");

  Future<List<Object>> insert(
      Trabajador trap, ValueChanged<int> accionres) async {
    if (val.valvacio(trap.getusser) &&
        val.valpassword(trap.getpass) &&
        val.valName(trap.getnombre) &&
        val.valCelular(trap.getcelula.toString()) &&
        val.valCorreo(trap.getcorreo) &&
        trap.gettiptranba.getidtrab != 0 &&
        val.valvacio(trap.getfoto)) {
      int resultado = await respo.insert(trap, accionres);
      return [resultado, []];
    } else {
      return [
        400,
        [
          !(val.valName(trap.getnombre)),
          !(val.valvacio(trap.getusser)),
          !(val.valpassword(trap.getpass)),
          !(trap.gettiptranba.getidtrab != 0),
          !(val.valCelular(trap.getcelula.toString())),
          !(val.valCorreo(trap.getcorreo)),
          !(val.valvacio(trap.getfoto))
        ]
      ];
    }
  }
}
