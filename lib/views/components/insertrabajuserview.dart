import '../../../controllers/datosuser.dart';
import '../../../negocio/usuarios_negocio.dart';

import '../../config/configinterface.dart';
import '../../controllers/cliente.dart';
import '../../controllers/trabajador.dart';
import '../../controllers/TipTrabajador.dart';
import '../../negocio/trabajador_negocio.dart';
import '../../negocio/Tiptrabajador_negocio.dart';
import '../../views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../config/Cache.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//import 'package:keyboard_visibility/keyboard_visibility.dart';
// memoria que nos ayudara en el apartado de tipo de tranakjador
TipTrabajador _tipotrab = TipTrabajador(0, "");
//memoria que nos ayudara en el apartado de pasword
bool band = true;

// ignore: camel_case_types, must_be_immutable
class insertrabajuserview extends StatefulWidget {
  bool toquenedit1 = false;
  //bool toquenedit2 = false;
  ValueChanged<int> accionrecarga;

  // memoria cache de los itens de cliente y trabajador
  Cliente clientecacha = Cliente.fromJson({});
  Trabajador trabajocahca = Trabajador.fromJson({});
  BuildContext? contextgeneral;
  //---------------------------------------------------
  var state;
  TrabajadorNegocio? pedres;
  var restiptrab;
  //int idedittext = -1;
  int idusuario = 0;
  String tipo = "";
  var controller;
  String path = "";
  BuildContext? context, _context;
  late configinterface config;

  insertrabajuserview(this.accionrecarga);
  //lista de labels
  List<String> list = [
    "Nombre: ",
    "Usuario: ",
    "Contraseña: ",
    "Tipo de trabajador: ",
    "Telefono: ",
    "Correo: "
  ];
  // lista de controladores
  List<TextEditingController> listcontroler = [
    TextEditingController(text: ""), //nombre
    TextEditingController(text: ""), //user
    TextEditingController(text: ""), //pass
    TextEditingController(text: ""), //tipo de trab
    TextEditingController(text: ""), //Telefono
    TextEditingController(text: ""), //correo
  ];
  List<bool> listvalide = [
    false, //nombre
    false, //usser
    false, //pass
    false, //tipo de trab
    false, //Telefono
    false, //correo
    false //foto
  ];
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
          child: Text(
            company.getnomtip,
            style: TextStyle(fontSize: config.getsizeaproxhight(15)),
          ),
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
    config = configinterface(context);
    // this.contextgeneral = context;
    this.context = context;
    //####################################
    controller = Get.put(cache()); //inicializamos la cache
    //####################################
    var size = MediaQuery.of(context).size;
    pedres = TrabajadorNegocio();
    restiptrab = TipTrabajoNegocio();

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
                content: contenedorDate(size, context));
          },
        );
      },
    );
  }

  Widget contenedorDate(Size size, BuildContext context) {
    String imageperfil =
        "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg";
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
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
                  (!isKeyboard)
                      ? Container(
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
                                                Icons.photo_camera,
                                                size: config
                                                    .getsizeaproxhight(25),
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                              ),
                                              onTap: () async {
                                                final ImagePicker _picker =
                                                    ImagePicker();
                                                final XFile? image =
                                                    await _picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                try {
                                                  this.path = image!.path;
                                                } catch (e) {
                                                  print("$e -> messeg error");
                                                }

                                                state(() {});
                                              }),
                                        ),
                                        // ###########################################
                                        decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: (listvalide[6])
                                                ? Colors.red
                                                : Colors.grey.withOpacity(0.9)),
                                      ),
                                    ),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(70.0),
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: (path == "")
                                            ? Image.network(imageperfil).image
                                            : Image.file(File(path)).image,
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
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                _tipotrab = TipTrabajador(0, "");
                                limpestade();
                                limpliesa();
                                band = true;
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
                            ),
                          ),
                        ),
                  // ---------------------------------------------
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 25, 0),
                          color: Colors.white,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                //  nombre
                                iteninfo(context, Icons.person,
                                    this.list[0].toString(), "", 0, 100, "T"),
                                //  ususario
                                iteninfo(context, Icons.badge_rounded,
                                    this.list[1].toString(), "", 1, 100, "T"),
                                //  password
                                iteninfo(context, Icons.lock_open,
                                    this.list[2].toString(), "", 2, 8, "P"),
                                // tipo de trabajador
                                iteninfo(context, Icons.home_repair_service,
                                    this.list[3].toString(), "", 3, 0, ""),
                                iteninfo(context, Icons.phone,
                                    this.list[4].toString(), "", 4, 100, "N"),
                                iteninfo(context, Icons.email,
                                    this.list[5].toString(), "", 5, 100, "T")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          insertartrabajador();
                        },
                        child: Container(
                          height: config.getsizeaproxhight(50),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Ingresar Trabajador",
                              style: TextStyle(
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
      ],
    );
  }

  void insertartrabajador() async {
    // comprueba si el suaurio existe
    UsuarioNegocio usres = UsuarioNegocio();
    Datosuser dat = await usres
        .read({"usser": listcontroler[1].text, "pass": listcontroler[2].text});
    // si existen manda un error
    if (dat.getiduser != 0) {
      mensajealert().customShapeSnackBar(
          this._context as BuildContext,
          "El usuario ya presenta una cuenta. Porfavor ingresar otro usuario",
          "R");
    } else {
      // sino existe, sigue con el siguiente paso
      // mensajealert().customShapeSnackBar(this._context as BuildContext,
      //     "Este trabajador no existe asi que puedes continuar", "T");
      Trabajador tbj = Trabajador.fromJson({
        "nombre": listcontroler[0].text,
        "usser": listcontroler[1].text,
        "pass": listcontroler[2].text,
        "id_tiptrabajador": _tipotrab.getidtrab,
        "celular": int.parse(
            (listcontroler[4].text == "") ? "0" : listcontroler[4].text),
        "correo": listcontroler[5].text,
        "foto": this.path
      });
      //print(controller.getidusser);
      List<Object> stado = await pedres!.insert(tbj, accionrecarga);
      switch ((stado[0] as int)) {
        case 200:
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Se a insertado el trabajador correctamente", "T");
          limpliesa();
          state(() {});
          break;
        default:
          validar((stado[1] as List<bool>));
          state(() {
            mensajealert().customShapeSnackBar(this._context as BuildContext,
                "Parece que hay una advertencia", "R");
          });
      }
    }
  }

  void limpliesa() {
    listcontroler[0].text = "";
    listcontroler[1].text = "";
    listcontroler[2].text = "";
    _tipotrab = TipTrabajador.fromJson({});
    listcontroler[4].text = "";
    listcontroler[5].text = "";
    this.path = "";
    limpestade();
  }

  void limpestade() {
    for (var i = 0; i < listvalide.length; i++) {
      listvalide[i] = false;
    }
  }

  void validar(List<bool> list) {
    for (var i = 0; i < list.length; i++) {
      listvalide[i] = list[i];
    }
  }

  Widget iteninfo(BuildContext context, IconData icon, String label, var info,
      int inx, int lentchart, String tipo) {
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
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              height: config.getsizeaproxhight(60),
              //color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "$label",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700),
                      )),
                  Container(
                    child: Expanded(
                      child: Container(
                        child: Container(
                          height: config.getsizeaproxhight(40),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: (inx != 3)
                                      // ? TextField(
                                      //     //focusNode: _focus[inx],
                                      //     keyboardType: (inx == 4)
                                      //         ? TextInputType.number
                                      //         : TextInputType.text,
                                      //     style: TextStyle(
                                      //       fontSize:
                                      //           config.getsizeaproxhight(15),
                                      //     ),
                                      //     controller: listcontroler[inx],
                                      //     decoration: InputDecoration(
                                      //         border: InputBorder.none,
                                      //         hintText: 'Escribe un mensaje'),
                                      //   )
                                      ? TextField(
                                          //focusNode: _focus[inx],
                                          // tipo de texto a ingresar
                                          keyboardType: (tipo == "N")
                                              ? TextInputType.number
                                              : (tipo == "T")
                                                  ? TextInputType.text
                                                  : (tipo == "C")
                                                      ? TextInputType
                                                          .emailAddress
                                                      : (tipo == "P")
                                                          ? TextInputType
                                                              .visiblePassword
                                                          : TextInputType.text,
                                          style: TextStyle(
                                            fontSize:
                                                config.getsizeaproxhight(15),
                                          ),
                                          onChanged: (String newVal) {
                                            if (newVal.length <= lentchart) {
                                              //textcontrol.text = newVal;
                                              print(
                                                  "${newVal} - text propuest");
                                            } else {
                                              listcontroler[inx].text =
                                                  newVal.substring(
                                                      0, newVal.length - 1);
                                            }
                                          },
                                          controller: listcontroler[inx],
                                          obscureText:
                                              (tipo == "P") ? band : false,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            border: InputBorder.none,
                                            hintText: 'Escribe $label',
                                            suffixIcon: (tipo == "P")
                                                ? IconButton(
                                                    color: Color(0xff707070),
                                                    onPressed: () {
                                                      state(() {
                                                        band = !band;
                                                      });
                                                    },
                                                    icon: Icon((band)
                                                        ? Icons.visibility
                                                        : Icons.visibility_off),
                                                  )
                                                : Container(
                                                    width: 1,
                                                  ),
                                          ),
                                        )
                                      : FutureBuilder<List<TipTrabajador>>(
                                          future: restiptrab.getlist(
                                              {"iduser": this.idusuario}),
                                          builder: (context, snapshot) {
                                            //validadores del estado------------------------
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Align(
                                                  alignment: Alignment.center,
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    "Error al cargar las categorias"),
                                              );
                                            }
                                            //--------------------------------------------------
                                            var list =
                                                snapshot.data?.length ?? 0;
                                            //###################################################
                                            int index = 0;
                                            List<TipTrabajador> cat = [];
                                            for (var i = 0; i < list; i++) {
                                              var prod = snapshot.data?[i];
                                              // inicializar el contador
                                              if (_tipotrab.getidtrab != 0) {
                                                if (_tipotrab.getidtrab ==
                                                    prod?.getidtrab) {
                                                  index = i;
                                                  this.tipotrab =
                                                      prod as TipTrabajador;
                                                }
                                              } else {
                                                index = 0;
                                                // this.tipotrab =
                                                //     prod as TipTrabajador;
                                              }

                                              // -----------------------------
                                              cat.add(TipTrabajador.fromJson({
                                                "id_tiptrabajador":
                                                    prod?.getidtrab,
                                                "nomb_tipo": prod?.getnomtip
                                              }));
                                            }

                                            // print(
                                            //     "${_tipotrab.getidtrab} - ${_tipotrab.getnomtip} -> comprobante - result");

                                            this.tipotrab =
                                                buildDropdownMenuItems(
                                                        cat)[index]
                                                    .value as TipTrabajador;

                                            // print(
                                            //     "${tipotrab.getidtrab} - ${tipotrab.getnomtip} -> comprobante");

                                            // memortiRecar =
                                            //     cat;

                                            return DropdownButton(
                                              isExpanded: true,
                                              isDense: true,
                                              value: this.tipotrab,
                                              items:
                                                  buildDropdownMenuItems(cat),
                                              onChanged: (value) {
                                                TipTrabajador aux =
                                                    value as TipTrabajador;
                                                this.tipotrab = aux;
                                                _tipotrab = aux;
                                                state(() {});
                                              },
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white,
                            border: Border.all(
                              color: (listvalide[inx])
                                  ? Colors.red
                                  : Color(0xff707070).withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      flex: 8,
                    ),
                  ),
                ],
              ),
            ),
            flex: 6,
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class contentserbody extends State<insertrabajuserview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
