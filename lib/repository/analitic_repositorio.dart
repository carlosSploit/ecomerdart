import '../config/Cache.dart';
import '../controllers/Analitic.dart';
import '../repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnaliticRepositorio implements Repository<Analitic> {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  Future<List<Analitic>> getlist(Map<String, dynamic> jsonAtri) async {
    List<Analitic> todolist = [];
    var url = Uri.parse('$dataUrl/analit/${jsonAtri['tipo']}');
    var respose = await http.get(url, headers: {"Authorization": "$apikey"});
    print('status code:${respose.statusCode} -> analiticas correcto'); // imprime el estatus
    var body = json.decode(respose.body);
    //print("${respose.body}");
    for (var i = 0; i < body.length; i++) {
      todolist.add(Analitic.fromJson(body[i]));
    }
    todolist = todolist.reversed.toList();
    //print(jsonAtri['sape']);
    return todolist;
  }
}
