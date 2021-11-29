import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../views/usuariosview/components/edituserview.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: camel_case_types, must_be_immutable
class usuariositenview extends StatefulWidget {
  int idusuario = 1;
  int higth = 0;
  String nombre = "";
  String urlfoto = "";
  String tip = "";
  ValueChanged<int> actulist = (a) {};
  cache control = cache();

  usuariositenview(this.idusuario, this.higth, this.nombre, this.urlfoto,
      this.tip, this.actulist);

  @override
  usuariositenbody createState() => usuariositenbody();
}

// ignore: camel_case_types
class usuariositenbody extends State<usuariositenview> {
  late configinterface config;
  usuariositenbody();

  //Liesta de iconos de los estados del sistema
  List<Icon> icons = <Icon>[
    Icon(
      Icons.inventory_2,
      color: Colors.white,
    ),
    Icon(
      Icons.local_shipping,
      color: Colors.white,
    ),
    Icon(
      Icons.outbox,
      color: Colors.white,
    ),
  ];
  //Liesta de estados del sistema
  List<String> estadoName = <String>["Almacen", "Enviado", "Entregado"];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    config = configinterface(context);
    int heig = config.getsizeaproxhight(80).toInt();
    String imageperfil = widget.urlfoto;
    imageperfil = (imageperfil == "")
        ? "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg"
        : imageperfil;
    config = configinterface(context);
    //************* Inten ***************/
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
        width: size.height,
        height: double.parse(heig.toString()),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: double.parse(heig.toString()),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: config.getsizeaproxhight(50),
                        height: config.getsizeaproxhight(50),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: Image.network(imageperfil).image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    height: double.parse(heig.toString()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                //padding: EdgeInsets.all(5),
                                child: Text(
                                  "${widget.idusuario}",
                                  style: TextStyle(
                                    fontSize: config.getsizeaproxhight(14),
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                ),
                                //color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${widget.nombre}",
                                      style: TextStyle(
                                          fontSize:
                                              config.getsizeaproxhight(15),
                                          color: Colors.black),
                                    ),
                                  ),
                                  // decoration: new BoxDecoration(
                                  //   color: Colors.grey.withOpacity(0.6),
                                  //   borderRadius: BorderRadius.circular(7),
                                  // ),
                                ),
                                //color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    height: double.parse(heig.toString()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: config.getsizeaproxhight(25),
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                //color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
      onTap: () {
        contentserview(widget.idusuario, widget.tip, widget.actulist)
            .createDialog(context);
      },
    );
    //***********************************************/;
  }
}
