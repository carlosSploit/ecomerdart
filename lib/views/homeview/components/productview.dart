import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import '../../../controllers/datosuser.dart';
import '../../../views/comentview/view/maincomentview.dart';
import '../../../views/homeview/components/producteditview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../views/homeview/components/loverview.dart';
import '../../../views/homeview/view/mainproductoview.dart';

// ignore: camel_case_types, must_be_immutable
class publicaitenview extends StatefulWidget {
  int band = 0;
  int higth = 0;
  String nombre = "";
  String url = "";
  String descripccion = "";
  double pressio = 0;
  int idproducto = 0;
  int stock = 0;
  int califica = 0;
  ValueChanged<int> actualist;
  Datosuser? controller;

  publicaitenview(
      this.band,
      this.higth,
      this.nombre,
      this.url,
      this.descripccion,
      this.pressio,
      this.idproducto,
      this.califica,
      this.stock,
      this.actualist);

  int get gethigth {
    return this.higth;
  }

  @override
  publicaitenbody createState() => publicaitenbody();
}

// ignore: camel_case_types
class publicaitenbody extends State<publicaitenview> {
  late configinterface config;
  publicaitenbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    config = configinterface(context);
    var control = cache();
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
          widget.controller = list;
          //####################################
          return InkWell(
            child: Stack(
              children: [
                Container(
                  width: 200,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: widget.higth.toDouble(),
                        child: Stack(
                          children: [
                            Container(
                              //padding: EdgeInsets.all(6),
                              height: widget.higth.toDouble(),
                              width: 200,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: config.getsizeaproxhight(90),
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 5, 5),
                                    height: config.getsizeaproxhight(70),
                                    //color: Colors.blue,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text(
                                              (widget.nombre.length > 20)
                                                  ? widget.nombre
                                                  .substring(0, 20)
                                                  : widget.nombre,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: config.getsizeaproxhight(16),
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                widget.descripccion,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: config.getsizeaproxhight(15),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Row(
                                            children: [
                                              (widget.controller?.gettiouse !=
                                                      "C")
                                                  ? Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        alignment: Alignment.centerLeft,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 5, 0),
                                                        child: InkWell(
                                                          child: Icon(Icons
                                                              .chat_bubble_rounded,
                                                            size: config.getsizeaproxhight(24),
                                                            color: Color(0xff707070).withOpacity(0.5),
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    maincomentview(widget.idproducto),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              Expanded(
                                                flex: 6,
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                                  child: Text(
                                                    "S/." +
                                                        widget.pressio
                                                            .toString(),
                                                    textAlign: (widget
                                                                .controller
                                                                ?.gettiouse !=
                                                            "C")
                                                        ? TextAlign.right
                                                        : TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: config.getsizeaproxhight(18),
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              (widget.controller?.gettiouse ==
                                                      "C")
                                                  ? Container(
                                                margin:
                                                EdgeInsets.fromLTRB(0, 0, 15, 0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          0, 0, 8, 0),
                                                      child: Icon(
                                                          Icons.inventory_2,
                                                      size: config.getsizeaproxhight(24),
                                                      color: Color(0xff707070).withOpacity(0.5),),
                                                    ),
                                                    Text(
                                                      "${widget.stock}",
                                                      style: TextStyle(fontSize: config.getsizeaproxhight(18),),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //color: Colors.amber,
                            ),
                            Container(
                              //padding: EdgeInsets.all(6),
                              height: widget.higth.toDouble(),
                              width: 200,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: config.getsizeaproxhight(50),
                                  margin:
                                  EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      (widget.controller?.gettiouse !=
                                          "C")
                                          ? Expanded(
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          margin:
                                          EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 35.0 +
                                                    (widget.califica
                                                        .toString()
                                                        .length *
                                                        25.0),
                                                height: config.getsizeaproxhight(35),
                                                child: Align(
                                                    alignment:
                                                    Alignment
                                                        .center,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.fromLTRB(
                                                              10,
                                                              0,
                                                              0,
                                                              0),
                                                          child:
                                                          Icon(
                                                            Icons
                                                                .favorite,
                                                            color:
                                                            Colors.white,
                                                            size: config.getsizeaproxhight(35) *
                                                                0.51,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.fromLTRB(
                                                              10,
                                                              0,
                                                              0,
                                                              0),
                                                          child:
                                                          Text(
                                                            "${widget.califica}",
                                                            style:
                                                            TextStyle(color: Colors.white,fontSize: config.getsizeaproxhight(15),),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                decoration:
                                                BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      35.0 /
                                                          2),
                                                  color: Colors
                                                      .grey
                                                      .withOpacity(
                                                      0.6),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                          : Container(),
                                      (widget.controller?.gettiouse ==
                                          "C")
                                          ? loverview(
                                        config.getsizeaproxhight(35).toInt(),
                                        widget.controller
                                            ?.getidclient as int,
                                        widget.idproducto,
                                        widget.band,
                                        funcction,
                                      )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ),
                              //color: Colors.amber,
                            ),
                            (widget.stock <= 0)
                                ? Container(
                                    height: widget.higth.toDouble(),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 20),
                                        child: Icon(
                                          Icons.production_quantity_limits,
                                          size: config.getsizeaproxhight(60),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new Image.network(widget.url).image,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              (widget.controller?.gettiouse != "C")
                  ? contentserview(widget.idproducto, widget.actualist)
                      .createDialog(context)
                  : (widget.stock > 0)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  mainproductoview(widget.idproducto)),
                        )
                      // ignore: unnecessary_statements
                      : () {};
            },
          );
        });

    //***********************************************/;
  }

  void funcction(int a) {}
}
