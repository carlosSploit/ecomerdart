import 'package:ecomersbaic/repository/trabajador_repositorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecomersbaic/controllers/trabajador.dart';

class TrabajadorNegocio {
  TrabajadorRepositorio respo = TrabajadorRepositorio();

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
    if ((uss.getnombre != "" &&
            uss.getnombre.toString().split(" ").length > 1) ||
        uss.getcelula != 0 ||
        uss.getcorreo != "" ||
        uss.getidtrabaja != 0 ||
        uss.getfoto != "") {
      int resul = await respo.update(uss, accionres);
      return [resul, []];
    } else {
      return [
        400,
        [
          !((uss.getnombre != "" ||
                  uss.getnombre.toString().split(" ").length > 1) ||
              uss.getcelula != 0 ||
              uss.getcorreo != "" ||
              uss.getidtrabaja != 0 ||
              uss.getfoto != "")
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

  Future<List<Object>> insert(
      Trabajador trap, ValueChanged<int> accionres) async {
    if (trap.getusser != "" &&
        trap.getpass != "" &&
        (trap.getnombre != "" &&
            trap.getnombre.toString().split(" ").length > 1) &&
        trap.getcelula != 0 &&
        trap.getcorreo != "" &&
        trap.gettiptranba.getidtrab != 0 &&
        trap.getfoto != "") {
      int resultado = await respo.insert(trap, accionres);
      return [resultado, []];
    } else {
      return [
        400,
        [
          !(trap.getnombre != "" &&
              trap.getnombre.toString().split(" ").length > 1),
          !(trap.getusser != ""),
          !(trap.getpass != ""),
          !(trap.gettiptranba.getidtrab != 0),
          !(trap.getcelula != 0),
          !(trap.getcorreo != ""),
          !(trap.getfoto != "")
        ]
      ];
    }
  }
}
