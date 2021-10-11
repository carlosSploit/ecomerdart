import '../repository/califipro_repositorio.dart';

class CalifiproNegocio {
  CalifiproRepositorio respo = CalifiproRepositorio();

  Future<String> calificarpro(Map<String, dynamic> jsonAtri) async {
    jsonAtri['idpro'] = (jsonAtri.containsKey("idpro"))
        ? int.parse(jsonAtri['idpro'].toString())
        : 0;
    jsonAtri['idcli'] = (jsonAtri.containsKey("idcli"))
        ? int.parse(jsonAtri['idcli'].toString())
        : 0;
    return await respo.calificarpro(jsonAtri);
  }

  Future<String> deletcalificarpro(Map<String, dynamic> jsonAtri) async {
    jsonAtri['idpro'] = (jsonAtri.containsKey("idpro"))
        ? int.parse(jsonAtri['idpro'].toString())
        : 0;
    jsonAtri['idcli'] = (jsonAtri.containsKey("idcli"))
        ? int.parse(jsonAtri['idcli'].toString())
        : 0;
    return await respo.deletcalificarpro(jsonAtri);
  }
}
