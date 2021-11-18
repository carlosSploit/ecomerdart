import 'package:flutter/services.dart';

import '../../config/configinterface.dart';
import '../../config/Cache.dart';
import '../../controllers/datosuser.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../views/homeview/view/homeview.dart';
import '../../views/pedidosview/view/pedidoview.dart';
import '../../views/usuariosview/view/usuarioview.dart';
import '../../views/usuariosview/components/edituserview.dart';
import '../../views/pedidosview/view/mainpedidoview.dart';
import '../../views/components/categoriaeditview.dart';
import '../../views/components/insertrabajuserview.dart';
import '../../views/components/inserproductoview.dart';
import '../../views/components/tiptrabajoeditview.dart';
import '../../config/bdcache.dart';
import '../../views/analiticview/view/mainanaliticview.dart';

// ignore: must_be_immutable, camel_case_types
class insideView extends StatefulWidget {
  Widget memoriwi = Container();
  int _selectedIndex = 0;
  Future<Datosuser> datoscontroller;

  insideView(this.datoscontroller, this._selectedIndex);

  @override
  insidebody createState() => insidebody();
}

// ignore: camel_case_types
class insidebody extends State<insideView> {
  int _selectedIndex = 0;
  bool star = true;
  int idusuer = 0;
  String tipotrab = "";
  Datosuser controller = Datosuser();
  cache controler = cache();
  Future<Datosuser>? memoriadatos;
  //variable para tener un control de los colores o de los tamaños
  late configinterface config;

  static List<Widget> _widgetOptions = <Widget>[
    homeview(),
    pedidoview(),
    usuarioview(),
    homeview(),
  ];

  static List<String> titlesinterface = <String>[
    "Home",
    "Lista de pedidos",
    "Lista de usuarios",
    "",
  ];

  static List<Widget> widgetOptionsCliente = <Widget>[
    homeview(),
    pedidoview(),
    homeview(),
  ];

  static List<String> titlesinterfaceCliente = <String>[
    "Home",
    "Lista de pedidos",
    "",
  ];

  void actualizar(int a) {
    setState(() {});
  }

  void _onItemTapped(int index) async {
    if ((_widgetOptions.length - 1) != index) {
      print("${index} - interface index");
      int i = await bd.updateinterface({'idinterface': index});
      print("${i} - estado actuali");
      List<Datosuser> lista = await bd.list();
      print("${lista[0].getiduser} - id usuario inicio");
      print("${lista[0].getidinterface} - interface actual de inicio");
    }

    setState(() {
      if (this.controller.gettiouse != "C") {
        if ((_widgetOptions.length - 1) == index) {
          contentserview(this.idusuer, this.tipotrab, actualizar)
              .createDialog(context);
        } else {
          _selectedIndex = index;
        }
      } else {
        if ((widgetOptionsCliente.length - 1) == index) {
          contentserview(this.idusuer, this.tipotrab, actualizar)
              .createDialog(context);
        } else {
          _selectedIndex = index;
        }
      }
    });
  }

  @override
  void initState() {
    this._selectedIndex = widget._selectedIndex;
    this.memoriadatos = widget.datoscontroller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    config = configinterface(context);
    //inicializar();
    return FutureBuilder<Datosuser>(
        future: this.memoriadatos, // envia parametros
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
          //####################################
          this.idusuer = controller.getiduser;
          this.tipotrab = controller.gettiouse;
          //####################################
          widget.memoriwi = Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: (this.controller.gettiouse != "C")
                  ? PopupMenuButton(
                      icon: Icon(
                        Icons.menu,
                        color: Color(0xff707070),
                      ),
                      itemBuilder: (BuildContext conte) {
                        return [
                          PopupMenuItem(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.supervised_user_circle_outlined,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      tiptrabajoeditview(actualizar)
                                          .createDialog(this.context);
                                    },
                                    child: Container(
                                      child: Text("Mantenimiento de Cargo"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.fact_check_outlined,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      categoriaeditview(actualizar)
                                          .createDialog(this.context);
                                    },
                                    child: Container(
                                      child: Text("Mantenimiento Categoria"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.face_outlined,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      insertrabajuserview(actualizar)
                                          .createDialog(this.context);
                                    },
                                    child: Container(
                                      child: Text("Agregar Trabajador"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.inventory_2_outlined,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      inserproductoview(actualizar)
                                          .createDialog(this.context);
                                    },
                                    child: Container(
                                      child: Text("Agregar Producto"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.analytics,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                mainanaliticview(0)),
                                      );
                                    },
                                    child: Container(
                                      child: Text("Analiticas"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              Datosuser dat = Datosuser.fromJson({});
                              await bd.update(dat.toJson());
                              print("CERRANDO SECION");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp(0)),
                              );
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.clear_all_sharp,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Container(
                                    child: Text("Cerrar seccion"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              SystemNavigator.pop();
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.clear,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Container(
                                    child: Text("Cerrar aplicacion"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                    )
                  : PopupMenuButton(
                      icon: Icon(
                        Icons.menu,
                        color: Color(0xff707070),
                      ),
                      itemBuilder: (BuildContext conte) {
                        return [
                          PopupMenuItem(
                            onTap: () async {
                              Datosuser dat = Datosuser.fromJson({});
                              await bd.update(dat.toJson());
                              print("CERRANDO SECION-----------");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp(0)),
                              );
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.clear_all_sharp,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Container(
                                    child: Text("Cerrar seccion"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              SystemNavigator.pop();
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.clear,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Container(
                                    child: Text("Cerrar aplicacion"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                    ),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Container(
                width: 200,
                child: Text(
                  (controller.gettiouse != "C")
                      ? titlesinterface[_selectedIndex]
                      : titlesinterfaceCliente[_selectedIndex],
                  style: TextStyle(
                    color: Color(0xff707070),
                    fontSize: config.getsizeaproxhight(25),
                  ),
                ),
              ),
              actions: (this.controller.gettiouse == "C")
                  ? <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 25,
                          color: Color(0xff707070),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => mainpedidoview(
                                  controller.getidcarrito, 0, "C"),
                            ),
                          );
                        },
                      ),
                    ]
                  : [],
            ),
            body: Container(
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: NotificationListener<ScrollNotification>(
                  // ignore: non_constant_identifier_names
                  onNotification: (Notification) {
                    if (_scrollController.position.userScrollDirection ==
                        ScrollDirection.forward) {
                      star = true;
                    } else if (_scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                      star = false;
                    }
                    setState(() {});
                    //actualizar(0);
                    //print(star);
                    return true;
                  },
                  child: new ListView(
                    controller: _scrollController,
                    children: [
                      (controller.gettiouse != "C")
                          ? _widgetOptions[_selectedIndex]
                          : widgetOptionsCliente[_selectedIndex],
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButton: (this.star)
                ? Container(
                    padding: EdgeInsets.fromLTRB(config.getsizeaproxhight(5), 0,
                        config.getsizeaproxhight(5), 0),
                    height: config.getsizeaproxhight(60),
                    child: BottomNavigationBar(
                      items: (controller.gettiouse != "C")
                          ? <BottomNavigationBarItem>[
                              //home
                              BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.home,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  label: "EL",
                                  activeIcon: Icon(
                                    Icons.home,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  backgroundColor: Colors.transparent),
                              //listar pedidos
                              BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.inventory_2,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  label: "EL",
                                  activeIcon: Icon(
                                    Icons.inventory_2,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  backgroundColor: Colors.transparent),
                              //listar usuarios
                              BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.person,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  label: "EL",
                                  activeIcon: Icon(
                                    Icons.person,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  backgroundColor: Colors.transparent),
                              //indormacion del perfil
                              BottomNavigationBarItem(
                                icon: Container(
                                  width: config.getsizeaproxhight(25),
                                  height: config.getsizeaproxhight(25),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                          config.getsizeaproxhight(20)),
                                      image: DecorationImage(
                                          image: Image.network(
                                                  "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg")
                                              .image)),
                                ),
                                label: "EL",
                                activeIcon: Container(
                                  width: config.getsizeaproxhight(30),
                                  height: config.getsizeaproxhight(30),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(
                                        config.getsizeaproxhight(20)),
                                    image: DecorationImage(
                                        image: Image.network(
                                                "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg")
                                            .image),
                                  ),
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ]
                          : <BottomNavigationBarItem>[
                              //home
                              BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.home,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  label: "EL",
                                  activeIcon: Icon(
                                    Icons.home,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  backgroundColor: Colors.transparent),
                              //listar pedidos
                              BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.inventory_2,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  label: "EL",
                                  activeIcon: Icon(
                                    Icons.inventory_2,
                                    size: config.getsizeaproxhight(25),
                                  ),
                                  backgroundColor: Colors.transparent),
                              //indormacion del perfil
                              BottomNavigationBarItem(
                                icon: Container(
                                  width: config.getsizeaproxhight(25),
                                  height: config.getsizeaproxhight(25),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: Image.network(
                                                  "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg")
                                              .image)),
                                ),
                                label: "EL",
                                activeIcon: Container(
                                  width: config.getsizeaproxhight(30),
                                  height: config.getsizeaproxhight(30),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: Image.network(
                                                "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg")
                                            .image),
                                  ),
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ],
                      //fixedColor: Colors.transparent,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      currentIndex: _selectedIndex,
                      unselectedItemColor: Color(0xff707070).withOpacity(0.3),
                      selectedItemColor: Color(0xff707070),
                      onTap: _onItemTapped,
                    ),
                    margin: EdgeInsets.fromLTRB(
                        50, 0, 50, config.getsizeaproxhight(30)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  )
                : Container(),
          );
          return widget.memoriwi;
        });
  }
}
