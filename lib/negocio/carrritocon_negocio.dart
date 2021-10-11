import '../repository/carrritocon_repositorio.dart';
import '../controllers/Carritocomp.dart';
import '../controllers/detalle_carrito.dart';

class CarritoConNegocio {
  CarritoConRepositorio respo = CarritoConRepositorio();

  Future<List<Carritocomp>> getlist(Map<String, dynamic> jsonAtri) async {
    return await respo.getlist(jsonAtri);
  }

  Future<Carritocomp> read(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_carrito'] = jsonAtri.containsKey('id_carrito')
        ? jsonAtri['id_carrito'].toString()
        : "0";
    return await respo.read(jsonAtri);
  }

  Future<List<DettallCa>> listdet(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_carritos'] = jsonAtri.containsKey('id_carritos')
        ? jsonAtri['id_carritos'].toString()
        : "0";
    return await respo.listdet(jsonAtri);
  }

  Future<String> actualizarcatidad(Map<String, dynamic> jsonAtri) async {
    jsonAtri['idcarrito'] = jsonAtri.containsKey('idcarrito')
        ? int.parse(jsonAtri['idcarrito'].toString())
        : 0;
    jsonAtri['idproducto'] = jsonAtri.containsKey('idproducto')
        ? int.parse(jsonAtri['idproducto'].toString())
        : 0;
    jsonAtri['canti'] = jsonAtri.containsKey('canti')
        ? int.parse(jsonAtri['canti'].toString())
        : 0;
    return await respo.actualizarcatidad(jsonAtri);
  }

  Future<int> deletproducto(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_proc'] = jsonAtri.containsKey('id_proc')
        ? int.parse(jsonAtri['id_proc'].toString())
        : 0;
    jsonAtri['idcateg'] = jsonAtri.containsKey('idcateg')
        ? int.parse(jsonAtri['idcateg'].toString())
        : 0;
    return await respo.deletproducto(jsonAtri);
  }

  Future<int> agregarproducto(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_proc'] = jsonAtri.containsKey('id_proc')
        ? int.parse(jsonAtri['id_proc'].toString())
        : 0;
    jsonAtri['id_carr'] = jsonAtri.containsKey('id_carr')
        ? int.parse(jsonAtri['id_carr'].toString())
        : 0;
    jsonAtri['cant'] = jsonAtri.containsKey('cant')
        ? int.parse(jsonAtri['cant'].toString())
        : 0;
    return await respo.agregarproducto(jsonAtri);
  }
}
