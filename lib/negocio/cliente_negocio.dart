import 'package:ecomersbaic/repository/cliente_repositorio.dart';
import 'package:ecomersbaic/controllers/cliente.dart';
import 'package:flutter/cupertino.dart';

class ClienteNegocio {
  ClienteRepositorio respo = ClienteRepositorio();

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
    if (uss.getusser != "" &&
        uss.getpass != "" &&
        (uss.getnombre != "" &&
            uss.getnombre.toString().split(" ").length > 1) &&
        uss.getcelula != 0 &&
        uss.getcorreo != "" &&
        uss.gedirec_a != "" &&
        uss.getdirecc != "" &&
        uss.getfoto != "") {
      return await respo.insert(uss, accionres);
    } else {
      return 400;
    }
  }

  Future<List<Object>> update(Cliente uss, ValueChanged<int> accionres) async {
    if (uss.getusser != "" ||
        uss.getpass != "" ||
        (uss.getnombre != "" ||
            uss.getnombre.toString().split(" ").length > 1) ||
        uss.getcelula != 0 ||
        uss.getcorreo != "" ||
        uss.gedirec_a != "" ||
        uss.getdirecc != "" ||
        uss.getfoto != "") {
      int resul = await respo.update(uss, accionres);
      return [resul, []];
    } else {
      return [
        400,
        [
          !(uss.getusser != "" ||
              uss.getpass != "" ||
              (uss.getnombre != "" ||
                  uss.getnombre.toString().split(" ").length > 1) ||
              uss.getcelula != 0 ||
              uss.getcorreo != "" ||
              uss.gedirec_a != "" ||
              uss.getdirecc != "" ||
              uss.getfoto != "")
        ]
      ];
    }
  }
}
