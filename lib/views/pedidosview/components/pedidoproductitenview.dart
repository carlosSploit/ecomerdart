import 'package:ecomersbaic/Cache.dart';
import 'package:ecomersbaic/negocio/carrritocon_negocio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: camel_case_types, must_be_immutable
class pedidoproductitenview extends StatefulWidget {
  int higth = 0;
  int idproducto = 0;
  int idcarrito = 0;
  int cantidad = 1;
  String nombre = "";
  String descripccion = "";
  double precio = 0;
  String urlimg = "";
  ValueChanged<List<int>> accionrecarga;
  ValueChanged<List<int>> eliminarproducto;
  // C - P
  String tipoprod = "C";

  pedidoproductitenview(
      this.higth,
      this.idproducto,
      this.idcarrito,
      this.cantidad,
      this.nombre,
      this.descripccion,
      this.precio,
      this.tipoprod,
      this.urlimg,
      this.accionrecarga,
      this.eliminarproducto);

  @override
  pedidoproductitenbody createState() => pedidoproductitenbody();
}

// ignore: camel_case_types
class pedidoproductitenbody extends State<pedidoproductitenview> {
  var carr = CarritoConNegocio();
  cache memori = cache();
  pedidoproductitenbody();

  //Liesta de iconos de los estados del sistema
  //Liesta de estados del sistema

  aumentarcant() {
    print("${widget.idcarrito} - ${widget.idproducto}");
    widget.cantidad++;
    List<int> listdat = [widget.idproducto, widget.idcarrito, widget.cantidad];
    widget.accionrecarga(listdat);
  }

  disminuiacant() {
    if (!(widget.cantidad <= 1)) {
      widget.cantidad--;
      List<int> listdat = [
        widget.idproducto,
        widget.idcarrito,
        widget.cantidad
      ];
      widget.accionrecarga(listdat);
    }
  }

  eliminarproducto() {
    List<int> listdat = [
      widget.idproducto,
      widget.idcarrito,
    ];
    widget.eliminarproducto(listdat);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int heig = 100;
    print(widget.urlimg);
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
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.network("${widget.urlimg}").image,
                          ),
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
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
                              flex: 8,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "${widget.nombre}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${widget.descripccion}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //color: Colors.amber,
                              ),
                            ),
                            (widget.tipoprod == "C")
                                ? Expanded(
                                    child: InkWell(
                                      child: Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                          )
                                          //color: Colors.blue,
                                          ),
                                      onTap: () {
                                        eliminarproducto();
                                      },
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.all(5),
                                      //color: Colors.blue,
                                    ),
                                  ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "S/ ${widget.precio}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff707070),
                                    fontSize: 16,
                                  ),
                                ),
                                //color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text("Cantidad: "),
                                    ),
                                    (widget.tipoprod == "C")
                                        ? InkWell(
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ),
                                              decoration: new BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                  )),
                                            ),
                                            onTap: () {
                                              disminuiacant();
                                              setState(() {});
                                            },
                                          )
                                        : Container(),
                                    (widget.tipoprod == "C")
                                        ? Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Text("${widget.cantidad}"),
                                          )
                                        : Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 5, 15, 5),
                                            child: Text(
                                              "${widget.cantidad}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            decoration: new BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                    (widget.tipoprod == "C")
                                        ? InkWell(
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                              decoration: new BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            onTap: () {
                                              aumentarcant();
                                              setState(() {});
                                            },
                                          )
                                        : Container(),
                                  ],
                                ),
                                //color: Colors.amber,
                              ),
                            )
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
          //borderRadius: BorderRadius.circular(15),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
          // ],
        ),
      ),
      onTap: () {
        // Navigator.push(
        //   context,
        //   //MaterialPageRoute(builder: (context) => mainpedidoview()),
        // );
      },
    );
    //***********************************************/;
  }
}
