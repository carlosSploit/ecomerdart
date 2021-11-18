import 'package:ecomersbaic/config/bdcache.dart';

import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import '../../../controllers/Carritocomp.dart';
import '../../../controllers/Pedido.dart';
import '../../../controllers/datosuser.dart';
import '../../../controllers/detalle_carrito.dart';
import '../../../controllers/detalle_vent.dart';
import '../../../views/components/mensajealert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../negocio/pedido_negocio.dart';
import '../../../views/pedidosview/components/pedidoproductitenview.dart';
import '../../../main.dart';
import '../../../negocio/carrritocon_negocio.dart';

// ignore: camel_case_types, must_be_immutable
class pedidointerfview extends StatefulWidget {
  int idpedido;
  int idcarrito;
  String tipointe;
  Widget memoriwi = Container();
  pedidointerfview(this.idcarrito, this.idpedido, this.tipointe);

  @override
  pedidointerfbody createState() => pedidointerfbody();
}

// ignore: camel_case_types
class pedidointerfbody extends State<pedidointerfview> {
  int _selexidestado = 1;
  DateTime _seletdate = DateTime.now();
  var pedres = PedidoNegocio();
  var carr = CarritoConNegocio();
  Datosuser controller = Datosuser();
  var tipuser = "";
  cache control = cache();
  // archivos de memoria
  Pedido pedi = Pedido.fromJson({});
  Carritocomp carrico = Carritocomp.fromJson({});
  BuildContext? _context;
  late configinterface config;

  //########### creacion del col de llamado del datepicker
  void callDatePicker() async {
    var selecteDate = await getDatePickerWidget();
    setState(() {
      _seletdate = selecteDate;
    });
  }

  getDatePickerWidget() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value == null) {
        return DateTime.now();
      } else {
        setState(() {
          _seletdate = value;
        });
      }
    });
  }

  // #########################################################
  void actualic(int index) {
    pedres.actualiestade({"idpedido": widget.idpedido, "estade": index});
    _selexidestado = index;
    setState(() {});
  }

  // late TextEditingController textEditingController =
  //     TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    // var conte2 = 0; //impares
    // var conte = 0; //pares
    //####################################
    //####################################
    _context = context;
    var size = MediaQuery.of(context).size;
    config = configinterface(context);

    return FutureBuilder<Datosuser>(
      future: control.extracvar(), // envia parametros
      builder: (context, snapshot) {
        //validadores del estado------------------------

        if (snapshot.connectionState == ConnectionState.waiting) {
          return (widget.memoriwi == Container())
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : widget.memoriwi;
        }
        if (snapshot.hasError) {
          print(snapshot.error);
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
        controller = list;
        this.tipuser = controller.gettiouse;

        print("${controller.gettiouse} - ${widget.tipointe}");

        widget.memoriwi = new Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              child: Container(
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: config.getsizeaproxhight(30),
                  color: Colors.grey.withOpacity(0.9),
                ),
              ),
              onTap: () async {
                List<Datosuser> lista = await bd.list();
                print("${lista[0].getidinterface} - interface user");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(lista[0].getidinterface)),
                );
              },
            ),
            title: Container(
              width: 300,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  (widget.tipointe == "C")
                      ? "Carrito de Compras"
                      : "Pedido - ${widget.idpedido}",
                  style: TextStyle(
                    fontSize: config.getsizeaproxhight(25),
                    color: Color(0xff707070),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            // title: Container(
            //   width: double.infinity,
            //   child: Image.asset(
            //     "src/iconprinci.png",
            //     height: 40,
            //   ),
            // ),
            actions: <Widget>[],
          ),
          body: (widget.tipointe != "C")
              ? FutureBuilder<Pedido>(
                  future: pedres.read({
                    "id_pedido": widget.idpedido,
                    "tipouser": tipuser
                    // "estado": _selexidestado,
                    // "idpedi": textEditingController.text
                  }),
                  builder: (context, snapshot) {
                    //validadores del estado------------------------
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // cargar datos anteriorespara evitar animacion de recarga
                      return (pedi.getvent.getmontoc == 0.0)
                          ? Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())
                          : _contenedorpedidocard(size, pedi,
                              Carritocomp.fromJson({}), widget.tipointe);
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error al cargar las categorias"),
                      );
                    }
                    //------------------------------------------------
                    //capturar las categorias
                    var list = snapshot.data ?? Pedido.fromJson({});
                    pedi = list;
                    _selexidestado = list.getestapedi;
                    return _contenedorpedidocard(
                        size, list, Carritocomp.fromJson({}), widget.tipointe);
                  },
                )
              : FutureBuilder<Carritocomp>(
                  future: carr.read({
                    "id_carrito": controller.getidcarrito,
                    // "estado": _selexidestado,
                    // "idpedi": textEditingController.text
                  }),
                  builder: (context, snapshot) {
                    //validadores del estado------------------------
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return (carrico.getmontotal == 0)
                          ? Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())
                          : _contenedorpedidocard(size, Pedido.fromJson({}),
                              carrico, widget.tipointe);
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error al cargar las categorias"),
                      );
                    }
                    //------------------------------------------------
                    //capturar las categorias
                    var list = snapshot.data ?? Carritocomp.fromJson({});
                    carrico = list;
                    print(list.getid_carrito);
                    //_selexidestado = list.getesta_pedi;
                    //return _contenedor_pedido_card(
                    //    size, Pedido.fromJson({}), list, tipuser);
                    return _contenedorpedidocard(
                        size, Pedido.fromJson({}), list, widget.tipointe);
                  },
                ),
        );
        return widget.memoriwi;
      },
    );
  }

  //estado del pedido, teniendo en cuenta sus iconos
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
  ////estado del pedido, teniendo en cuenta sus labels
  List<String> estadoName = <String>["Almacen", "Enviado", "Entregado"];

  // cart de cada categoria, el cual actualizara el estado
  Widget _buildChip(String label, Color color, int estade) {
    return InkWell(
      onTap: () {
        // ignore: unnecessary_statements
        (controller.gettiouse == "T") ? actualic(estade) : null;
        print(this._selexidestado);
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: config.getsizeaproxhight(50),
                height: config.getsizeaproxhight(50),
                child: Icon(
                  icons[estade - 1].icon,
                  size: config.getsizeaproxhight(24),
                  color: (this._selexidestado >= estade) ? Colors.white : color,
                ),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (this._selexidestado >= estade)
                      ? Colors.green
                      : Colors.white,
                ),
              ),
              Container(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: config.getsizeaproxhight(14),
                    fontWeight: FontWeight.w700,
                    color: (this._selexidestado >= estade)
                        ? Colors.green
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // cart de cada categoria, el cual actualizara el estado
  Widget _contenedorpedidocard(
      Size size, Pedido list, Carritocomp ccp, String tipointerf) {
    //var df = DateFormat('');
    //print("${controller.getidcarrit}");
    return Container(
      color: Colors.grey.shade200.withOpacity(0.2),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              //color: Colors.grey.withOpacity(0.3),
              child: ListView(
                children: [
                  //################## informacion del pedido ###############
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    //padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // datos numero 1
                        // detaller de un pedido realizado
                        (tipointerf != "C")
                            ? FutureBuilder<List<Dettallv>>(
                                future: pedres.listdet({
                                  "id_pedido": widget.idpedido,
                                }),
                                builder: (context, snapshot) {
                                  //validadores del estado------------------------
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Align(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          "Error al cargar las categorias"),
                                    );
                                  }
                                  //------------------------------------------------
                                  //capturar las categorias
                                  var list = snapshot.data?.length ?? 0;

                                  List<Widget> cat = [];
                                  for (var i = 0; i < list; i++) {
                                    var catg = snapshot.data?[i];
                                    cat.add(pedidoproductitenview(
                                        300,
                                        catg?.getproduc.getidpro,
                                        widget.idcarrito,
                                        catg?.getcant,
                                        catg?.getproduc.getname,
                                        catg?.getproduc.getdesc,
                                        catg?.getprecioP,
                                        widget.tipointe,
                                        catg?.getproduc.getfoto.replaceAll(
                                                "localhost:9000",
                                                control.getdomain.toString())
                                            as String,
                                        _actionactualiz,
                                        _eliminarprod));
                                  }
                                  return (list != 0)
                                      ? Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 2, 0, 2),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: cat,
                                          ),
                                        )
                                      : Container(
                                          color: Colors.white,
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 10),
                                          height: config.getsizeaproxhight(100),
                                          width: size.width,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 5),
                                                  child: Icon(
                                                    Icons
                                                        .production_quantity_limits,
                                                    color: Colors.grey[600],
                                                    size: config
                                                        .getsizeaproxhight(50),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "No hay productos en cesta",
                                                    style: TextStyle(
                                                      color: Color(0xff707070),
                                                      fontSize: config
                                                          .getsizeaproxhight(
                                                              15),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              )
                            : FutureBuilder<List<DettallCa>>(
                                future: carr.listdet({
                                  "id_carritos": controller.getidcarrito,
                                }),
                                builder: (context, snapshot) {
                                  //validadores del estado------------------------
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Align(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          "Error al cargar las categorias"),
                                    );
                                  }
                                  //------------------------------------------------
                                  //capturar las categorias
                                  var list = snapshot.data?.length ?? 0;
                                  List<Widget> cat = [];
                                  for (var i = 0; i < list; i++) {
                                    var catg = snapshot.data?[i];
                                    cat.add(pedidoproductitenview(
                                        config.getsizeaproxhight(300).toInt(),
                                        catg?.getproduc.getidpro,
                                        widget.idcarrito,
                                        catg?.getcant,
                                        catg?.getproduc.getname,
                                        catg?.getproduc.getdesc,
                                        catg?.getprecioP,
                                        widget.tipointe,
                                        catg?.getproduc.getfoto.replaceAll(
                                                "localhost:9000",
                                                control.getdomain.toString())
                                            as String,
                                        _actionactualiz,
                                        _eliminarprod));
                                  }
                                  return (list != 0)
                                      ? Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: cat,
                                          ),
                                        )
                                      : Container(
                                          color: Colors.white,
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 10),
                                          height: config.getsizeaproxhight(100),
                                          width: size.width,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 5),
                                                  child: Icon(
                                                    Icons
                                                        .production_quantity_limits,
                                                    color: Colors.grey[600],
                                                    size: config
                                                        .getsizeaproxhight(50),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "No hay productos en cesta",
                                                    style: TextStyle(
                                                      color: Color(0xff707070),
                                                      fontSize: config
                                                          .getsizeaproxhight(
                                                              15),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  //#########################################################

                  (widget.tipointe == "C")
                      ? Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text(
                                          // ignore: unnecessary_null_comparison
                                          (_seletdate == null)
                                              ? "10/21/2021"
                                              : "${_seletdate.year}-${(_seletdate.month < 10) ? ("0" + _seletdate.month.toString()) : _seletdate.month}-${(_seletdate.day < 10) ? ("0" + _seletdate.day.toString()) : _seletdate.day}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                config.getsizeaproxhight(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: () {
                                            getDatePickerWidget();
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 5, 15, 5),
                                            child: Text(
                                              "fecha de envio",
                                              style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: config
                                                    .getsizeaproxhight(20),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              // datos numero 1 - Falta validadr que el tipo de usuario que esta viendo esto, un trabajador o cliente
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff707070),
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        child: Text(
                                          "Monto: S/ ${(list.getvent.getmontoV + list.getvent.getmontoT + list.getvent.getmontoigv)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize:
                                                config.getsizeaproxhight(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // datos numero 1 - Falta validadr que el tipo de usuario que esta viendo esto, un trabajador o cliente
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff707070),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                  //################## informacion del pedido ###############
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    "Cliente",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(23),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // datos numero 1 - Falta validadr que el tipo de usuario que esta viendo esto, un trabajador o cliente
                        (tipointerf != "C" && this.tipuser == "T")
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(15, 0, 0, 5),
                                        child: Text(
                                          "Nombre: ",
                                          style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize:
                                                config.getsizeaproxhight(18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 15, 5),
                                        child: Text(
                                          "${list.getvent.getclien.getnombre}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                config.getsizeaproxhight(16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        // datos numero 1
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                  child: Text(
                                    "Direccion: ",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text(
                                    "${(tipointerf != "C") ? list.getvent.getclien.getdirecc : ccp.getclien.getdirecc}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: config.getsizeaproxhight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //###################################################
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                  child: Text(
                                    "Direccion Alterna: ",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text(
                                    "${(tipointerf != "C") ? list.getvent.getclien.gedirec_a : ccp.getclien.gedirec_a}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: config.getsizeaproxhight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  //##########################################################
                  //################## informacion del pedido ###############
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    "Informacion de Pedido",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(23),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // datos numero 1
                        (widget.tipointe == "P")
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(15, 0, 0, 5),
                                        child: Text(
                                          "Fecha limite entrega: ",
                                          style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize:
                                                config.getsizeaproxhight(18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 15, 5),
                                        child: Text(
                                          "${(tipointerf != "C") ? list.getfechent : ""}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                config.getsizeaproxhight(16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        //#######################################################
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                  child: Text(
                                    "Lugar de envio: ",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text(
                                    "${(tipointerf == "C") ? ccp.getdestino : ((tipointerf != "C") ? list.getvent.getlugar : "Piura/Peru")}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: config.getsizeaproxhight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                  child: Text(
                                    "Cantidad de Productos: ",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text(
                                    "${(tipointerf != "C") ? list.getvent.getcant : ccp.getcantiproduct}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: config.getsizeaproxhight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // datos numero 1
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                  child: Text(
                                    "Subtotal: ",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text(
                                    "S/.${(tipointerf != "C") ? list.getvent.getmontoT : ccp.getmontotal}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: config.getsizeaproxhight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // datos numero 1
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                  child: Text(
                                    "Monto igv : ",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text(
                                    "S/.${(tipointerf != "C") ? list.getvent.getmontoigv : ccp.getmontoigv}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: config.getsizeaproxhight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //###################################################
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                  child: Text(
                                    "Monto de Envio: ",
                                    style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: config.getsizeaproxhight(18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                                  child: Text(
                                    "S/.${(tipointerf != "C") ? list.getvent.getmontoV : ccp.getmontot}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: config.getsizeaproxhight(16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  //##########################################################
                ],
              ),
            ),
          ),
          Container(
            height: config.getsizeaproxhight(90),
            child: (widget.tipointe == "C")
                ? Row(
                    children: [
                      Expanded(
                        child: Align(
                          child: Container(
                            child: Text(
                              "S/ ${(tipointerf != "C") ? list.getvent.getmontoc : (ccp.getmontot + ccp.getmontotal)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: config.getsizeaproxhight(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: Text(
                                  "Realizar Venta",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff707070),
                                    fontSize: config.getsizeaproxhight(20),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(17.5)),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (ccp.getcantiproduct != 0) {
                              Carritocomp car = await carr.read({
                                "id_carrito": controller.getidcarrito,
                                // "estado": _selexidestado,
                                // "idpedi": textEditingController.text
                              });
                              if (car.getcantiproduct == ccp.getcantiproduct) {
                                int stado = await pedres.realizarpedido({
                                  "id_client": controller.getidclient,
                                  "lugar": 1,
                                  "fecha_ent":
                                      "${_seletdate.year}/${(_seletdate.month < 10) ? ("0" + _seletdate.month.toString()) : _seletdate.month}/${(_seletdate.day < 10) ? ("0" + _seletdate.day.toString()) : _seletdate.day}"
                                });
                                switch (stado) {
                                  case 200:
                                    mensajealert().customShapeSnackBar(
                                        this._context as BuildContext,
                                        "Se a insertado la venta correctamente",
                                        "T");
                                    break;
                                  default:
                                    mensajealert().customShapeSnackBar(
                                        this._context as BuildContext,
                                        "Parece que hay una advertencia",
                                        "R");
                                }
                                print("Ingresando la venta");
                              } else {
                                print(
                                    "Parece ser que hay un cambio en el stock del producto");
                              }

                              setState(() {});
                            } else {
                              print("Ingresa productos al carrito porfavor");
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: _buildChip("Almacen", Color(0xff707070), 1)),
                      Expanded(
                          child: _buildChip("Enviado", Color(0xff707070), 2)),
                      Expanded(
                          child: _buildChip("Entregado", Color(0xff707070), 3)),
                    ],
                  ),
            decoration: BoxDecoration(
              color: Color(0xff707070),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // este metodo se envia para realizar la recarga de datos y el envio de estos

  _actionactualiz(List<int> datos) {
    carr.actualizarcatidad(
        {"idproducto": datos[0], "idcarrito": datos[1], "canti": datos[2]});
    setState(() {});
  }

  // este metodo se envia para realizar la recarga de datos con respecto a una
  // eliminacion

  _eliminarprod(List<int> datos) {
    carr.deletproducto({"id_proc": datos[0], "idcateg": datos[1]});
    setState(() {});
  }
}
