import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecomersbaic/Cache.dart';

class CalifiproRepositorio {
  String dataUrl = cache().getdataurl;
  String apikey = cache().getapikey;

  Future<String> calificarpro(Map<String, dynamic> jsonAtri) async {
    //-----------------------------------------------------------------
    Map data = {'idpro': jsonAtri['idpro'], 'idcli': jsonAtri['idcli']};
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/calipr');
    var respose = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> calificar');
    return "Realizado Correctamente";
  }

  Future<String> deletcalificarpro(Map<String, dynamic> jsonAtri) async {
    Map data = {'idpro': jsonAtri['idpro']};
    //encode Map to JSON
    var body = json.encode(data);
    var url = Uri.parse('$dataUrl/calipr/${jsonAtri['idcli']}');
    var respose = await http.delete(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$apikey"
        },
        body: body);
    print('status code:${respose.statusCode} -> calificar');
    return "Realizado Correctamente";
  }
}
