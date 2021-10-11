import '../controllers/Categoria.dart';
import '../repository/Categoria_repositorio.dart';

class CategoriaNegocio {
  CategoriaRepositorio respo = CategoriaRepositorio();

  Future<List<Categoria>> getlist(Map<String, dynamic> jsonAtri) async {
    return await respo.getlist(jsonAtri);
  }

  Future<List<Object>> actualizacateoria(Categoria cat) async {
    if (cat.getname != "") {
      int resul = await respo.actualizacateoria(cat);
      return [resul, []];
    } else {
      return [
        400,
        [!(cat.getname != "")]
      ];
    }
  }

  Future<int> deletcategoria(Map<String, dynamic> jsonAtri) async {
    jsonAtri['idcateg'] = jsonAtri.containsKey('idcateg')
        ? int.parse(jsonAtri['idcateg'].toString())
        : 0;
    return await respo.deletcategoria(jsonAtri);
  }

  Future<List<Object>> agregarcategoria(Categoria cat) async {
    if (cat.getname != "") {
      int resul = await respo.agregarcategoria(cat);
      return [resul, []];
    } else {
      return [
        400,
        [!(cat.getname != "")]
      ];
    }
  }
}
