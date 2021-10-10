import 'package:ecomersbaic/Cache.dart';
import 'package:ecomersbaic/controllers/Pedido.dart';
import 'package:ecomersbaic/controllers/datosuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ecomersbaic/views/pedidosview/components/pedidoitenview.dart';
import 'package:ecomersbaic/negocio/pedido_negocio.dart';
//import 'package:whatsappfrond/homeview/components/messegeview.dart';

// ignore: camel_case_types
class pedidoview extends StatefulWidget {
  @override
  pedidobody createState() => pedidobody();
}

// ignore: camel_case_types
class pedidobody extends State<pedidoview> {
  int _selexidestado = 1;
  Datosuser? controller;

  void actualic(int index) {
    setState(() {});
    _selexidestado = index;
  }

  late TextEditingController textEditingController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    //var conte2 = 0; //impares
    var conte = 0; //pares
    var size = MediaQuery.of(context).size;
    var pedres = PedidoNegocio();
    // ignore: non_constant_identifier_names
    var Controler = cache();

    return FutureBuilder<Datosuser>(
        future: Controler.extracvar(),
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Container(
              child: Align(
                alignment: Alignment.center,
                child: Text("Error al listar los productos"),
              ),
            );
          }
          //------------------------------------------------
          //capturar las categorias
          var list = snapshot.data ?? Datosuser.fromJson({});
          //control.update();
          controller = list;
          return new Column(
            //controller: _scrollController,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: size.width,
                height: 50,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: Size.fromHeight(105.0).height,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
                              child: InkWell(
                                child: Icon(
                                  Icons.search,
                                  size: 25,
                                  color: Colors.grey[600],
                                ),
                                onTap: () {
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Escribe un mensaje'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xff707070).withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _buildChip(1, "Almacen", Color(0xff707070)),
                          _buildChip(2, "Enviado", Color(0xff707070)),
                          _buildChip(3, "Entregado", Color(0xff707070)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Contenedor de los productos
              FutureBuilder<List<Pedido>>(
                future: pedres.getlist({
                  "iduser": (controller!.gettiouse != "T")
                      ? controller!.getidclient
                      : 0,
                  "estado": _selexidestado,
                  "idpedi": textEditingController.text
                }),
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
                  var list = snapshot.data?.length ?? 0;
                  List<Widget> cat = [];
                  for (var i = 0; i < list; i++) {
                    var catg = snapshot.data?[i];
                    cat.add(
                      pedidoitenview(
                          catg?.getestapedi,
                          300,
                          catg?.getidpro,
                          catg?.getvent.getcant,
                          catg?.getvent.getfech as String,
                          catg?.getvent.getmontoc as double),
                    );
                  }

                  conte = (list * (80 + 10)) + 80;

                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: conte.toDouble(),
                    color: Colors.white,
                    child: Column(
                      children: cat,
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  // cart de cada categoria, el cual actualizara el estado
  Widget _buildChip(int idexcat, String label, Color color) {
    return InkWell(
      onTap: () {
        actualic(idexcat);
        print(this._selexidestado);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Chip(
          labelPadding: EdgeInsets.all(2.0),
          avatar: CircleAvatar(
            backgroundColor:
                (this._selexidestado == idexcat) ? Colors.white : color,
            child: Text(
              label[0].toUpperCase(),
              style: TextStyle(
                  color:
                      (this._selexidestado == idexcat) ? color : Colors.white),
            ),
          ),
          label: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              label,
              style: TextStyle(
                color: (this._selexidestado == idexcat) ? Colors.white : color,
              ),
            ),
          ),
          backgroundColor:
              (this._selexidestado == idexcat) ? color : Colors.white,
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          padding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
