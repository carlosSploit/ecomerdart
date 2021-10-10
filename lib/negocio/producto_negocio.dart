import 'package:ecomersbaic/repository/producto_repositorio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecomersbaic/controllers/Producto.dart';

class ProductoNegocio {
  ProductoRepositorio respo = ProductoRepositorio();

  Future<List<Producto>> getlist(Map<String, dynamic> jsonAtri) async {
    jsonAtri['idcate'] = jsonAtri.containsKey('idcate')
        ? int.parse(jsonAtri['idcate'].toString())
        : 0;
    jsonAtri['iduser'] = jsonAtri.containsKey('iduser')
        ? int.parse(jsonAtri['iduser'].toString())
        : 0;
    jsonAtri['namepe'] = jsonAtri.containsKey('namepe')
        ? ((jsonAtri['namepe'] != "") ? jsonAtri['namepe'] : "%20")
        : "%20";
    return await respo.getlist(jsonAtri);
  }

  Future<Producto> read(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_prod'] = jsonAtri.containsKey('id_prod')
        ? ((jsonAtri['id_prod'] != "") ? jsonAtri['id_prod'] : "0")
        : "0";
    jsonAtri['id_clin'] = jsonAtri.containsKey('id_clin')
        ? ((jsonAtri['id_clin'] != "") ? jsonAtri['id_clin'] : "0")
        : "0";
    return await respo.read(jsonAtri);
  }

  // "nombre": "chifles de locos",
  // "descripción": "chifles que saben a tocino",
  // "stock": 10,
  // "precC": 12.0,
  // "precV": 14.0,
  // "codigo": 4545465456,
  // "foto": "http://localhost:9000/img/sticker.webp",
  // "id_cad": 1

  // presenta un error en el carrito de compra
  // value change servira para realizar una accion en caso que se requiera
  Future<List<Object>> update(Producto prp, ValueChanged<int> accs) async {
    print(
        "nombre ${prp.getname} descripccopn ${prp.getdesc} stock ${prp.getstock} precC ${prp.getprecC} precV ${prp.getprecV} foto ${prp.getfoto} idcatego ${prp.getcatego.getidcar}");
    if ((prp.getname != "" && prp.getname.toString().split(" ").length > 1) ||
        prp.getdesc != "" ||
        prp.getstock != 0 ||
        prp.getprecC != 0.0 ||
        (prp.getprecC <= prp.getprecV && prp.getprecV != 0) ||
        prp.getcodig != 0 ||
        prp.getfoto != "" ||
        prp.getcatego.getidcar != 0) {
      int resul = await respo.update(prp, accs);
      return [resul, []];
    } else {
      return [
        400,
        [
          !((prp.getname != "" &&
                  prp.getname.toString().split(" ").length > 1) ||
              prp.getdesc != "" ||
              prp.getstock != 0 ||
              prp.getprecC != 0.0 ||
              (prp.getprecC <= prp.getprecV && prp.getprecV != 0) ||
              prp.getcodig != 0 ||
              prp.getfoto != "" ||
              prp.getcatego.getidcar != 0)
        ]
      ];
    }
  }

  // "nombre": "chifles de locos",
  // "descripción": "chifles que saben a tocino",
  // "stock": 10,
  // "precC": 12.0,
  // "precV": 14.0,
  // "codigo": 4545465456,
  // "foto": "http://localhost:9000/img/sticker.webp",
  // "id_cad": 1

  Future<List<Object>> insert(Producto prp, ValueChanged<int> accionres) async {
    if ((prp.getname != "" && prp.getname.toString().split(" ").length > 1) &&
        prp.getdesc != "" &&
        prp.getstock != 0 &&
        prp.getprecC != 0.0 &&
        (prp.getprecC <= prp.getprecV && prp.getprecV != 0) &&
        prp.getcodig != 0 &&
        prp.getfoto != "" &&
        prp.getcatego.getidcar != 0) {
      int resut = await respo.insert(prp, accionres);
      return [resut, []];
    } else {
      return [
        400,
        [
          !(prp.getname != "" && prp.getname.toString().split(" ").length > 1),
          !(prp.getdesc != ""),
          !(prp.getstock != 0),
          !(prp.getcatego.getidcar != 0),
          !(prp.getprecC != 0.0),
          !(prp.getprecC <= prp.getprecV && prp.getprecV != 0),
          !(prp.getcodig != 0),
          !(prp.getfoto != "")
        ]
      ];
    }
  }
}
