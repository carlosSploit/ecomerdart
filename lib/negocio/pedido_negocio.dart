import '../repository/pedido_repositorio.dart';
import '../controllers/Pedido.dart';
import '../controllers/detalle_vent.dart';

class PedidoNegocio {
  PedidoRepositorio respo = PedidoRepositorio();

  Future<List<Pedido>> getlist(Map<String, dynamic> jsonAtri) async {
    print("${jsonAtri['idpedi']} -> problemillas ");

    jsonAtri['iduser'] = jsonAtri.containsKey('iduser')
        ? int.parse(jsonAtri['iduser'].toString())
        : 0;
    jsonAtri['estado'] = jsonAtri.containsKey('estado')
        ? int.parse(jsonAtri['estado'].toString())
        : 0;
    jsonAtri['idpedi'] =
        (jsonAtri['idpedi'] != "") ? jsonAtri['idpedi'] : "%20";

    return await respo.getlist(jsonAtri);
  }

  Future<Pedido> read(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_pedido'] = jsonAtri.containsKey('id_pedido')
        ? ((jsonAtri['id_pedido'] != "")
            ? jsonAtri['id_pedido'].toString()
            : "0")
        : "0";
    jsonAtri['tipouser'] = jsonAtri.containsKey('tipouser')
        ? ((jsonAtri['tipouser'] != "")
            ? jsonAtri['tipouser'].toString()
            : "%20")
        : "%20";
    return await respo.read(jsonAtri);
  }

  Future<List<Dettallv>> listdet(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_pedido'] = jsonAtri.containsKey('id_pedido')
        ? ((jsonAtri['id_pedido'] != "")
            ? jsonAtri['id_pedido'].toString()
            : "0")
        : "0";
    return await respo.listdet(jsonAtri);
  }

  Future<int> actualiestade(Map<String, dynamic> jsonAtri) async {
    jsonAtri['estade'] = jsonAtri.containsKey('estade')
        ? int.parse(jsonAtri['estade'].toString())
        : 0;
    jsonAtri['idpedido'] = jsonAtri.containsKey('idpedido')
        ? int.parse(jsonAtri['idpedido'].toString())
        : 0;
    return await respo.actualiestade(jsonAtri);
  }

  Future<int> realizarpedido(Map<String, dynamic> jsonAtri) async {
    jsonAtri['id_client'] = jsonAtri.containsKey('id_client')
        ? int.parse(jsonAtri['id_client'].toString())
        : 0;
    jsonAtri['fecha_ent'] = jsonAtri.containsKey('fecha_ent')
        ? ((jsonAtri['fecha_ent'] != "")
            ? jsonAtri['fecha_ent'].toString()
            : "0000/00/00")
        : "0000/00/00";
    jsonAtri['lugar'] = jsonAtri.containsKey('lugar')
        ? int.parse(jsonAtri['lugar'].toString())
        : 0;
    return await respo.realizarpedido(jsonAtri);
  }
}
