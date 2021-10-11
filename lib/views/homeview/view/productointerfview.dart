import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import '../../../controllers/Producto.dart';
import '../../../controllers/datosuser.dart';
import '../../../views/comentview/view/maincomentview.dart';
import '../../../views/homeview/components/loverview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../negocio/producto_negocio.dart';
import '../../../negocio/carrritocon_negocio.dart';
import '../../../main.dart';
import '../../../views/components/mensajealert.dart';

// ignore: camel_case_types, must_be_immutable
class productointerfview extends StatefulWidget {
  int idproducto;
  int cantidad = 1;
  Widget memoriwi = Container();
  //int id_carrito;
  productointerfview(this.idproducto);

  @override
  productointerfbody createState() => productointerfbody();
}

// ignore: camel_case_types
class productointerfbody extends State<productointerfview> {
  //int _selexidestado = 1;
  //DateTime _seletdate = DateTime.now();
  Producto _produtf = Producto.fromJson({});
  var pedres = ProductoNegocio();
  var carr = CarritoConNegocio();
  Datosuser controller = Datosuser();
  var tipuser = "";
  cache control = cache();
  late configinterface config;

  Future<Producto> update() {
    return pedres.read({
      "id_prod": widget.idproducto,
      "id_clin": controller.getidclient
      // "estado": _selexidestado,
      // "idpedi": textEditingController.text
    });
  }

  aumentarcant(int cantstock) {
    if (cantstock > widget.cantidad) {
      widget.cantidad++;
    }
  }

  disminuiacant() {
    if (widget.cantidad > 1) {
      widget.cantidad--;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var conte2 = 0; //impares
    // var conte = 0; //pares
    //####################################
    //inicializamos la cache
    //####################################
    config = configinterface(context);
    var size = MediaQuery.of(context).size;

    //print("${controller.gettipoes} - ${widget.tipointe}");

    return FutureBuilder<Datosuser>(
      future: control.extracvar(),
      builder: (context, snapshot) {
        //validadores del estado------------------------
        if (snapshot.connectionState == ConnectionState.waiting) {
          //captura laa memoria
          return (widget.memoriwi == Container())
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : widget.memoriwi;
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error al cargar las categorias"),
          );
        }
        //------------------------------------------------
        //capturar las categorias
        var list = snapshot.data ?? Datosuser.fromJson({});
        controller = list;
        this.tipuser = controller.gettiouse;
        widget.memoriwi = new Scaffold(
          body: FutureBuilder<Producto>(
            future: pedres.read({
              "id_prod": widget.idproducto,
              "id_clin": controller.getidclient
            }),
            builder: (context, snapshot) {
              //validadores del estado------------------------
              if (snapshot.connectionState == ConnectionState.waiting) {
                //captura laa memoria
                return (_produtf.getidpro == 0)
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator())
                    : contenedorinfoproducto(size, _produtf);
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error al cargar las categorias"),
                );
              }
              //------------------------------------------------
              //capturar las categorias
              var list = snapshot.data ?? Producto.fromJson({});
              _produtf = list;
              return contenedorinfoproducto(size, list);
            },
          ),
        );
        return widget.memoriwi;
      },
    );
  }

  // cart de cada categoria, el cual actualizara el estado
  Widget contenedorinfoproducto(Size size, Producto list) {
    //var df = DateFormat('');
    return Container(
      color: Colors.white,
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: size.height - config.getsizeaproxhight(90),
                decoration: new BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Container(
                height: size.height - config.getsizeaproxhight(90),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: size.height - (size.height - config.getsizeaproxhight(400)) + config.getsizeaproxhight(10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: config.getsizeaproxhight(30),
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          )),
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      //borderRadius: BorderRadius.circular(15),
                      image: new DecorationImage(
                        scale: size.height - config.getsizeaproxhight(400),
                        fit: BoxFit.cover,
                        image: new Image.network(list.getfoto.replaceAll(
                                "localhost:9000", control.getdomain.toString()))
                            .image,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height - config.getsizeaproxhight(90),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: (size.height/2)-config.getsizeaproxhight(100),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(30, 40, 0, 0),
                                child: Text(
                                  "${list.getname}",
                                  style: TextStyle(
                                      fontSize: config.getsizeaproxhight(25),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(0),
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(30, 10, 30, 0),
                                      child: Text(
                                        "${list.getdesc}",
                                        style: TextStyle(fontSize: config.getsizeaproxhight(18)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 20, 15, 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                        child: loverview(
                                            config.getsizeaproxhight(35).toInt(),
                                            controller.getidclient,
                                            list.getidpro,
                                            list.getlove,
                                            funcction),
                                      ),
                                      Text(
                                        "${list.getlcalif}",
                                        style: TextStyle(fontSize: config.getsizeaproxhight(18)),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: InkWell(
                                          child: Icon(Icons
                                              .chat_bubble_outline_outlined),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    maincomentview(
                                                        widget.idproducto),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 15, 0),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 8, 0),
                                              child: Icon(
                                                  Icons.inventory_2_outlined),
                                            ),
                                            Text(
                                              "${list.stock}",
                                              style: TextStyle(fontSize: config.getsizeaproxhight(18)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                height: config.getsizeaproxhight(30),
                                                width: config.getsizeaproxhight(30),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                      fontSize: config.getsizeaproxhight(16),
                                                      color: Colors.grey
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                                decoration: new BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.8),
                                                    )),
                                              ),
                                              onTap: () {
                                                disminuiacant();
                                                setState(() {});
                                              },
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "${widget.cantidad}",
                                                style: TextStyle(
                                                  fontSize: config.getsizeaproxhight(14),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              child: Container(
                                                height: config.getsizeaproxhight(30),
                                                width: config.getsizeaproxhight(30),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: config.getsizeaproxhight(16),
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
                                                aumentarcant(list.getstock);
                                                setState(() {});
                                              },
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(25.0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: config.getsizeaproxhight(90),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    child: Container(
                      child: Text(
                        "S/ ${list.getprecV}",
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
                          padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                          child: Text(
                            "Añadir a Cesta",
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
                      if (list.getstock > 0 && widget.cantidad != 0) {
                        Producto pro = await pedres.read({
                          "id_prod": widget.idproducto,
                          "id_clin": controller.getidclient
                        });
                        if (pro.getstock != 0 &&
                            pro.getstock > widget.cantidad) {
                          int stado = await carr.agregarproducto({
                            "id_proc": widget.idproducto,
                            "id_carr": controller.getidcarrito,
                            "cant": widget.cantidad
                          });
                          //############ imprimir un mensaje ###########
                          switch (stado) {
                            case 200:
                              mensajealert().customShapeSnackBar(context,
                                  "Ingreso el producto al carrito", "T");
                              break;
                            default:
                              mensajealert().customShapeSnackBar(context,
                                  "Parece que hay una advertencia", "R");
                          }
                          //#############################################
                        } else {
                          print(
                              "Parece que surgio un problema, y el producto ya no cuenta con stock");
                        }

                        setState(() {});
                      } else {
                        print("ya no hay stock del producto");
                      }
                    },
                  ),
                ),
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

  void funcction(int a) {
    setState(() {});
    //refreshList();
  }

  // este metodo se envia para realizar la recarga de datos y el envio de estos

  actionactualiz(List<int> datos) {
    carr.actualizarcatidad(
        {"idproducto": datos[0], "idcarrito": datos[1], "canti": datos[2]});
    setState(() {});
  }

  // este metodo se envia para realizar la recarga de datos con respecto a una
  // eliminacion

  eliminarprod(List<int> datos) {
    carr.deletproducto({"id_proc": datos[0], "idcateg": datos[1]});
    setState(() {});
  }
}
