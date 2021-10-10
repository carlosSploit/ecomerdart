import 'package:ecomersbaic/controllers/datosuser.dart';
import 'bdcache.dart';

Cachememori cachememori = Cachememori();

class Cachememori {
  Future<Datosuser> extracvar() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    Datosuser datosuser = Datosuser.fromJson({});
    List<Datosuser> lista = await bd.list().then((value) {
      return value;
    });
    if (lista.length > 0) {
      datosuser = Datosuser.fromJson({
        "idclient": lista[0].getidclient,
        "idtrabajador": lista[0].getidtrabajador,
        "idcarrito": lista[0].getidcarrito,
        "iduser": lista[0].getiduser,
        "tipouse": lista[0].gettiouse
      });
      print("resultado - - - - - - ${datosuser.iduser}");
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
        datosuser = Datosuser.fromJson({
          "idclient": lista[0].getidclient,
          "idtrabajador": lista[0].getidtrabajador,
          "idcarrito": lista[0].getidcarrito,
          "iduser": lista[0].getiduser,
          "tipouse": lista[0].gettiouse
        });
      }
    }
    return datosuser;
  }
}
