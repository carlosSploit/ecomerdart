import '../config/Cache.dart';
import '../repository/repository.dart';
import '../controllers/Carritocomp.dart';
import '../controllers/detalle_carrito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarritoConRepositorio implements Repository<Carritocomp> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  Future<List<Carritocomp>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Carritocomp> todolist = [];
    return todolist;
  }

  Future<Carritocomp> read(Map<String, dynamic> jsonAtri) async {
    Carritocomp todolist = Carritocomp.fromJson({});
    var url = Uri.parse('$dataUrl/compr/info/${jsonAtri['id_carrito']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    var body = json.decode(respose.body);
    print('status code:${respose.statusCode} -> carritod de compra');
    for (var i = 0; i < body.length; i++) {
      return todolist = Carritocomp.fromJson(body[i]);
    }
    return todolist;
  }

  Future<List<DettallCa>> listdet(Map<String, dynamic> jsonAtri) async {
    List<DettallCa> todolist = [];
    var url = Uri.parse('$dataUrl/compr/detal/${jsonAtri['id_carritos']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> read pedio');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(DettallCa.fromJson(body[i]));
    }
    return todolist;
  }

  Future<String> actualizarcatidad(Map<String, dynamic> jsonAtri) async {
    //-----------------------------------------------------------------
    Map data = {
      'id_proc': jsonAtri['idproducto'],
      'id_carr': jsonAtri['idcarrito'],
      'cant': jsonAtri['canti']
    };
    //encode Map to JSON
    var body = json.encode(data);

    var url = Uri.parse('$dataUrl/compr/0');
    var respose = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> up-pedido');
    return "Realizado Correctamente";
  }

  Future<int> deletproducto(Map<String, dynamic> jsonAtri) async {
    //-----------------------------------------------------------------
    Map data = {'id_proc': jsonAtri['id_proc']};
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/compr/${jsonAtri['idcateg']}');
    var respose = await http.delete(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> eliminarprod');
    return respose.statusCode;
  }

  Future<int> agregarproducto(Map<String, dynamic> jsonAtri) async {
    //-----------------------------------------------------------------
    Map data = {
      'id_proc': jsonAtri['id_proc'],
      'id_carr': jsonAtri['id_carr'],
      'cant': jsonAtri['cant']
    };
    //encode Map to JSON
    var body = json.encode(data);

    var url = Uri.parse('$dataUrl/compr');
    var respose = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> pedido');
    return respose.statusCode;
  }
}
