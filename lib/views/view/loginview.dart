import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/configinterface.dart';
import '../../config/bdcache.dart';
import '../../controllers/datosuser.dart';
import '../../main.dart';
import '../../views/view/mainpedidoview.dart';
import '../../negocio/usuarios_negocio.dart';
import '../../views/components/mensajealert.dart';

// ignore: camel_case_types
class loginView extends StatefulWidget {
  bool band = true;
  loginView();

  @override
  loginbody createState() => loginbody();
}

// ignore: camel_case_types
class loginbody extends State<loginView> {
  String usser = "";
  String pass = "";
  UsuarioNegocio? usres;
  late configinterface config;

  loginbody();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    usres = UsuarioNegocio();
    config = configinterface(context);
    //####################################
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
              padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
              margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (!isKeyboard)
                      ? InkWell(
                          child: Container(
                            width: config.getsizeaproxhight(150),
                            height: config.getsizeaproxhight(150),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: Image.asset("src/logo.jpg").image)),
                          ),
                          onTap: () {},
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      "Iniciar Secion",
                      style: TextStyle(
                        fontSize: config.getsizeaproxhight(30),
                        fontWeight: FontWeight.w800,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  ),
                  if (!isKeyboard)
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        "Coloca tu usuario y tu contraseña para iniciar con la secion",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: config.getsizeaproxhight(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: config.getsizeaproxhight(14),
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Escribe tu usuario',
                              ),
                              onChanged: (value) {
                                this.usser = value;
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
                        color: Color(0xff707070).withOpacity(0.4),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: config.getsizeaproxhight(40),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: config.getsizeaproxhight(14),
                              ),
                              obscureText: widget.band,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Escribe tu password',
                                  suffixIcon: IconButton(
                                    focusColor: Color(0xff707070),
                                    hoverColor: Color(0xff707070),
                                    color: Color(0xff707070),
                                    onPressed: () {
                                      setState(() {
                                        widget.band = !widget.band;
                                      });
                                    },
                                    icon: Icon((widget.band)
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  )),
                              onChanged: (value) {
                                this.pass = value;
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
                        color: Color(0xff707070).withOpacity(0.4),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    height: config.getsizeaproxhight(40),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            Datosuser dat = await usres!
                                .read({"usser": usser, "pass": pass});
                            if (dat.getiduser != 0) {
                              await bd.update(dat.toJson());
                              List<Datosuser> lista = await bd.list();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyApp(lista[0].getidinterface)),
                              );
                              this.usser = "";
                              this.pass = "";
                            } else {
                              mensajealert().customShapeSnackBar(
                                  context, "Error a iniciar seccion", "R");
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Iniciar secion",
                                style: TextStyle(
                                  fontSize: config.getsizeaproxhight(14),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(0xff707070),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mainregistreview()),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Expanded(
                          child: Text(
                            "¿No estas registrado?. Registrate",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: config.getsizeaproxhight(14),
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                        )),
                  ),
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
}
