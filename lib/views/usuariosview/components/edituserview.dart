import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import '../../../controllers/cliente.dart';
import '../../../controllers/trabajador.dart';
import '../../../controllers/TipTrabajador.dart';
import '../../../views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../negocio/cliente_negocio.dart';
import '../../../negocio/trabajador_negocio.dart';
import '../../../negocio/Tiptrabajador_negocio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

TipTrabajador _tipotrab = TipTrabajador(0, "");

// ignore: camel_case_types, must_be_immutable
class contentserview extends StatefulWidget {
  bool toquenedit1 = false;
  bool toquenedit2 = false;
  ValueChanged<int> accionrecarga;

  // memoria cache de los itens de cliente y trabajador
  Cliente clientecacha = Cliente.fromJson({});
  Trabajador trabajocahca = Trabajador.fromJson({});
  //---------------------------------------------------
  var state;
  var pedres;
  var restiptrab;
  int idedittext = -1;
  int idusuario = 0;
  String tipo = "";
  var controller;
  String path = "";
  String pathmemori = "";
  // tipo de trabajador
  TipTrabajador tipotrab = TipTrabajador.fromJson({});
  List<TipTrabajador> memortiRecar = [];
  //lista de labels
  List<String> list = [
    "Nombre: ",
    "Direccion: ",
    "Direccion Alterna: ",
    "Tipo de trabajador: ",
    "Telefono: ",
    "Correo: "
  ];
  // lista de controladores
  List<String> listcontroler = [
    "", //nombre
    "", //direccion
    "", //direccion alt
    "", //tipo de trab
    "", //Telefono
    "", //correo
  ];
  cache control = cache();
  BuildContext? _context;
  bool stadevalue = false;
  late configinterface config;

  contentserview(this.idusuario, this.tipo, this.accionrecarga);

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
    var size = MediaQuery.of(context).size;
    pedres = (this.tipo == "C") ? ClienteNegocio() : TrabajadorNegocio();
    restiptrab = TipTrabajoNegocio();
    config = configinterface(context);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        this._context = context;
        return StatefulBuilder(
          builder: (context, setState) {
            state = setState;
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: (this.tipo == "C")
                  ? FutureBuilder<Cliente>(
                      future: (pedres as ClienteNegocio)
                          .read({"iduser": this.idusuario}),
                      builder: (context, snapshot) {
                        print(snapshot.connectionState);
                        //validadores del estado------------------------
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return (clientecacha.getnombre == "")
                              ? Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())
                              : contenedorDate(size, context, clientecacha,
                                  Trabajador.fromJson({}));
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error al cargar las categorias"),
                          );
                        }
                        //------------------------------------------------
                        //capturar las categorias
                        var list = snapshot.data ?? Cliente.fromJson({});
                        clientecacha = list;

                        return contenedorDate(
                            size, context, list, Trabajador.fromJson({}));
                      },
                    )
                  : FutureBuilder<Trabajador>(
                      future: (pedres as TrabajadorNegocio)
                          .read({"iduser": this.idusuario}),
                      builder: (context, snapshot) {
                        //validadores del estado------------------------
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return (trabajocahca.getnombre == "")
                              ? Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())
                              : contenedorDate(size, context,
                                  Cliente.fromJson({}), trabajocahca);
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error al cargar las categorias"),
                          );
                        }
                        //------------------------------------------------
                        //capturar las categorias
                        var list = snapshot.data ?? Trabajador.fromJson({});
                        trabajocahca = list;
                        return contenedorDate(
                            size, context, Cliente.fromJson({}), list);
                      },
                    ),
            );
          },
        );
      },
    );
  }

  Widget contenedorDate(
      Size size, BuildContext context, Cliente list, Trabajador tbj) {
    String imageperfil = (this.tipo == "C") ? list.getfoto : tbj.getfoto;
    imageperfil = (imageperfil == "")
        ? "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg"
        : imageperfil.replaceAll(
            "localhost:9000", control.getdomain.toString());
    return Stack(
      children: [
        Container(
          height: config.getsizeaproxhight(500),
          //height: 400,
          width: size.width - 10,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Imagen de perfil del usuario
                  Container(
                    //color: Colors.grey,
                    height: config.getsizeaproxhight(180),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Container(
                              width: config.getsizeaproxhight(140),
                              height: config.getsizeaproxhight(140),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: config.getsizeaproxhight(50),
                                  height: config.getsizeaproxhight(50),
                                  child: Align(
                                    alignment: Alignment.center,
                                    //subier una imagen al servidor
                                    child: InkWell(
                                      child: Icon(
                                        (this.path == "")
                                            ? Icons.photo_camera
                                            : Icons.send,
                                        size: config.getsizeaproxhight(25),
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                      onTap: (this.path == "")
                                          ? () async {
                                              final ImagePicker _picker =
                                                  ImagePicker();
                                              final XFile? image =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              try {
                                                this.path = image!.path;
                                                this.pathmemori = this.path;
                                              } catch (e) {
                                                print("$e -> messeg error");
                                              }

                                              state(() {});
                                            }
                                          : () {
                                              //print("${this.path} -> image");
                                              (this.tipo == "C")
                                                  ? actucliente()
                                                  : actutrabajador();
                                              state(() {});
                                            },
                                    ),
                                  ),
                                  // ###########################################
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.grey.withOpacity(0.9)),
                                ),
                              ),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(70.0),
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: (path == "" && pathmemori == "")
                                      ? Image.network(imageperfil).image
                                      : Image.file(File(
                                              (path == "") ? pathmemori : path))
                                          .image,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                _tipotrab = TipTrabajador(0, "");
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  size: config.getsizeaproxhight(30),
                                  color: Colors.grey.withOpacity(0.9),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // ---------------------------------------------
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          color: Colors.white,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                iteninfo(
                                    Icons.person,
                                    this.list[0].toString(),
                                    (this.tipo == "C")
                                        ? list.getnombre
                                        : tbj.getnombre,
                                    0),
                                (this.tipo == "C")
                                    ? iteninfo(
                                        Icons.person,
                                        this.list[1].toString(),
                                        list.getdirecc,
                                        1)
                                    : Container(),
                                (this.tipo == "C")
                                    ? iteninfo(
                                        Icons.person,
                                        this.list[2].toString(),
                                        list.gedirec_a,
                                        2)
                                    : Container(),
                                (this.tipo == "T")
                                    ? iteninfo(
                                        Icons.person,
                                        this.list[3].toString(),
                                        tbj.gettiptranba.getnomtip,
                                        3)
                                    : Container(),
                                iteninfo(
                                    Icons.person,
                                    this.list[4].toString(),
                                    (this.tipo == "C")
                                        ? list.getcelula
                                        : tbj.getcelula,
                                    4),
                                iteninfo(
                                    Icons.person,
                                    this.list[5].toString(),
                                    (this.tipo == "C")
                                        ? list.getcorreo
                                        : tbj.getcorreo,
                                    5)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: config.getsizeaproxhight(50),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Eliminar producto",
                            style: TextStyle(
                                fontSize: config.getsizeaproxhight(14),
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.8),
                          //color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        (this.idedittext != -1)
            ? Container(
                height: config.getsizeaproxhight(50),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width,
                    height: config.getsizeaproxhight(80),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 5),
                                                  child: Text(
                                                    this
                                                        .list[this.idedittext]
                                                        .toString(), // titulo cambiante, teniendo en cuenta el eddit
                                                    style: TextStyle(
                                                        fontSize: config.getsizeaproxhight(14),
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                flex: 8,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 15,
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 5),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.close,
                                                          size: config.getsizeaproxhight(24),
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                        onTap: () {
                                                          listcontroler[this
                                                              .idedittext] = "";
                                                          this.idedittext = -1;
                                                          stadevalue = false;
                                                          _tipotrab =
                                                              TipTrabajador(
                                                                  0, "");
                                                          state(() {});
                                                        },
                                                      )),
                                                ),
                                                flex: 2,
                                              )
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
                                                  child: Container(
                                                    height: config.getsizeaproxhight(40),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            child: (this.idedittext !=
                                                                    3)
                                                                ? TextFormField(
                                                                    controller:
                                                                        null,
                                                                    initialValue:
                                                                        listcontroler[
                                                                            this.idedittext],
                                                                    onChanged:
                                                                        (value) {
                                                                      listcontroler[
                                                                              this.idedittext] =
                                                                          value;
                                                                    },
                                                                    keyboardType: (this.idedittext ==
                                                                            4)
                                                                        ? TextInputType
                                                                            .number
                                                                        : TextInputType
                                                                            .text,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                    decoration: InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText:
                                                                            'Escribe un mensaje'),
                                                                  )
                                                                : FutureBuilder<
                                                                    List<
                                                                        TipTrabajador>>(
                                                                    future: restiptrab
                                                                        .getlist({
                                                                      "iduser":
                                                                          this.idusuario
                                                                    }),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      //validadores del estado------------------------
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: CircularProgressIndicator());
                                                                      }
                                                                      if (snapshot
                                                                          .hasError) {
                                                                        return Center(
                                                                          child:
                                                                              Text("Error al cargar las categorias"),
                                                                        );
                                                                      }
                                                                      //--------------------------------------------------
                                                                      var list =
                                                                          snapshot.data?.length ??
                                                                              0;
                                                                      //###################################################
                                                                      int index =
                                                                          0;
                                                                      List<TipTrabajador>
                                                                          cat =
                                                                          [];
                                                                      for (var i =
                                                                              0;
                                                                          i < list;
                                                                          i++) {
                                                                        var prod =
                                                                            snapshot.data?[i];
                                                                        // inicializar el contador
                                                                        if (_tipotrab.getidtrab !=
                                                                            0) {
                                                                          if (_tipotrab.getidtrab ==
                                                                              prod?.getidtrab) {
                                                                            index =
                                                                                i;
                                                                            this.tipotrab =
                                                                                prod as TipTrabajador;
                                                                          }
                                                                        } else {
                                                                          if (tbj.gettiptranba.getidtrab ==
                                                                              prod?.getidtrab) {
                                                                            index =
                                                                                i;
                                                                            this.tipotrab =
                                                                                prod as TipTrabajador;
                                                                          }
                                                                        }

                                                                        // -----------------------------
                                                                        cat.add(
                                                                            TipTrabajador.fromJson({
                                                                          "id_tiptrabajador":
                                                                              prod?.getidtrab,
                                                                          "nomb_tipo":
                                                                              prod?.getnomtip
                                                                        }));
                                                                      }

                                                                      this.tipotrab =
                                                                          buildDropdownMenuItems(cat)[index].value
                                                                              as TipTrabajador;

                                                                      return DropdownButton(
                                                                        value: this
                                                                            .tipotrab,
                                                                        items: buildDropdownMenuItems(
                                                                            cat),
                                                                        onChanged:
                                                                            (value) {
                                                                          TipTrabajador
                                                                              aux =
                                                                              value as TipTrabajador;
                                                                          this.tipotrab =
                                                                              aux;
                                                                          _tipotrab =
                                                                              aux;
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
                                                          BorderRadius.circular(
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
                                              Expanded(
                                                child: InkWell(
                                                  child: Container(
                                                    height: config.getsizeaproxhight(40),
                                                    width: config.getsizeaproxhight(40),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.send,
                                                        size: config.getsizeaproxhight(24),
                                                        color: Colors.grey
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  onTap: () {
                                                    (this.tipo == "C")
                                                        ? actucliente()
                                                        : actutrabajador();
                                                  },
                                                ),
                                                flex: 2,
                                              ),
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
                      color: Colors.grey,
                      //color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: config.getsizeaproxhight(500),
              ),
      ],
    );
  }

  void actucliente() async {
    List<Object> stado = await (pedres as ClienteNegocio).update(
        Cliente.fromJson({
          "id_usuario": this.idusuario,
          "nombre": listcontroler[0],
          "direccion": listcontroler[1],
          "direccion_alt": listcontroler[2],
          "celular":
              int.parse((listcontroler[4] == "") ? "0" : listcontroler[4]),
          "correo": listcontroler[5],
          "foto": this.path
        }),
        accionrecarga);
    switch (stado[0] as int) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a edito el cliente correctamente", "T");
        this.pathmemori = this.path;
        this.path = "";
        listcontroler[this.idedittext] = "";
        this.idedittext = -1;
        state(() {});
        break;
      default:
        valstado(stado[1] as List<bool>);
        state(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
    }
  }

  void actutrabajador() async {
    //print(controller.getidusser);
    List<Object> stado = await (pedres as TrabajadorNegocio).update(
        Trabajador.fromJson({
          "id_usuario": this.idusuario,
          "nombre": listcontroler[0],
          "id_tiptrabajador": _tipotrab.getidtrab,
          "celular":
              int.parse((listcontroler[4] == "") ? "0" : listcontroler[4]),
          "correo": listcontroler[5],
          "foto": this.path
        }),
        accionrecarga);

    switch (stado[0] as int) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a edito el Trabajador correctamente", "T");
        this.pathmemori = this.path;
        this.path = "";
        listcontroler[this.idedittext] = "";
        this.idedittext = -1;
        state(() {});
        break;
      default:
        valstado(stado[1] as List<bool>);
        state(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
    }
  }

  void valstado(List<bool> est) {
    for (var i = 0; i < est.length; i++) {
      stadevalue = est[i];
    }
  }

  Widget iteninfo(IconData icon, String label, var info, int inx) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
              //color: Colors.black,
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  icon,

                  size: config.getsizeaproxhight(24),
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              //color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                    "$label",
                    style: TextStyle(
                        fontSize: config.getsizeaproxhight(14),
                        color: Colors.grey[800], fontWeight: FontWeight.w700),
                  )),
                  Container(
                      child: Text(
                    "$info",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: config.getsizeaproxhight(14),
                        color: Colors.grey.withOpacity(0.8)),
                  )),
                ],
              ),
            ),
            flex: 6,
          ),
          Expanded(
            child: Container(
              child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Icon(
                      Icons.edit,
                      size: config.getsizeaproxhight(24),
                      color: Colors.grey.withOpacity(0.8),
                    ),
                    onTap: () {
                      this.idedittext = inx; // cambia el index de la interface
                      listcontroler[this.idedittext] = info.toString();
                      state(() {});
                    },
                  )),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class contentserbody extends State<contentserview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
