import '../repository/repository.dart';
import '../controllers/TipTrabajador.dart';
import '../config/Cache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipTrabajoRepositorio implements Repository<TipTrabajador> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  Future<List<TipTrabajador>> getlist(Map<String, dynamic> jsonAtri) async {
    List<TipTrabajador> todolist = [];
    var url = Uri.parse('$dataUrl/tiptrab');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode}'); // imprime el estatus
    var body = json.decode(respose.body);
    for (var i = 0; i < body.length; i++) {
      todolist.add(TipTrabajador.fromJson(body[i]));
    }
    //print(jsonAtri['sape']);
    return todolist;
  }

  Future<int> acttiptrab(TipTrabajador tip) async {
    //-----------------------------------------------------------------
    Map data = {'nombre': tip.getnomtip};
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/tiptrab/${tip.getidtrab}');
    var respose = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> up-pedido');
    return respose.statusCode;
  }

  Future<int> delettiptrab(Map<String, dynamic> jsonAtri) async {
    //-----------------------------------------------------------------
    var url = Uri.parse('$dataUrl/tiptrab/${jsonAtri['idtiptraba']}');
    var respose = await http.delete(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> eliminarprod');
    return respose.statusCode;
  }

  Future<int> agregartiptrab(TipTrabajador tip) async {
    //-----------------------------------------------------------------
    Map data = {'nombre': tip.getnomtip};
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/tiptrab');
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
