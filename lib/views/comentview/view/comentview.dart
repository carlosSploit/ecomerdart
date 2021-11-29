// ignore_for_file: must_be_immutable

import 'package:ecomersbaic/config/bdcache.dart';

import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import '../../../controllers/ComentarioProd.dart';
import '../../../controllers/datosuser.dart';
import '../../../main.dart';
import '../../../negocio/comentpro_negocio.dart';
import '../../../views/components/mensajealert.dart';
import '../../../views/homeview/view/mainproductoview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../views/comentview/components/comentarioitenview.dart';

// ignore: camel_case_types
class comentview extends StatefulWidget {
  int idproducto;
  comentview(this.idproducto);

  @override
  comentbody createState() => comentbody();
}

// ignore: camel_case_types
class comentbody extends State<comentview> {
  ComentarioProdNegocio pedres = ComentarioProdNegocio();
  Future<List<ComentarioProd>>? comentarios;
  TextEditingController tec = TextEditingController(text: "");
  cache memori = cache();
  Future<Datosuser>? _datoscontroller;
  BuildContext? _context;
  late configinterface config;
  comentbody();

  @override
  void initState() {
    _datoscontroller = memori.extracvar();
    cargardatos();
    super.initState();
  }

  void cargardatos() {
    comentarios = pedres.getlist({"id_pro": widget.idproducto});
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    config = configinterface(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () async {
            Datosuser dat = await memori.extracvar();
            if (dat.gettiouse == "C") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => mainproductoview(widget.idproducto)),
              );
            } else {
              // estraer memoria cache
              List<Datosuser> lista = await bd.list();
              // redireccionar con la memoria
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp(lista[0].getidinterface)),
              );
            }
          },
        ),
        backgroundColor: Colors.white,
        title: Container(
          width: 200,
          child: Text(
            "Comentarios",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<ComentarioProd>>(
              future: pedres.getlist({"id_pro": widget.idproducto}),
              builder: (context, snapshot) {
                //validadores del estado------------------------
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error al cargar las categorias"),
                  );
                }
                //------------------------------------------------
                //capturar las categorias
                var list = snapshot.data?.length ?? 0;
                List<Widget> cat = [];
                for (var i = 0; i < list; i++) {
                  var catg = snapshot.data?[i] ?? ComentarioProd.fromJson({});
                  print("${catg.getmeg}");
                  cat.add(
                    comentarioitenview(
                        true,
                        catg.getclien.getnombre,
                        catg.getmeg,
                        catg.getfechmess,
                        (catg.getclien.getfoto as String)),
                  );
                }

                print("${cat.length}");

                return (cat.length != 0)
                    ? Expanded(
                        flex: 10,
                        child: Container(
                          color: Colors.white,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: cat,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.feedback_outlined,
                                  size: 70,
                                  color: Color(0xff707070),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Text("No hay comentarios en bandeja"),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
            FutureBuilder<Datosuser>(
              future: _datoscontroller, // envia parametros
              builder: (context, snapshot) {
                //validadores del estado------------------------

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Error al listar los productos"),
                    ),
                  );
                }
                //------------------------------------------------
                //capturar las categorias
                var list = snapshot.data ?? Datosuser.fromJson({});
                //control.update();
                if (list.gettiouse == "T") return Container();
                return Container(
                  height: config.getsizeaproxhight(60),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        //imagen del usuario
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            //height: double.maxFinite,
                            child: Container(
                              width: config.getsizeaproxhight(40),
                              height: config.getsizeaproxhight(40),
                              //image de contenido
                              child: Center(
                                child: Container(
                                  width: config.getsizeaproxhight(37),
                                  height: config.getsizeaproxhight(37),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: new Border.all(
                                        color: Colors.white, width: 2),
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                        "${list.getfoto}",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextField(
                              controller: tec,
                              style: TextStyle(
                                  fontSize: config.getsizeaproxhight(14)),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Please enter a search term'),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                            child: Text(
                              "Publicar",
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: config.getsizeaproxhight(14)),
                            ),
                          ),
                          onTap: () {
                            insercat();
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void insercat() async {
    //print(controller.getidusser);
    Datosuser dat = await memori.extracvar();
    List<Object> stado = await pedres.agregarcategoria(ComentarioProd.fromJson({
      "id_pro": widget.idproducto,
      "id_clie": dat.getidclient,
      "messe": tec.text
    }));
    switch ((stado[0] as int)) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a insertado la categoria correctamente", "T");
        tec.text = "";
        setState(() {});
        break;
      default:
        tec.text = "";
        setState(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
    }
  }
}
