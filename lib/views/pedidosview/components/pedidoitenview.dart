import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ecomersbaic/views/pedidosview/view/mainpedidoview.dart';

// ignore: camel_case_types, must_be_immutable
class pedidoitenview extends StatefulWidget {
  int estado = 1;
  int higth = 0;
  int idpedido = 0;
  int cantp = 0;
  String fecha = "";
  double monto = 0;

  pedidoitenview(this.estado, this.higth, this.idpedido, this.cantp, this.fecha,
      this.monto);

  @override
  pedidoitenbody createState() => pedidoitenbody();
}

// ignore: camel_case_types
class pedidoitenbody extends State<pedidoitenview> {
  pedidoitenbody();

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
    int heig = 80;
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
                        width: 50,
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: icons[widget.estado - 1],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25),
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
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "${widget.idpedido} - ${estadoName[widget.estado - 1]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                                //color: Colors.amber,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "${widget.fecha}",
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                                //color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(3),
                                child: Container(
                                  width:
                                      "${widget.cantp} productos".length * 10,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${widget.cantp} productos",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  decoration: new BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                //color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "S/ ${widget.monto}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => mainpedidoview(0, widget.idpedido, "P")),
        );
      },
    );
    //***********************************************/;
  }
}
