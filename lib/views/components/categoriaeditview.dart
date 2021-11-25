import '../../config/configinterface.dart';
import '../../controllers/Categoria.dart';
import '../../negocio/Categoria_negocio.dart';
import '../../views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Categoria _tipocat = Categoria(0, "");
TextEditingController listcontroler = TextEditingController(text: "");
bool toquenedit1 = true;

// ignore: camel_case_types, must_be_immutable
class categoriaeditview extends StatefulWidget {
  ValueChanged<int> accionrecarga;

  // memoria cache de los itens de cliente y trabajador
  //---------------------------------------------------
  var state;
  //var pedres;
  CategoriaNegocio restiptrab = CategoriaNegocio();
  //int id_edittext = -1;
  String tipo = "";
  var controller;
  String path = "";
  BuildContext? _context;
  bool stadevalue = false; //detecta el estado de la casilla
  late configinterface config;
  categoriaeditview(this.accionrecarga);

  // tipo de trabajador
  Categoria tipotrab = Categoria.fromJson({});
  List<Categoria> memortiRecar = [];

  //################### Action de tipo de trabajo ##################
  List<DropdownMenuItem<Categoria>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Categoria>> items = [];
    for (Categoria company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(
            company.getname,
            style: TextStyle(fontSize: config.getsizeaproxhight(14)),
          ),
        ),
      );
    }
    return items;
  }

  void onChangeDropdownItem(Categoria selectedCompany) {
    tipotrab = selectedCompany;
    print("${tipotrab.getidcar} -> se selecciono");
    state(() {});
  }

  @override
  contentserbody createState() => contentserbody();

  createDialog(BuildContext context) {
    config = configinterface(context);
    var size = MediaQuery.of(context).size;
    //pedres = ProductoRepositorio();
    restiptrab = CategoriaNegocio();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        this._context = context;
        return StatefulBuilder(
          builder: (context, setState) {
            state = setState;
            return AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: EdgeInsets.all(0),
              content: Container(
                  child: Stack(
                children: [
                  Container(
                    height: config.getsizeaproxhight(169),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: size.width,
                        height: config.getsizeaproxhight(169),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: config.getsizeaproxhight(34) +
                                    config.getsizeaproxhight(10) +
                                    config.getsizeaproxhight(10),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    15,
                                    config.getsizeaproxhight(10),
                                    15,
                                    config.getsizeaproxhight(10)),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          //color: Colors.amber,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Container(
                                                        height: config
                                                            .getsizeaproxhight(
                                                                40),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        0),
                                                                child: FutureBuilder<
                                                                    List<
                                                                        Categoria>>(
                                                                  future: restiptrab
                                                                      .getlist(
                                                                          {}),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    //validadores del estado------------------------
                                                                    if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return Align(
                                                                          alignment: Alignment
                                                                              .center,
                                                                          child:
                                                                              CircularProgressIndicator());
                                                                    }
                                                                    if (snapshot
                                                                        .hasError) {
                                                                      return Center(
                                                                        child: Text(
                                                                            "Error al cargar las categorias"),
                                                                      );
                                                                    }
                                                                    //--------------------------------------------------
                                                                    var list = snapshot
                                                                            .data
                                                                            ?.length ??
                                                                        0;
                                                                    //###################################################
                                                                    int index =
                                                                        0;
                                                                    List<Categoria>
                                                                        cat =
                                                                        [];

                                                                    if (list !=
                                                                        0) {
                                                                      for (var i =
                                                                              0;
                                                                          i < list;
                                                                          i++) {
                                                                        var prod =
                                                                            snapshot.data?[i];

                                                                        ///inicializar el contador
                                                                        if (_tipocat.getidcar !=
                                                                            0) {
                                                                          if (_tipocat.getidcar ==
                                                                              prod?.getidcar) {
                                                                            index =
                                                                                i;
                                                                            this.tipotrab =
                                                                                prod as Categoria;
                                                                          }
                                                                        } else {
                                                                          index =
                                                                              0;
                                                                        }

                                                                        // -----------------------------
                                                                        cat.add(
                                                                            Categoria.fromJson({
                                                                          "id_categ":
                                                                              prod?.getidcar,
                                                                          "nom_categ":
                                                                              prod?.getname
                                                                        }));
                                                                      }

                                                                      // print(
                                                                      //     "${_tipotrab.getidtrab} - ${_tipotrab.getnomtip} -> comprobante - result");

                                                                      this.tipotrab =
                                                                          buildDropdownMenuItems(cat)[index].value
                                                                              as Categoria;

                                                                      // print(
                                                                      //     "${tipotrab.getidtrab} - ${tipotrab.getnomtip} -> comprobante");

                                                                      memortiRecar =
                                                                          cat;

                                                                      return DropdownButton(
                                                                        value: this
                                                                            .tipotrab,
                                                                        items: buildDropdownMenuItems(
                                                                            cat),
                                                                        isExpanded:
                                                                            true,
                                                                        isDense:
                                                                            true,
                                                                        onChanged:
                                                                            (value) {
                                                                          Categoria
                                                                              aux =
                                                                              value as Categoria;
                                                                          // this.tipotrab =
                                                                          //     aux;
                                                                          listcontroler.text =
                                                                              aux.getname;
                                                                          toquenedit1 =
                                                                              false;
                                                                          _tipocat =
                                                                              aux;
                                                                          stadevalue =
                                                                              false;
                                                                          state(
                                                                              () {});
                                                                        },
                                                                      );
                                                                    } else {
                                                                      return Container(
                                                                        child: Text(
                                                                            "No presenta categorias"),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            color: Color(
                                                                    0xff707070)
                                                                .withOpacity(
                                                                    0.4),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    flex: 8,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          0,
                                                          config
                                                              .getsizeaproxhight(
                                                                  10),
                                                          0,
                                                          0),
                                                      child: Container(
                                                        height: config
                                                            .getsizeaproxhight(
                                                                40),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    TextField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          config
                                                                              .getsizeaproxhight(14)),
                                                                  controller:
                                                                      listcontroler,
                                                                  decoration: InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          'Escribe un mensaje'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            color: (stadevalue)
                                                                ? Colors.red
                                                                : Color(0xff707070)
                                                                    .withOpacity(
                                                                        0.4),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    flex: 8,
                                                  ),
                                                  (toquenedit1)
                                                      ? Expanded(
                                                          child: InkWell(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(2,
                                                                      0, 2, 0),
                                                              height: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              width: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons.send,
                                                                  size: config
                                                                      .getsizeaproxhight(
                                                                          24),
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                            onTap: () {
                                                              insercat();
                                                            },
                                                          ),
                                                          flex: 2,
                                                        )
                                                      : Container(),
                                                  !(toquenedit1) // boton de retroceder
                                                      ? Expanded(
                                                          child: InkWell(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(2,
                                                                      0, 2, 0),
                                                              height: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              width: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_back,
                                                                  size: config
                                                                      .getsizeaproxhight(
                                                                          24),
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                            onTap: () {
                                                              listcontroler
                                                                  .text = "";
                                                              limpiardatos();
                                                              stadevalue =
                                                                  false;
                                                              state(() {
                                                                toquenedit1 =
                                                                    true;
                                                              });
                                                            },
                                                          ),
                                                          flex: 2,
                                                        )
                                                      : Container(),
                                                  !(toquenedit1)
                                                      ? Expanded(
                                                          child: InkWell(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(2,
                                                                      0, 2, 0),
                                                              height: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              width: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  size: config
                                                                      .getsizeaproxhight(
                                                                          24),
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                            onTap: () {
                                                              if (_tipocat
                                                                      .getidcar !=
                                                                  0) {
                                                                deletcat();
                                                              } else {
                                                                print(
                                                                    "Error al eliminar");
                                                              }
                                                              state(() {});
                                                            },
                                                          ),
                                                          flex: 2,
                                                        )
                                                      : Container(),
                                                  !(toquenedit1)
                                                      ? Expanded(
                                                          child: InkWell(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(2,
                                                                      0, 2, 0),
                                                              height: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              width: config
                                                                  .getsizeaproxhight(
                                                                      40),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  size: config
                                                                      .getsizeaproxhight(
                                                                          24),
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                            onTap: () {
                                                              actucat();
                                                            },
                                                          ),
                                                          flex: 2,
                                                        )
                                                      : Container(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        flex: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                  ),
                  Container(
                    height: config.getsizeaproxhight(169),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: config.getsizeaproxhight(34) +
                            config.getsizeaproxhight(10) +
                            config.getsizeaproxhight(10),
                        padding: EdgeInsets.fromLTRB(
                            0,
                            config.getsizeaproxhight(10),
                            0,
                            config.getsizeaproxhight(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  "Editar categoria", // titulo cambiante, teniendo en cuenta el eddit
                                  style: TextStyle(
                                      fontSize: config.getsizeaproxhight(14),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              flex: 8,
                            ),
                            Expanded(
                              child: Container(
                                width: 15,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      child: Icon(
                                        Icons.close,
                                        size: config.getsizeaproxhight(24),
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                      onTap: () {
                                        limpiardatos();
                                        Navigator.pop(context);
                                        state(() {});
                                      },
                                    )),
                              ),
                              flex: 2,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0))),
                      ),
                    ),
                  )
                ],
              )),
            );
          },
        );
      },
    );
  }

  void actucat() async {
    //print(controller.getidusser);
    List<Object> stado = await restiptrab.actualizacateoria(Categoria.fromJson({
      "id_categ": _tipocat.getidcar,
      "nom_categ": listcontroler.text,
    }));
    switch ((stado[0] as int)) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a insertado la categoria correctamente", "T");
        limpiardatos();
        accionrecarga(0);
        break;
      default:
        valstado(stado[1] as List<bool>);
        state(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
    }
  }

  void deletcat() async {
    //print(controller.getidusser);
    int stado = await restiptrab.deletcategoria({"idcateg": _tipocat.getidcar});
    switch (stado) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a eliminado la categoria correctamente", "T");
        limpiardatos();
        accionrecarga(0);
        break;
      default:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Parece que hay una advertencia", "R");
    }
  }

  void insercat() async {
    //print(controller.getidusser);
    List<Object> stado = await restiptrab.agregarcategoria(
        Categoria.fromJson({"nom_categ": listcontroler.text}));
    switch ((stado[0] as int)) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a insertado la categoria correctamente", "T");
        limpiardatos();
        accionrecarga(0);
        break;
      default:
        valstado(stado[1] as List<bool>);
        state(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
    }
  }

  void limpiardatos() {
    _tipocat = Categoria(0, "");
    listcontroler.text = "";
    toquenedit1 = true;
    stadevalue = false;
    state(() {});
  }

  void valstado(List<bool> est) {
    for (var i = 0; i < est.length; i++) {
      stadevalue = est[i];
    }
  }
}

// ignore: camel_case_types
class contentserbody extends State<categoriaeditview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
