import 'package:ecomersbaic/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'ftp_repositorio.dart';
import 'package:ecomersbaic/Cache.dart';
import 'package:ecomersbaic/controllers/trabajador.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrabajadorRepositorio implements Repository<Trabajador> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;
  var ftp = FtpRepositorio();

  // se usa el objeto cliente para hacer la imprecion en usuario
  Future<List<Trabajador>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Trabajador> todolist = [];
    var url = Uri.parse(
        '$dataUrl/usse/list/${jsonAtri['tipous']}/${jsonAtri['name']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> usuario');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(Trabajador.fromJson(body[i]));
    }
    return todolist;
  }

  Future<Trabajador> read(Map<String, dynamic> jsonAtri) async {
    Trabajador todolist = Trabajador.fromJson({});
    var url = Uri.parse('$dataUrl/usse/read/${jsonAtri['iduser']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> usuario');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      return todolist = Trabajador.fromJson(body[i]);
    }
    return todolist;
  }

  Future<int> update(Trabajador uss, ValueChanged<int> accionres) async {
    if (uss.getfoto != "") {
      //##########################################################
      http.StreamedResponse respo = await ftp.patchImage(uss.getfoto);
      String respode = await respo.stream.transform(utf8.decoder).last;
      var jsonresult = json.decode(respode);
      String urlres = "http://" + jsonresult["url"];
      Map data = {
        'nombre': uss.getnombre,
        'numero': uss.getcelula,
        'correo': uss.getcorreo,
        'id_tiptraba': uss.gettiptranba.getidtrab,
        'photo': urlres
      };
      //encode Map to JSON
      var body = json.encode(data);
      var url = Uri.parse('$dataUrl/trabaj/${uss.getidusua}');
      var respose = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "$apikey"
          },
          body: body);
      print('status code:${respose.statusCode} -> calificar');
      accionres(0);
      return respose.statusCode;
      //##########################################################
    } else {
      Map data = {
        'nombre': uss.getnombre,
        'numero': uss.getcelula,
        'correo': uss.getcorreo,
        'id_tiptraba': uss.gettiptranba.getidtrab,
        'photo': ""
      };
      //encode Map to JSON
      var body = json.encode(data);
      var url = Uri.parse('$dataUrl/trabaj/${uss.getidusua}');
      var respose = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "$apikey"
          },
          body: body);
      print('status code:${respose.statusCode} -> update trabajador');
      accionres(0);
      return respose.statusCode;
    }
  }

  Future<int> insert(Trabajador trap, ValueChanged<int> accionres) async {
    http.StreamedResponse respo = await ftp.patchImage(trap.getfoto);
    String respode = await respo.stream.transform(utf8.decoder).last;
    var jsonresult = json.decode(respode);
    String urlres = "http://" + jsonresult["url"];
    Map data = {
      'usser': trap.getusser,
      'pass': trap.getpass,
      'nombre': trap.getnombre,
      'numero': trap.getcelula,
      'correo': trap.getcorreo,
      'id_tiptraba': trap.gettiptranba.getidtrab,
      'photo': urlres
    };
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/trabaj');
    var respose = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "application/json"
        },
        body: body);
    print('status code:${respose.statusCode} -> update trabajador');
    accionres(0);

    return respose.statusCode;
  }
}
