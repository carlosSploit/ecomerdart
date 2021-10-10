import 'package:ecomersbaic/Cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ecomersbaic/views/usuariosview/components/edituserview.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: camel_case_types, must_be_immutable
class productanaliticview extends StatefulWidget {
  int idusuario = 1;
  int higth = 0;
  String nombre = "";
  String urlfoto = "";
  int cantidad = 0;
  double ganacia = 0.0;
  ValueChanged<int> actulist = (a) {};
  cache control = cache();

  productanaliticview(this.idusuario, this.higth, this.nombre, this.urlfoto,
      this.cantidad, this.ganacia, this.actulist);

  @override
  productanaliticbody createState() => productanaliticbody();
}

// ignore: camel_case_types
class productanaliticbody extends State<productanaliticview> {
  productanaliticbody();

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
    int heig = 70;
    String imageperfil = widget.urlfoto;
    imageperfil = (imageperfil == "")
        ? "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg"
        : imageperfil.replaceAll(
            "localhost:9000", widget.control.getdomain.toString());
    //************* Inten ***************/
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 0, 8),
        width: size.height,
        height: double.parse(heig.toString()),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: double.parse(heig.toString()),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 50,
                        height: 50,
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
                  flex: 5,
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Cant: ${widget.cantidad}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
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
                                child: Text("S/.${widget.ganacia}"),
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
        ),
      ),
      onTap: () {
      },
    );
    //***********************************************/;
  }
}
