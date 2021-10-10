import 'package:ecomersbaic/Cache.dart';
import 'package:ecomersbaic/repository/repository.dart';
import 'package:ecomersbaic/controllers/Categoria.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriaRepositorio implements Repository<Categoria> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  Future<List<Categoria>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Categoria> todolist = [];
    var url = Uri.parse('$dataUrl/categoria');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode}'); // imprime el estatus
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(Categoria.fromJson(body[i]));
    }
    //print(jsonAtri['sape']);
    return todolist;
  }

  Future<int> actualizacateoria(Categoria cat) async {
    //-----------------------------------------------------------------
    Map data = {'nombre': cat.getname};
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/categoria/${cat.getidcar}');
    var respose = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> up-pedido');
    return respose.statusCode;
  }

  Future<int> deletcategoria(Map<String, dynamic> jsonAtri) async {
    //-----------------------------------------------------------------
    var url = Uri.parse('$dataUrl/compr/${jsonAtri['idcateg']}');
    var respose = await http.delete(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> eliminarprod');
    return respose.statusCode;
  }

  Future<int> agregarcategoria(Categoria cat) async {
    //-----------------------------------------------------------------
    Map data = {'nombre': cat.getname};
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/categoria');
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
