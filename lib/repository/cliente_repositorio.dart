import '../repository/repository.dart';
import '../controllers/cliente.dart';
import '../config/Cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ftp_repositorio.dart';

class ClienteRepositorio implements Repository<Cliente> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;
  var ftp = FtpRepositorio();

  // se usa el objeto cliente para hacer la imprecion en usuario
  Future<List<Cliente>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Cliente> todolist = [];
    var url = Uri.parse(
        '$dataUrl/usse/list/${jsonAtri['tipous']}/${jsonAtri['name']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> usuario');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(Cliente.fromJson(body[i]));
    }
    return todolist;
  }

  Future<Cliente> read(Map<String, dynamic> jsonAtri) async {
    Cliente todolist = Cliente.fromJson({});
    var url = Uri.parse('$dataUrl/usse/read/${jsonAtri['iduser']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> usuario');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      return todolist = Cliente.fromJson(body[i]);
    }
    return todolist;
  }

  Future<int> insert(Cliente trap, ValueChanged<int> accionres) async {
    Map data = {
      'usser': trap.getusser,
      'pass': trap.getpass,
      'nombre': trap.getnombre,
      'numero': trap.getcelula,
      'correo': trap.getcorreo,
      'direccion': trap.getdirecc,
      'direccion_alterna': trap.gedirec_a,
      'photo': "http://localhost:9000/img/sticker.webp"
    };
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/client');
    var respose = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> insertar cliente');

    return respose.statusCode;
  }

  Future<int> update(Cliente uss, ValueChanged<int> accionres) async {
    //     "nombre: ${uss.getnombre} , numero: ${uss.getcelula}, correo: ${uss.getcorreo}, direccion: ${uss.getdirecc}, direccion_alterna: ${uss.gedirec_a}, photo: ${uss.getfoto}");
    // print("${uss.getidusua}");

    if (uss.getfoto != "") {
      http.StreamedResponse respo = await ftp.patchImage(uss.getfoto);
      String respode = await respo.stream.transform(utf8.decoder).last;
      var jsonresult = json.decode(respode);
      String urlres = "http://" + jsonresult["url"];
      Map data = {
        'nombre': uss.getnombre,
        'numero': uss.getcelula,
        'correo': uss.getcorreo,
        'direccion': uss.getdirecc,
        'direccion_alterna': uss.gedirec_a,
        'photo': urlres
      };
      //encode Map to JSON
      var body = json.encode(data);
      var url = Uri.parse('$dataUrl/client/${uss.getidusua}');
      var respose = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "$apikey"
          },
          body: body);
      print('status code:${respose.statusCode} -> calificar');
      accionres(0);
      return respose.statusCode;
    } else {
      Map data = {
        'nombre': uss.getnombre,
        'numero': uss.getcelula,
        'correo': uss.getcorreo,
        'direccion': uss.getdirecc,
        'direccion_alterna': uss.gedirec_a,
        'photo': ""
      };
      //encode Map to JSON
      var body = json.encode(data);
      var url = Uri.parse('$dataUrl/client/${uss.getidusua}');
      var respose = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "$apikey"
          },
          body: body);
      print('status code:${respose.statusCode} -> calificar');
      accionres(0);
      return respose.statusCode;
    }
  }
}
