import 'package:ecomersbaic/controllers/Analitic.dart';
import 'package:ecomersbaic/repository/analitic_repositorio.dart';

class AnaliticNegocio {
  AnaliticRepositorio respo = AnaliticRepositorio();

  Future<List<Analitic>> getlist(Map<String, dynamic> jsonAtri) async {
    jsonAtri['tipo'] = jsonAtri.containsKey('tipo')? jsonAtri['tipo'] : 0;
    print("${jsonAtri['tipo']} -> analiticas");
    return respo.getlist(jsonAtri);
  }
}
