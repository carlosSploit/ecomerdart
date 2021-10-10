import 'package:ecomersbaic/repository/repository.dart';
import 'package:ecomersbaic/Cache.dart';
import 'package:ecomersbaic/controllers/Pedido.dart';
import 'package:ecomersbaic/controllers/detalle_vent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidoRepositorio implements Repository<Pedido> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  Future<List<Pedido>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Pedido> todolist = [];
    print("${jsonAtri['iduser']}/${jsonAtri['estado']}/${jsonAtri['idpedi']}");
    print("%20");
    var url = Uri.parse(
        '$dataUrl/pedid/li/${jsonAtri['iduser']}/${jsonAtri['estado']}/${jsonAtri['idpedi']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> pedido');
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(Pedido.fromJson(body[i]));
    }
    return todolist;
  }

  Future<Pedido> read(Map<String, dynamic> jsonAtri) async {
    Pedido todolist = Pedido.fromJson({});
    var url = Uri.parse(
        '$dataUrl/pedid/${jsonAtri['id_pedido']}/${jsonAtri['tipouser']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    var body = json.decode(respose.body);
    print(respose.body);
    for (var i = 0; i < body.length; i++) {
      return todolist = Pedido.fromJson(body[i]);
    }
    return todolist;
  }

  Future<List<Dettallv>> listdet(Map<String, dynamic> jsonAtri) async {
    List<Dettallv> todolist = [];
    var url = Uri.parse('$dataUrl/pedid/${jsonAtri['id_pedido']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> read pedio');
    //print(respose.body);
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(Dettallv.fromJson(body[i]));
    }
    return todolist;
  }

  Future<int> actualiestade(Map<String, dynamic> jsonAtri) async {
    Map data = {'estado': jsonAtri['estade']};
    //encode Map to JSON
    var body = json.encode(data);

    var url = Uri.parse('$dataUrl/pedid/${jsonAtri['idpedido']}');
    var respose = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> up-pedido');
    return respose.statusCode;
  }

  Future<int> realizarpedido(Map<String, dynamic> jsonAtri) async {
    //-----------------------------------------------------------------
    Map data = {
      'id_client': jsonAtri['id_client'],
      'fecha_ent': jsonAtri['fecha_ent'],
      'lugar': jsonAtri['lugar']
    };
    //encode Map to JSON
    var body = json.encode(data);

    var url = Uri.parse('$dataUrl/pedid');
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
