import '../repository/Tiptrabajador_repositorio.dart';
import '../controllers/TipTrabajador.dart';

class TipTrabajoNegocio {
  TipTrabajoRepositorio respo = TipTrabajoRepositorio();

  Future<List<TipTrabajador>> getlist(Map<String, dynamic> jsonAtri) async {
    return await respo.getlist(jsonAtri);
  }

  Future<List<Object>> acttiptrab(TipTrabajador tip) async {
    if (tip.getnomtip != "") {
      int resul = await respo.acttiptrab(tip);
      return [resul, []];
    } else {
      return [
        400,
        [!(tip.getnomtip != "")]
      ];
    }
  }

  Future<int> delettiptrab(Map<String, dynamic> jsonAtri) async {
    jsonAtri['idtiptraba'] = jsonAtri.containsKey('idtiptraba')
        ? int.parse(jsonAtri['idtiptraba'].toString())
        : 0;
    return await respo.delettiptrab(jsonAtri);
  }

  Future<List<Object>> agregartiptrab(TipTrabajador tip) async {
    if (tip.getnomtip != "") {
      int resul = await respo.agregartiptrab(tip);
      return [resul, []];
    } else {
      return [
        400,
        [!(tip.getnomtip != "")]
      ];
    }
  }
}
