import '../controllers/Analitic.dart';
import '../repository/analitic_repositorio.dart';

class AnaliticNegocio {
  AnaliticRepositorio respo = AnaliticRepositorio();

  Future<List<Analitic>> getlist(Map<String, dynamic> jsonAtri) async {
    jsonAtri['tipo'] = jsonAtri.containsKey('tipo')? jsonAtri['tipo'] : 0;
    print("${jsonAtri['tipo']} -> analiticas");
    return respo.getlist(jsonAtri);
  }
}
