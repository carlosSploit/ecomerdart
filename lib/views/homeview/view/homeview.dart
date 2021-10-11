import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import '../../../controllers/Categoria.dart';
import '../../../controllers/Producto.dart';
import '../../../controllers/datosuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../views/homeview/components/productview.dart';
import '../../../negocio/Categoria_negocio.dart';
import '../../../negocio/producto_negocio.dart';

// ignore: camel_case_types
class homeview extends StatefulWidget {
  @override
  homebody createState() => homebody();
}

// ignore: camel_case_types
class homebody extends State<homeview> {
  int _selexidcateg = 0;
  Datosuser? controller;
  late configinterface config;

  void actualic(int index) {
    setState(() {});
    _selexidcateg = index;
  }

  late TextEditingController textEditingController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    //print("cargando el usuario --------------- ${cachememori.getidusser}");
    var conte2 = 0; //impares
    var conte = 0; //pares
    var size = MediaQuery.of(context).size;
    var catres = CategoriaNegocio();
    var prores = ProductoNegocio();
    var control = cache();
    config = configinterface(context);
    //####################################

    return FutureBuilder<Datosuser>(
        future: control.extracvar(),
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
          var list = snapshot.data ?? Datosuser.fromJson({});
          //####################################
          this.controller = list; //inicializamos la cache
          //####################################
          return new Column(
            //controller: _scrollController,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: size.width,
                height: config.getsizeaproxhight(50),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: config.getsizeaproxhight(Size.fromHeight(105.0).height),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: InkWell(
                                child: Icon(
                                  Icons.search,
                                  size: config.getsizeaproxhight(25),
                                  color: Colors.grey[600],
                                ),
                                onTap: () {
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: config.getsizeaproxhight(15),
                                  ),
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      border: InputBorder.none,
                                      hintText: 'Escribe el producto a buscar'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff707070).withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: size.width,
                //height: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    //height: Size.fromHeight(105.0).height,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                child: Text(
                                  "Categorias",
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: config.getsizeaproxhight(25)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //contenedor de la categoritas
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: FutureBuilder<List<Categoria>>(
                                future: catres.getlist({}),
                                builder: (context, snapshot) {
                                  //validadores del estado------------------------
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Align(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          "Error al cargar las categorias"),
                                    );
                                  }
                                  //------------------------------------------------
                                  //capturar las categorias
                                  var list = snapshot.data?.length ?? 0;
                                  List<Widget> cat = [];
                                  // inicializar las categorias
                                  cat.add(_buildChip(
                                      0, "Todos", Color(0xff707070)));
                                  for (var i = 0; i < list; i++) {
                                    var catg = snapshot.data?[i];

                                    cat.add(_buildChip(catg?.getidcar,
                                        catg?.getname, Color(0xff707070)));
                                  }
                                  return Container(
                                    height: config.getsizeaproxhight(60),
                                    margin: EdgeInsets.fromLTRB(0, 8, 0, 10),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: cat,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //######################################################################
              FutureBuilder<List<Producto>>(
                future: prores.getlist({
                  "idcate": _selexidcateg,
                  "iduser": controller!.getidclient,
                  "namepe": textEditingController.text
                }), // envia parametros
                builder: (context, snapshot) {
                  //validadores del estado------------------------

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Error al listar los productos"),
                      ),
                    );
                  }
                  //------------------------------------------------
                  //capturar las categorias
                  var list = snapshot.data?.length ?? 0;
                  List<Widget> cat = [];
                  for (var i = 0; i < list; i++) {
                    var prod = snapshot.data?[i];
                    print("${prod?.getlcalif}");
                    cat.add(publicaitenview(
                        prod?.getlove,
                        config.getsizeaproxhight(300).toInt(),
                        prod?.getname,
                        prod?.getfoto.replaceAll(
                                "localhost:9000", control.getdomain.toString())
                            as String,
                        prod?.getdesc,
                        prod?.getprecV * 1.0,
                        prod?.getidpro,
                        prod?.getlcalif,
                        prod?.getstock, (a) {
                      setState(() {});
                    }));
                  }
                  // Contenedor de los productos
                  //conte = ((list / 2) * (300)).toInt() + 70;

                  for (var i = 0; i < cat.length; i++) {
                    if (i % 2 == 0) {
                      conte += config.getsizeaproxhight(300).toInt() + 10;
                    } else {
                      conte2 += config.getsizeaproxhight(300).toInt() + 10;
                    }
                  }

                  conte += 70;

                  if (!((conte) > conte2)) {
                    conte = conte2;
                    print("sap: " + conte.toString());
                  }

                  return (cat.length > 0)
                      ? Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: conte * 1.0,
                          color: Colors.white,
                          child: new StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            itemCount: cat.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                //######### texto de informacion del cantidad del producto
                                return Container(
                                  width: 200,
                                  height: config.getsizeaproxhight(70),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Productos",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontSize: config.getsizeaproxhight(30),
                                        ),
                                      ),
                                      Text(
                                        "${cat.length} resultados",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: config.getsizeaproxhight(30),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                //#########################################################
                              }
                              //######### iten ingrsado
                              //print('producto indes: $index');
                              return cat[index - 1];
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(1),
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 12.0,
                          ),
                        )
                      : Container(
                          //color: Colors.amber,
                          height: size.height - 300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("No hay productos we"),
                          ),
                        );
                },
              ),
              //######################################################################
            ],
          );
        });
  }

  // cart de cada categoria, el cual actualizara el estado
  Widget _buildChip(int idexcat, String label, Color color) {
    return InkWell(
      onTap: () {
        actualic(idexcat);
        print(this._selexidcateg);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Chip(
          labelPadding: EdgeInsets.all(2.0),
          avatar: CircleAvatar(
            backgroundColor:
                (this._selexidcateg == idexcat) ? Colors.white : color,
            child: Text(
              label[0].toUpperCase(),
              style: TextStyle(
                  fontSize: config.getsizeaproxhight(15),
                  color:
                      (this._selexidcateg == idexcat) ? color : Colors.white),
            ),
          ),
          label: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: config.getsizeaproxhight(15),
                color: (this._selexidcateg == idexcat) ? Colors.white : color,
              ),
            ),
          ),
          backgroundColor:
              (this._selexidcateg == idexcat) ? color : Colors.white,
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          padding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
