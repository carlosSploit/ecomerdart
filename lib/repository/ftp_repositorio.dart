//import 'package:ecomersbaic/repository/repository.dart';
import 'package:http_parser/http_parser.dart';
import '../config/Cache.dart';
//import 'package:ecomersbaic/models/cliente.dart';
//import 'package:get/get.dart';
import 'package:path/path.Dart';
import 'package:async/async.Dart';
import 'Dart:io';
import 'package:http/http.dart' as http;

class FtpRepositorio {
  String dataUrl = cache().getdataurl;

  Future<http.StreamedResponse> patchImage(String filepath) async {
    String url = dataUrl + "/img/insert";
    // guarda en un array toda la rua
    // ignore: non_constant_identifier_names
    List<String> Arraydat = filepath.split("/");
    String extencion = Arraydat[Arraydat.length - 1].split(".")[1];

    File imageFile = File(filepath);

    var stream =
        // ignore: deprecated_member_use
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('photo', stream, length,
        filename: basename(imageFile.path),
        contentType: MediaType('image', extencion));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    return response;
  }
}
