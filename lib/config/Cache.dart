import '../controllers/datosuser.dart';
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
        "idinterface": lista[0].getidinterface,
        "iduser": lista[0].getiduser,
        "tipouse": lista[0].gettiouse,
        "foto": lista[0].getfoto
      });
      print("resultado - - - - - - ${this.datosuser.iduser}");
    } else {
      // cargando nuevos datos a la bd
      int result = await bd.insert(Datosuser.fromJson({
        "idclient": 0,
        "idtrabajador": 0,
        "idcarrito": 0,
        "idinterface": 0,
        "iduser": 0,
        "tipouse": "",
        "foto":
            "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg"
      }));
      print("$result -> resultado de la consulta de insercion");

      List<Datosuser> lista = await bd.list();
      if (lista.length > 0) {
        this.datosuser = Datosuser.fromJson({
          "idclient": lista[0].getidclient,
          "idtrabajador": lista[0].getidtrabajador,
          "idcarrito": lista[0].getidcarrito,
          "idinterface": lista[0].getidinterface,
          "iduser": lista[0].getiduser,
          "tipouse": lista[0].gettiouse,
          "foto": lista[0].getfoto
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
