import 'package:ecomersbaic/controllers/TipTrabajador.dart';
import 'package:ecomersbaic/negocio/Tiptrabajador_negocio.dart';
import 'package:ecomersbaic/views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ecomersbaic/Cache.dart';

TipTrabajador _tipocat = TipTrabajador(0, "");
TextEditingController listcontroler = TextEditingController(text: "");
bool toquenedit1 = true;

// ignore: camel_case_types, must_be_immutable
class tiptrabajoeditview extends StatefulWidget {
  ValueChanged<int> accionrecarga;

  // memoria cache de los itens de cliente y trabajador
  //---------------------------------------------------
  var state;
  //var pedres;
  TipTrabajoNegocio restiptrab = TipTrabajoNegocio();
  String tipo = "";
  var controller;
  String path = "";
  BuildContext? _context;
  bool stadevalue = false;

  tiptrabajoeditview(this.accionrecarga);

  // tipo de trabajador
  TipTrabajador tipotrab = TipTrabajador.fromJson({});
  List<TipTrabajador> memortiRecar = [];

  //################### Action de tipo de trabajo ##################
  List<DropdownMenuItem<TipTrabajador>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<TipTrabajador>> items = [];
    for (TipTrabajador company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.getnomtip),
        ),
      );
    }
    return items;
  }

  void onChangeDropdownItem(TipTrabajador selectedCompany) {
    tipotrab = selectedCompany;
    print("${tipotrab.getidtrab} -> se selecciono");
    state(() {});
  }

  @override
  contentserbody createState() => contentserbody();

  createDialog(BuildContext context) {
    //####################################
    controller = Get.put(cache()); //inicializamos la cache
    //####################################
    var size = MediaQuery.of(context).size;
    restiptrab = TipTrabajoNegocio();

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
                child: Container(
                  height: 169,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: size.width,
                      height: 169,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                      child: Text(
                                        "Editar tipo de Trabajador", // titulo cambiante, teniendo en cuenta el eddit
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    flex: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 15,
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.close,
                                              color:
                                                  Colors.white.withOpacity(0.8),
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
                            Container(
                              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                                                      height: 40,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(10,
                                                                      0, 10, 0),
                                                              child: FutureBuilder<
                                                                  List<
                                                                      TipTrabajador>>(
                                                                future:
                                                                    restiptrab
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
                                                                        alignment:
                                                                            Alignment
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
                                                                  int index = 0;
                                                                  List<TipTrabajador>
                                                                      cat = [];
                                                                  for (var i =
                                                                          0;
                                                                      i < list;
                                                                      i++) {
                                                                    var prod =
                                                                        snapshot
                                                                            .data?[i];

                                                                    ///inicializar el contador
                                                                    if (_tipocat
                                                                            .getidtrab !=
                                                                        0) {
                                                                      if (_tipocat
                                                                              .getidtrab ==
                                                                          prod?.getidtrab) {
                                                                        index =
                                                                            i;
                                                                        this.tipotrab =
                                                                            prod
                                                                                as TipTrabajador;
                                                                      }
                                                                    } else {
                                                                      index = 0;
                                                                    }

                                                                    // -----------------------------
                                                                    cat.add(TipTrabajador
                                                                        .fromJson({
                                                                      "id_tiptrabajador":
                                                                          prod?.getidtrab,
                                                                      "nomb_tipo":
                                                                          prod?.getnomtip
                                                                    }));
                                                                  }

                                                                  // print(
                                                                  //     "${_tipotrab.getidtrab} - ${_tipotrab.getnomtip} -> comprobante - result");

                                                                  this.tipotrab =
                                                                      buildDropdownMenuItems(cat)[index]
                                                                              .value
                                                                          as TipTrabajador;

                                                                  // print(
                                                                  //     "${tipotrab.getidtrab} - ${tipotrab.getnomtip} -> comprobante");

                                                                  memortiRecar =
                                                                      cat;

                                                                  return DropdownButton(
                                                                    isExpanded:
                                                                        true,
                                                                    isDense:
                                                                        true,
                                                                    value: this
                                                                        .tipotrab,
                                                                    items:
                                                                        buildDropdownMenuItems(
                                                                            cat),
                                                                    onChanged:
                                                                        (value) {
                                                                      TipTrabajador
                                                                          aux =
                                                                          value
                                                                              as TipTrabajador;
                                                                      // this.tipotrab =
                                                                      //     aux;
                                                                      listcontroler
                                                                              .text =
                                                                          aux.getnomtip;
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
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color: Color(
                                                                  0xff707070)
                                                              .withOpacity(0.4),
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
                                                        0, 10, 0, 10),
                                                    child: Container(
                                                      height: 40,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(10,
                                                                      0, 0, 0),
                                                              child: TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                                controller:
                                                                    listcontroler,
                                                                decoration: InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Escribe un mensaje'),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.0),
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
                                                                .fromLTRB(
                                                                    2, 0, 2, 0),
                                                            height: 40,
                                                            width: 40,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                Icons.send,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
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
                                                                .fromLTRB(
                                                                    2, 0, 2, 0),
                                                            height: 40,
                                                            width: 40,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_back,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    shape: BoxShape
                                                                        .circle),
                                                          ),
                                                          onTap: () {
                                                            listcontroler.text =
                                                                "";
                                                            stadevalue = false;
                                                            limpiardatos();
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
                                                                .fromLTRB(
                                                                    2, 0, 2, 0),
                                                            height: 40,
                                                            width: 40,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    shape: BoxShape
                                                                        .circle),
                                                          ),
                                                          onTap: () {
                                                            if (_tipocat
                                                                    .getidtrab !=
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
                                                                .fromLTRB(
                                                                    2, 0, 2, 0),
                                                            height: 40,
                                                            width: 40,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
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
              ),
            );
          },
        );
      },
    );
  }

  void actucat() async {
    //print(controller.getidusser);
    List<Object> stado = await restiptrab.acttiptrab(TipTrabajador.fromJson({
      "id_tiptrabajador": _tipocat.getidtrab,
      "nomb_tipo": listcontroler.text,
    }));

    switch (stado[0] as int) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a actualizado el tipo de trabajador correctamente", "T");
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
    int stado =
        await restiptrab.delettiptrab({"idtiptraba": _tipocat.getidtrab});

    switch (stado) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a eliminado el tipo de trabajador correctamente", "T");
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
    List<Object> stado = await restiptrab.agregartiptrab(
        TipTrabajador.fromJson({"nomb_tipo": listcontroler.text}));
    switch (stado[0] as int) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a insertado el tipo de trabajador correctamente", "T");
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
    _tipocat = TipTrabajador(0, "");
    listcontroler.text = "";
    toquenedit1 = true;
    state(() {});
  }

  void valstado(List<bool> est) {
    for (var i = 0; i < est.length; i++) {
      stadevalue = est[i];
    }
  }
}

// ignore: camel_case_types
class contentserbody extends State<tiptrabajoeditview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
