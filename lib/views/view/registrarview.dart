//import 'package:ecomersbaic/Cache.dart';
import 'dart:ui';
import 'package:ecomersbaic/controllers/cliente.dart';
import 'package:ecomersbaic/controllers/datosuser.dart';
import 'package:ecomersbaic/negocio/usuarios_negocio.dart';
import 'package:ecomersbaic/negocio/cliente_negocio.dart';
import 'package:ecomersbaic/views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import 'package:ecomersbaic/bdcache.dart';
import 'package:ecomersbaic/main.dart';

// ignore: camel_case_types
class registrarview extends StatefulWidget {
  registrarview();

  @override
  registrarbody createState() => registrarbody();
}

// ignore: camel_case_types
class registrarbody extends State<registrarview> {
  TextEditingController usser = TextEditingController(text: "");
  TextEditingController pass = TextEditingController(text: "");
  UsuarioNegocio? usres;
  ClienteNegocio? clres;
  // ignore: non_constant_identifier_names
  int IndexInterRegis = 0;

  List<String> list = [
    "Nombre: ", //0
    "Telefono: ", //1
    "Correo: ", //2
    "Usuario: ", //3
    "Contraseña: ", //4
    "Direccion: ", //5
    "Direccion Alt: ", //6
  ];
  // lista de remomendaciones
  List<String> laberlrecoment = [
    "Ingresar tus datos personales, y evitar compartirlo",
    "Ingresar tu usuario y contraseña, evitar dibulgar",
    "Ingresar direccion donde llegaran sus futuros envios"
  ];
  //lista de validaciones
  List<List<int>> validecontes = [
    [0, 2],
    [3, 4],
    [5, 6],
  ];

  // lista de controladores
  List<TextEditingController> _listcontroler = [
    TextEditingController(text: ""), //nombre
    TextEditingController(text: ""), //Telefono
    TextEditingController(text: ""), //correo
    TextEditingController(text: ""), //usser
    TextEditingController(text: ""), //pass
    TextEditingController(text: ""), //direccion
    TextEditingController(text: ""), //direccion alt
  ];
  BuildContext? _context;

  registrarbody();
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    usres = UsuarioNegocio();
    clres = ClienteNegocio();
    //####################################
    _context = context;
    //ScrollController _scrollController = ScrollController();
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    //inicializar();
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (!isKeyboard)
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Registrate",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                        )
                      : Container(),
                  (!isKeyboard)
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            laberlrecoment[IndexInterRegis],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Slider(
                      thumbColor: Colors.transparent,
                      value: IndexInterRegis * 1.0,
                      min: 0,
                      max: 3,
                      activeColor: Color(0xff707070),
                      inactiveColor: Color(0xff707070).withOpacity(0.3),
                      divisions: 3,
                      onChanged: (double value) {},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        (IndexInterRegis == 0)
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        iteninfo(context, Icons.person,
                                            this.list[0].toString(), "", 0),
                                        iteninfo(context, Icons.person,
                                            this.list[1].toString(), "", 1),
                                        iteninfo(context, Icons.person,
                                            this.list[2].toString(), "", 2)
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        (IndexInterRegis == 1)
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        iteninfo(context, Icons.person,
                                            this.list[3].toString(), "", 3),
                                        iteninfo(context, Icons.person,
                                            this.list[4].toString(), "", 4),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        (IndexInterRegis == 2)
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        iteninfo(context, Icons.person,
                                            this.list[5].toString(), "", 5),
                                        iteninfo(context, Icons.person,
                                            this.list[6].toString(), "", 6),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              if (IndexInterRegis > 0) {
                                IndexInterRegis--;
                                setState(() {});
                              }
                            },
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Atras",
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(
                                      0xff707070), //                   <--- border color
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              bool test = true;
                              if (IndexInterRegis < 2) {
                                for (var i = validecontes[IndexInterRegis][0];
                                    i < validecontes[IndexInterRegis][1] + 1;
                                    i++) {
                                  if (this._listcontroler[i].text == "") {
                                    test = false;
                                  }
                                }
                                if (test) {
                                  if (IndexInterRegis == 1) {
                                    Datosuser dat = await usres!.read({
                                      "usser": _listcontroler[
                                              validecontes[IndexInterRegis][0]]
                                          .text,
                                      "pass": _listcontroler[
                                              validecontes[IndexInterRegis][1]]
                                          .text
                                    });
                                    print("${dat.getiduser}");
                                    if (dat.getiduser != 0) {
                                      print("El usuario ya existe");
                                    } else {
                                      IndexInterRegis++;
                                    }
                                  } else {
                                    IndexInterRegis++;
                                  }
                                } else {
                                  print("Evitar que las casillas esten vacias");
                                }
                                setState(() {});
                              } else {
                                // cuando este en la pocicion de insertar
                                for (var i = validecontes[IndexInterRegis][0];
                                    i < validecontes[IndexInterRegis][1] + 1;
                                    i++) {
                                  if (this._listcontroler[i].text == "") {
                                    test = false;
                                  }
                                }
                                if (test) {
                                  if (IndexInterRegis == 2) {
                                    // insertar el usuario en la base de datos
                                    int stado = await clres?.insert(
                                        Cliente.fromJson({
                                          "nombre": _listcontroler[0].text,
                                          "celular":
                                              int.parse(_listcontroler[1].text),
                                          "correo": _listcontroler[2].text,
                                          "usser": _listcontroler[3].text,
                                          "pass": _listcontroler[4].text,
                                          "direccion": _listcontroler[5].text,
                                          "direccion_alt":
                                              _listcontroler[6].text,
                                          "foto":
                                              "http://localhost:9000/img/sticker.webp",
                                        }),
                                        (a) {}) as int;
                                    switch (stado) {
                                      case 200:
                                        mensajealert().customShapeSnackBar(
                                            this._context as BuildContext,
                                            "Se a registrado correctamente",
                                            "T");
                                        break;
                                      default:
                                        mensajealert().customShapeSnackBar(
                                            this._context as BuildContext,
                                            "Parece que hay una advertencia",
                                            "R");
                                    }
                                    //iniciar secion
                                    Datosuser dat = await usres!.read({
                                      "usser": _listcontroler[3].text,
                                      "pass": _listcontroler[4].text
                                    });
                                    if (dat.getiduser != 0) {
                                      await bd.update(dat.toJson());
                                      print("inicio secion el usuario");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()),
                                      );
                                    } else {
                                      print("no se a logrado iniciar secion");
                                    }
                                    print("insetado correctamente");
                                  }
                                } else {
                                  print("Evitar que las casillas esten vacias");
                                }
                                setState(() {});
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Continuar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(0xff707070),
                    ),
                  ),
                  (!isKeyboard)
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              "¿Ya tienes una cuenta?. Inicia Secion",
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                //colorFilter: ColorFilter.linearToSrgbGamma(),
                fit: BoxFit.cover,
                image: Image.asset("src/fondologin.jpg").image)),
      ),
    );
  }

  Widget iteninfo(
      BuildContext context, IconData icon, String label, var info, int inx) {
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
              height: 60,
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
                          height: 40,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: TextField(
                                    //focusNode: _focus[inx],
                                    keyboardType: (inx == 1)
                                        ? TextInputType.number
                                        : TextInputType.text,
                                    style: TextStyle(fontSize: 15),
                                    controller: this._listcontroler[inx],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Escribe un mensaje'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xff707070).withOpacity(0.4),
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
