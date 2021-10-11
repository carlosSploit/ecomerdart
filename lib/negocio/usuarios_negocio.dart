import '../controllers/datosuser.dart';
import '../repository/usuarios_repositorio.dart';
import '../controllers/trabajador.dart';

class UsuarioNegocio {
  UsuarioRepositorio respo = UsuarioRepositorio();

  // se usa el objeto cliente para hacer la imprecion en usuario
  Future<List<Trabajador>> getlist(Map<String, dynamic> jsonAtri) async {
    return await respo.getlist(jsonAtri);
  }

  Future<Datosuser> read(Map<String, dynamic> jsonAtri) async {
    jsonAtri['usser'] = jsonAtri.containsKey('usser')
        ? ((jsonAtri['usser'] != "") ? jsonAtri['usser'].toString() : "%20")
        : "%20";
    jsonAtri['pass'] = jsonAtri.containsKey('pass')
        ? ((jsonAtri['pass'] != "") ? jsonAtri['pass'].toString() : "%20")
        : "%20";
    return respo.read(jsonAtri);
  }
}
