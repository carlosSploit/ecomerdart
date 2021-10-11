import '../controllers/ComentarioProd.dart';
import '../repository/comentpro_repositorio.dart';

class ComentarioProdNegocio {
  ComentarioProdRepositorio respo = ComentarioProdRepositorio();

  Future<List<ComentarioProd>> getlist(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_pro'] =
        (jsonAtri.containsKey('id_pro')) ? jsonAtri['id_pro'] : 0;
    return await respo.getlist(jsonAtri);
  }

  Future<List<Object>> agregarcategoria(ComentarioProd cat) async {
    if (cat.getmeg != "") {
      int resul = await respo.agregarcategoria(cat);
      return [resul, []];
    } else {
      return [
        400,
        [!(cat.getmeg != "")]
      ];
    }
  }
}
