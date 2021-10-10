import 'package:ecomersbaic/Cache.dart';
import 'package:ecomersbaic/controllers/ComentarioProd.dart';
import 'package:ecomersbaic/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComentarioProdRepositorio implements Repository<ComentarioProd> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  Future<List<ComentarioProd>> getlist(Map<String, dynamic> jsonAtri) async {
    List<ComentarioProd> todolist = [];
    var url = Uri.parse('$dataUrl/comenpro/${jsonAtri['id_pro']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode}'); // imprime el estatus
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(ComentarioProd.fromJson(body[i]));
    }
    return todolist;
  }

  Future<int> agregarcategoria(ComentarioProd comt) async {
    //-----------------------------------------------------------------
    Map data = {
      'id_pro': comt.getprod.getidpro,
      'id_clie': comt.getclien.getidclie,
      'messe': comt.getmeg,
      'fecha': comt.getfechmess
    };
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/comenpro');
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
