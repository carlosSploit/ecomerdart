import '../repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'ftp_repositorio.dart';
import '../controllers/Producto.dart';
import '../config/Cache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductoRepositorio implements Repository<Producto> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;
  var ftp = FtpRepositorio();

  Future<List<Producto>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Producto> todolist = [];
    var url = Uri.parse(
        '$dataUrl/prod/l/${jsonAtri['iduser']}/${jsonAtri['idcate']}/${jsonAtri['namepe']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> producto');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(Producto.fromJson(body[i]));
    }
    return todolist;
  }

  Future<Producto> read(Map<String, dynamic> jsonAtri) async {
    Producto todolist = Producto.fromJson({});
    var url = Uri.parse(
        '$dataUrl/prod/${jsonAtri['id_prod']}/${jsonAtri['id_clin']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    var body = json.decode(respose.body);

    for (var i = 0; i < body.length; i++) {
      return todolist = Producto.fromJson(body[i]);
    }
    return todolist;
  }

  // presenta un error en el carrito de compra
  // value change servira para realizar una accion en caso que se requiera
  Future<int> update(Producto uss, ValueChanged<int> accs) async {
    if (uss.getfoto != "") {
      http.StreamedResponse respo = await ftp.patchImage(uss.getfoto);
      String respode = await respo.stream.transform(utf8.decoder).last;
      var jsonresult = json.decode(respode);
      String urlres = "http://" + jsonresult["url"];
      print("$urlres");
      Map data = {
        'nombre': uss.getname,
        'descripción': uss.getdesc,
        'stock': uss.getstock,
        'precC': uss.getprecC,
        'precV': uss.getprecV,
        'codigo': uss.getcodig,
        'foto': urlres,
        'id_cad': uss.getcatego.getidcar
      };
      //encode Map to JSON
      var body = json.encode(data);
      var url = Uri.parse('$dataUrl/prod/${uss.getidpro}');
      var respose = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "$apikey"
          },
          body: body);
      print('status code:${respose.statusCode} -> producto');
      accs(0);
      return respose.statusCode;
    } else {
      // print(
      //     "${uss.getidpro} - ${uss.getname} -${uss.getdesc} -${uss.getstock} -${uss.getprecC} - ${uss.getprecV} - ${uss.getcodig} - ${uss.getcatego.getidcar} -");

      Map data = {
        'nombre': uss.getname,
        'descripción': uss.getdesc,
        'stock': uss.getstock,
        'precC': uss.getprecC,
        'precV': uss.getprecV,
        'codigo': uss.getcodig,
        'foto': "",
        'id_cad': uss.getcatego.getidcar
      };
      //encode Map to JSON
      var body = json.encode(data);
      var url = Uri.parse('$dataUrl/prod/${uss.getidpro}');
      var respose = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "$apikey"
          },
          body: body);
      print('status code:${respose.statusCode} -> update prodcuto');
      accs(0);
      return respose.statusCode;
    }
  }

  Future<int> insert(Producto prp, ValueChanged<int> accionres) async {
    http.StreamedResponse respo = await ftp.patchImage(prp.getfoto);
    String respode = await respo.stream.transform(utf8.decoder).last;

    var jsonresult = json.decode(respode);
    String urlres = "http://" + jsonresult["url"];
    Map data = {
      'nombre': prp.getname,
      'descripción': prp.getdesc,
      'stock': prp.getstock,
      'precC': prp.getprecC,
      'precV': prp.getprecV,
      'codigo': prp.getcodig,
      'foto': urlres,
      'id_cad': prp.getcatego.getidcar
    };
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/prod');
    var respose = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> calificar');
    accionres(0);

    return respose.statusCode;
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    var url = Uri.parse('$dataUrl/prod/${jsonAtri['idproducto']}');
    var respose = await http.delete(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> producto delect');
    return respose.statusCode;
  }
}
