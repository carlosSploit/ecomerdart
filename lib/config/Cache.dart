import 'package:ecomersbaic/controllers/datosuser.dart';
import 'package:get/get.dart';
import 'bdcache.dart';

cache cachememori = cache();

// ignore: camel_case_types
class cache extends GetxController {
  Datosuser datosuser = Datosuser();
  String dataUrl = 'http://192.168.0.7:9000';
  String domainimg = '192.168.0.7:9000';
  String apikey =
      'Bearer  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTYzMzI5ODcyM30.ux9bfqNnJznP5t6jX8yid56R2_zGhcFIUtQrYZaWP7A';

  get getidclienr => this.datosuser.getidclient;
  get getidcarrit => this.datosuser.getidcarrito;
  get getidusser => this.datosuser.getiduser;
  get getidtrabajador => this.datosuser.getidtrabajador;
  get gettipoes => this.datosuser.gettiouse;
  String get getdataurl => this.dataUrl;
  String get getdomain => this.domainimg;
  get getapikey => this.apikey;

  @override
  void onInit() async {
    super.onInit();
    print("funciona guchi");
    await _extracvar();
  }

  // @override
  // void onReady() async {
  //   super.onReady();
  //   await _extracvar();
  // }

  _extracvar() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Datosuser> lista = await bd.list().then((value) {
      return value;
    });
    if (lista.length > 0) {
      this.datosuser = Datosuser.fromJson({
        "idclient": lista[0].getidclient,
        "idtrabajador": lista[0].getidtrabajador,
        "idcarrito": lista[0].getidcarrito,
        "iduser": lista[0].getiduser,
        "tipouse": lista[0].gettiouse
      });
      print("resultado - - - - - - ${this.datosuser.iduser}");
    } else {
      // cargando nuevos datos a la bd
      int result = await bd.insert({
        "idclient": 0,
        "idtrabajador": 0,
        "idcarrito": 0,
        "iduser": 0,
        "tipouse": ""
      });
      print("$result -> resultado de la consulta de insercion");

      List<Datosuser> lista = await bd.list();
      if (lista.length > 0) {
        this.datosuser = Datosuser.fromJson({
          "idclient": lista[0].getidclient,
          "idtrabajador": lista[0].getidtrabajador,
          "idcarrito": lista[0].getidcarrito,
          "iduser": lista[0].getiduser,
          "tipouse": lista[0].gettiouse
        });
      }
    }
    update();
  }

  // extraido para los metodo future
  Future<Datosuser> extracvar() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    await _extracvar();
    return this.datosuser;
  }

  cerrar() {}
}
