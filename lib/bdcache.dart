import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ecomersbaic/controllers/datosuser.dart';

// ignore: camel_case_types
class bd {
  bd();

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), "datosdb.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE datosusuario (id INTEGER PRIMARY KEY, idclient INTEGER, idtrabajador INTEGER, idcarrito INTEGER, iduser INTEGER, tipouse TEXT)");
    }, version: 4);
  }

  static Future<int> insert(Map<String, dynamic> jsonAtri) async {
    Database database = await _openDB();
    return database.insert("datosusuario", jsonAtri);
  }

  static Future<int> update(Map<String, dynamic> jsonAtri) async {
    Database database = await _openDB();
    return database
        .update("datosusuario", jsonAtri, where: "id = ?", whereArgs: [1]);
  }

  static Future<int> delect(Map<String, dynamic> jsonAtri) async {
    Datosuser datosnulos = Datosuser.fromJson({});
    Database database = await _openDB();
    return database.update("datosusuario", datosnulos.toJson(),
        where: "id = ?", whereArgs: [1]);
  }

  static Future<List<Datosuser>> list() async {
    Database database = await _openDB();
    // ignore: non_constant_identifier_names
    final List<Map<String, dynamic>> Datosusermap =
        await database.query("datosusuario");

    return List.generate(
      Datosusermap.length,
      (index) => Datosuser.fromJson({
        "idclient": Datosusermap[index]['idclient'],
        "idtrabajador": Datosusermap[index]['idtrabajador'],
        "idcarrito": Datosusermap[index]['idcarrito'],
        "iduser": Datosusermap[index]['iduser'],
        "tipouse": Datosusermap[index]['tipouse']
      }),
    );
  }

  static Future<int> length() async {
    Database database = await _openDB();
    // ignore: non_constant_identifier_names
    final List<Map<String, dynamic>> Datosusermap =
        await database.query("datosusuario");

    return Datosusermap.length;
  }
}
