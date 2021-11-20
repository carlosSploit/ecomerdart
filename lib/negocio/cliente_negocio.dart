import 'package:ecomersbaic/config/validador.dart';

import '../repository/cliente_repositorio.dart';
import '../controllers/cliente.dart';
import 'package:flutter/cupertino.dart';

class ClienteNegocio {
  ClienteRepositorio respo = ClienteRepositorio();
  validador val = validador();

  // se usa el objeto cliente para hacer la imprecion en usuario
  Future<List<Cliente>> getlist(Map<String, dynamic> jsonAtri) async {
    jsonAtri['tipous'] =
        jsonAtri.containsKey('tipous') ? jsonAtri['tipous'].toString() : "";
    jsonAtri['name'] = jsonAtri.containsKey('name')
        ? ((jsonAtri['name'] != "") ? jsonAtri['name'].toString() : "%20")
        : "%20";
    return await respo.getlist(jsonAtri);
  }

  Future<Cliente> read(Map<String, dynamic> jsonAtri) async {
    jsonAtri['iduser'] =
        jsonAtri.containsKey('iduser') ? jsonAtri['iduser'].toString() : "0";
    print("${jsonAtri['iduser']} -> datos");
    return await respo.read(jsonAtri);
  }

  Future<int> insert(Cliente uss, ValueChanged<int> accionres) async {
    if (val.valvacio(uss.getusser) &&
        val.valpassword(uss.getpass) &&
        val.valName(uss.getnombre) &&
        val.valCelular(uss.getcelula.toString()) &&
        val.valCorreo(uss.getcorreo) &&
        val.valvacio(uss.gedirec_a) &&
        val.valvacio(uss.getdirecc) &&
        val.valvacio(uss.getfoto)) {
      return await respo.insert(uss, accionres);
    } else {
      return 400;
    }
  }

  Future<List<Object>> update(Cliente uss, ValueChanged<int> accionres) async {
    if (val.valvacio(uss.getusser) ||
        val.valpassword(uss.getpass) ||
        val.valName(uss.getnombre) ||
        val.valCelular(uss.getcelula.toString()) ||
        val.valCorreo(uss.getcorreo) ||
        val.valvacio(uss.gedirec_a) ||
        val.valvacio(uss.getdirecc) ||
        val.valvacio(uss.getfoto)) {
      int resul = await respo.update(uss, accionres);
      return [resul, []];
    } else {
      return [
        400,
        [
          !(val.valvacio(uss.getusser) ||
              val.valpassword(uss.getpass) ||
              val.valName(uss.getnombre) ||
              val.valCelular(uss.getcelula.toString()) ||
              val.valCorreo(uss.getcorreo) ||
              val.valvacio(uss.gedirec_a) ||
              val.valvacio(uss.getdirecc) ||
              val.valvacio(uss.getfoto))
        ]
      ];
    }
  }
}
