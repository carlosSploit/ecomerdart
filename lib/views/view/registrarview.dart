//import 'package:ecomersbaic/Cache.dart';
import 'dart:ui';
import 'package:ecomersbaic/config/validador.dart';
import 'package:flutter/services.dart';
import '../../config/configinterface.dart';
import '../../controllers/cliente.dart';
import '../../controllers/datosuser.dart';
import '../../negocio/usuarios_negocio.dart';
import '../../negocio/cliente_negocio.dart';
import '../../views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import '../../config/bdcache.dart';
import '../../main.dart';
import '../components/texfielddefault.dart';

// ignore: camel_case_types
class registrarview extends StatefulWidget {
  bool band = true;
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
  late configinterface config;
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
    config = configinterface(context);
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
                              fontSize: config.getsizeaproxhight(30),
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
                              fontSize: config.getsizeaproxhight(14),
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
                      max: 2,
                      activeColor: Color(0xff707070),
                      inactiveColor: Color(0xff707070).withOpacity(0.3),
                      divisions: 2,
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
                                        iteninfo(
                                            context,
                                            false,
                                            Icons.person,
                                            this.list[0].toString(),
                                            10000,
                                            "T",
                                            this._listcontroler[0]),
                                        iteninfo(
                                            context,
                                            false,
                                            Icons.person,
                                            this.list[1].toString(),
                                            9,
                                            "N",
                                            this._listcontroler[1]),
                                        iteninfo(
                                            context,
                                            false,
                                            Icons.person,
                                            this.list[2].toString(),
                                            10000,
                                            "T",
                                            this._listcontroler[2])
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
                                        iteninfo(
                                            context,
                                            false,
                                            Icons.person,
                                            this.list[3].toString(),
                                            10000,
                                            "T",
                                            this._listcontroler[3]),
                                        iteninfo(
                                            context,
                                            false,
                                            Icons.person,
                                            this.list[4].toString(),
                                            10000,
                                            "P",
                                            this._listcontroler[4]),
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
                                        iteninfo(
                                            context,
                                            false,
                                            Icons.person,
                                            this.list[5].toString(),
                                            10000,
                                            "T",
                                            this._listcontroler[5]),
                                        iteninfo(
                                            context,
                                            false,
                                            Icons.person,
                                            this.list[6].toString(),
                                            10000,
                                            "T",
                                            this._listcontroler[6]),
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
                    height: config.getsizeaproxhight(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        (IndexInterRegis != 0)
                            ? Expanded(
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
                              )
                            : Container(),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              bool test = true;
                              // mensaje de error
                              String mensaje =
                                  "Evitar que las casillas esten vacias";
                              validador val = validador();
                              // antes de insertar los datos;
                              if (IndexInterRegis < 2) {
                                test = true;
                                // inicializar variable pes
                                for (var i = validecontes[IndexInterRegis][0];
                                    i < validecontes[IndexInterRegis][1] + 1;
                                    i++) {
                                  switch (i) {
                                    case 0:
                                      if (!(val.valName(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta un nombre mal escrito";
                                      }
                                      break;
                                    case 1:
                                      if (!(val.valCelular(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta un celular mal escrito";
                                      }
                                      break;
                                    case 2:
                                      if (!(val.valCorreo(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta un correo mal escrito";
                                      }
                                      break;
                                    case 3:
                                      if (!(val.valvacio(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje = "Presenta un usuario vacio";
                                      }
                                      break;
                                    case 4:
                                      if (!(val.valpassword(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta una contraseña insegura";
                                      }
                                      break;
                                    case 5:
                                      if (!(val.valvacio(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta una direccion vacia";
                                      }
                                      break;
                                    case 6:
                                      if (!(val.valvacio(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta una direccion alterna vacia";
                                      }
                                      break;
                                    default:
                                  }
                                }
                                if (test) {
                                  if (IndexInterRegis == 1) {
                                    // comprueba si el usuario a registrar ya esiste
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
                                      mensajealert().customShapeSnackBar(
                                          this._context as BuildContext,
                                          "El usuario ya existe",
                                          "R");
                                    } else {
                                      IndexInterRegis++;
                                    }
                                  } else {
                                    IndexInterRegis++;
                                  }
                                } else {
                                  mensajealert().customShapeSnackBar(
                                      this._context as BuildContext,
                                      "${mensaje}",
                                      "R");
                                }
                                setState(() {});
                              } else {
                                test = true;
                                // cuando este en la pocicion de insertar
                                for (var i = validecontes[IndexInterRegis][0];
                                    i < validecontes[IndexInterRegis][1] + 1;
                                    i++) {
                                  switch (i) {
                                    case 5:
                                      if (!(val.valvacio(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta una direccion vacia";
                                      }
                                      break;
                                    case 6:
                                      if (!(val.valvacio(
                                          this._listcontroler[i].text))) {
                                        test = false;
                                        mensaje =
                                            "Presenta una direccion alterna vacia";
                                      }
                                      break;
                                    default:
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
                                    // comprueba si hay un error al realizar la insercion
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
                                    // comprueba si hubo un error al insertar el usuario
                                    if (dat.getiduser != 0) {
                                      await bd.update(dat.toJson());
                                      List<Datosuser> lista = await bd.list();
                                      mensajealert().customShapeSnackBar(
                                          this._context as BuildContext,
                                          "Se creo la cuenta con exito",
                                          "T");
                                      Future.delayed(Duration(seconds: 6), () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp(
                                                  lista[0].getidinterface)),
                                        );
                                      });
                                    } else {
                                      print("no se a logrado iniciar secion");
                                    }
                                    print("insetado correctamente");
                                  }
                                } else {
                                  mensajealert().customShapeSnackBar(
                                      this._context as BuildContext,
                                      "${mensaje}",
                                      "R");
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
                                    fontSize: config.getsizeaproxhight(14),
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
                              MaterialPageRoute(builder: (context) => MyApp(0)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              "¿Ya tienes una cuenta?. Inicia Secion",
                              style: TextStyle(
                                fontSize: config.getsizeaproxhight(14),
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
      BuildContext context,
      bool valicon,
      IconData icon,
      String label,
      int lengthcarac,
      String tipo,
      TextEditingController textcontrol) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          if (valicon)
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
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: TextField(
                                    //focusNode: _focus[inx],
                                    // tipo de texto a ingresar
                                    keyboardType: (tipo == "N")
                                        ? TextInputType.number
                                        : (tipo == "T")
                                            ? TextInputType.text
                                            : (tipo == "C")
                                                ? TextInputType.emailAddress
                                                : (tipo == "P")
                                                    ? TextInputType
                                                        .visiblePassword
                                                    : TextInputType.text,
                                    style: TextStyle(
                                      fontSize: config.getsizeaproxhight(15),
                                    ),
                                    onChanged: (String newVal) {
                                      if (newVal.length <= lengthcarac) {
                                        //textcontrol.text = newVal;
                                        print("${newVal} - text propuest");
                                      } else {
                                        textcontrol.text = newVal.substring(
                                            0, newVal.length - 1);
                                      }
                                    },
                                    controller: textcontrol,
                                    obscureText:
                                        (tipo == "P") ? widget.band : false,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Escribe $label',
                                      suffixIcon: (tipo == "P")
                                          ? IconButton(
                                              color: Color(0xff707070),
                                              onPressed: () {
                                                setState(() {
                                                  widget.band = !widget.band;
                                                });
                                              },
                                              icon: Icon((widget.band)
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            )
                                          : Container(
                                              width: 1,
                                            ),
                                    ),
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
