import '../controllers/datosuser.dart';
import '../repository/repository.dart';
//import 'package:flutter/cupertino.dart';
//import 'ftp_repositorio.dart';
import '../config/Cache.dart';
import '../controllers/trabajador.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioRepositorio implements Repository<Trabajador> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  // se usa el objeto cliente para hacer la imprecion en usuario
  Future<List<Trabajador>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Trabajador> todolist = [];
    return todolist;
  }

  Future<Datosuser> read(Map<String, dynamic> jsonAtri) async {
    Datosuser todolist = Datosuser.fromJson({});
    var url = Uri.parse(
        '$dataUrl/usse/check/${jsonAtri['usser']}/${jsonAtri['pass']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> usuario');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      return todolist = Datosuser.fromJson({
        "idclient": (body[i].containsKey("idclient")) ? body[i]['idclient'] : 0,
        "idtrabajador":
            (body[i].containsKey("idtrabajador")) ? body[i]['idtrabajador'] : 0,
        "idcarrito":
            (body[i].containsKey("idcarrito")) ? body[i]['idcarrito'] : 0,
        "iduser": (body[i].containsKey("iduser")) ? body[i]['iduser'] : 0,
        "tipouse": (body[i].containsKey("tipouse")) ? body[i]['tipouse'] : ""
      });
    }
    return todolist;
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    Datosuser todolist = Datosuser.fromJson({});
    var url = Uri.parse('$dataUrl/usse/${jsonAtri['idusser']}');
    var respose = await http.delete(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> usuario delect');
    return respose.statusCode;
  }
}
