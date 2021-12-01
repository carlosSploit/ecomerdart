import '../../config/configinterface.dart';
import '../../controllers/Categoria.dart';
import '../../controllers/Producto.dart';
import '../../controllers/cliente.dart';
import '../../controllers/trabajador.dart';
import '../../negocio/Categoria_negocio.dart';
import '../../negocio/producto_negocio.dart';
import '../../views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import 'package:keyboard_visibility/keyboard_visibility.dart';

// ignore: non_constant_identifier_names
Categoria CategoriaMe = Categoria(0, "");

// ignore: camel_case_types, must_be_immutable
class inserproductoview extends StatefulWidget {
  bool toquenedit1 = false;
  //bool toquenedit2 = false;
  ValueChanged<int> accionrecarga;
  late configinterface config;
  // memoria cache de los itens de cliente y trabajador
  Cliente clientecacha = Cliente.fromJson({});
  Trabajador trabajocahca = Trabajador.fromJson({});
  BuildContext? contextgeneral;
  //---------------------------------------------------
  var state;
  ProductoNegocio? pedres;
  CategoriaNegocio? restiptrab;
  int idedittext = -1;
  int idusuario = 0;
  String tipo = "";
  var controller;
  String path = "";
  BuildContext? context;

  inserproductoview(this.accionrecarga);
  //lista de labels
  List<String> list = [
    "Nombre: ",
    "Descripccion: ",
    "Stock: ",
    "Categoria: ",
    "Precio de Compra: ",
    "Precio de Venta: ",
    "Codigo: ",
  ];
  // lista de controladores
  List<TextEditingController> listcontroler = [
    TextEditingController(text: ""), //Nombre
    TextEditingController(text: ""), //Descripccion
    TextEditingController(text: ""), //Stock
    TextEditingController(text: ""), //tipo de trab
    TextEditingController(text: ""), //Precio de Compra
    TextEditingController(text: ""), //Precio de Venta
    TextEditingController(text: ""), //Codigo
  ];
  List<bool> listvalide = [
    false, //Nombre
    false, //Descripccion
    false, //Stock
    false, //tipo de trab
    false, //Precio de Compra
    false, //Precio de Venta
    false, //Codigo
    false, //foto
  ];
  // tipo de trabajador
  Categoria tipotrab = Categoria.fromJson({});
  int idindextra = 0;
  List<Categoria> memortiRecar = [];

  //################### Action de tipo de trabajo ##################
  List<DropdownMenuItem<Categoria>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Categoria>> items = [];
    for (Categoria company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(
            company.getname,
            style: TextStyle(fontSize: config.getsizeaproxhight(14)),
          ),
        ),
      );
    }
    return items;
  }

  void onChangeDropdownItem(Categoria selectedCompany) {
    tipotrab = selectedCompany;
    print("${tipotrab.getidcar} -> se selecciono");
    state(() {});
  }

  @override
  contentserbody createState() => contentserbody();

  createDialog(BuildContext context) {
    // this.contextgeneral = context;
    config = configinterface(context);
    this.context = context;
    var size = MediaQuery.of(context).size;
    pedres = ProductoNegocio();
    restiptrab = CategoriaNegocio();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        contextgeneral = context;
        return StatefulBuilder(
          builder: (context, setState) {
            state = setState;
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: contenedorDate(size, context),
            );
          },
        );
      },
    );
  }

  Widget contenedorDate(Size size, BuildContext context) {
    String imageperfil =
        "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg";
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Stack(
      children: [
        Container(
          height: config.getsizeaproxhight(500),
          //height: 400,
          width: size.width - 10,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Imagen de perfil del usuario
                  (!isKeyboard)
                      ? Container(
                          //color: Colors.grey,
                          height: config.getsizeaproxhight(180),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  child: Container(
                                    width: config.getsizeaproxhight(140),
                                    height: config.getsizeaproxhight(140),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: config.getsizeaproxhight(50),
                                        height: config.getsizeaproxhight(50),
                                        child: Align(
                                          alignment: Alignment.center,
                                          //subier una imagen al servidor
                                          child: InkWell(
                                              child: Icon(
                                                Icons.photo_camera,
                                                size: config
                                                    .getsizeaproxhight(25),
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                              ),
                                              onTap: () async {
                                                final ImagePicker _picker =
                                                    ImagePicker();
                                                final XFile? image =
                                                    await _picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                try {
                                                  this.path = image!.path;
                                                } catch (e) {
                                                  print("$e -> messeg error");
                                                }
                                                state(() {});
                                              }),
                                        ),
                                        // ###########################################
                                        decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: (listvalide[7])
                                                ? Colors.red
                                                : Colors.grey.withOpacity(0.9)),
                                      ),
                                    ),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(70.0),
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: (path == "")
                                            ? Image.network(imageperfil).image
                                            : Image.file(File(path)).image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  onTap: () {
                                    CategoriaMe = Categoria(0, "");
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Icon(
                                      Icons.arrow_back_outlined,
                                      size: config.getsizeaproxhight(30),
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                CategoriaMe = Categoria(0, "");
                                limpestade();
                                limpliesa();
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  size: config.getsizeaproxhight(30),
                                  color: Colors.grey.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                        ),
                  // ---------------------------------------------
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 25, 0),
                        color: Colors.white,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              //nombre
                              iteninfo(context, Icons.person,
                                  this.list[0].toString(), "", 0),
                              //descripccion
                              iteninfo(context, Icons.arrow_upward,
                                  this.list[1].toString(), "", 1),
                              //stock
                              iteninfo(context, Icons.person,
                                  this.list[2].toString(), "", 2),
                              //tipo de trab
                              iteninfo(context, Icons.person,
                                  this.list[3].toString(), "", 3),
                              //precio de combra
                              iteninfo(context, Icons.request_quote_rounded,
                                  this.list[4].toString(), "", 4),
                              //precio de venta
                              iteninfo(context, Icons.request_quote_rounded,
                                  this.list[5].toString(), "", 5),
                              //codigo
                              iteninfo(context, Icons.person,
                                  this.list[6].toString(), "", 6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          insertarProducto();
                        },
                        child: Container(
                          height: config.getsizeaproxhight(50),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Ingresar Producto",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.8),
                            //color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }

  void insertarProducto() async {
    Producto tbj = Producto.fromJson({
      "nombre": listcontroler[0].text,
      "descripccion": listcontroler[1].text,
      "stock": int.parse(
          (listcontroler[2].text == "") ? "0" : listcontroler[2].text),
      "id_categoria": (CategoriaMe.getidcar == 0) ? 1 : CategoriaMe.getidcar,
      "precC": double.parse(
          (listcontroler[4].text == "") ? "0.0" : listcontroler[4].text),
      "precV": double.parse(
          (listcontroler[5].text == "") ? "0.0" : listcontroler[5].text),
      "codigo": int.parse(
          (listcontroler[6].text == "") ? "0" : listcontroler[6].text),
      "foto": this.path
    });
    //print(controller.getidusser);
    List<Object> stado =
        await pedres?.insert(tbj, accionrecarga) as List<Object>;

    switch ((stado[0] as int)) {
      case 200:
        limpliesa();
        state(() {
          mensajealert().customShapeSnackBar(
              this.contextgeneral as BuildContext,
              "Se a insertado el trabajador correctamente",
              "T");
        });
        break;
      default:
        validar((stado[1] as List<bool>));
        state(() {
          mensajealert().customShapeSnackBar(
              this.contextgeneral as BuildContext,
              "Parece que hay una advertencia",
              "R");
        });
    }
  }

  void limpliesa() {
    listcontroler[0].text = "";
    listcontroler[1].text = "";
    listcontroler[2].text = "";
    CategoriaMe = Categoria.fromJson({});
    listcontroler[4].text = "";
    listcontroler[5].text = "";
    this.path = "";
  }

  void limpestade() {
    for (var i = 0; i < listvalide.length; i++) {
      listvalide[i] = false;
    }
  }

  void validar(List<bool> list) {
    for (var i = 0; i < list.length; i++) {
      listvalide[i] = list[i];
    }
  }

  Widget iteninfo(
      BuildContext context, IconData icon, String label, var info, int inx) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
              //color: Colors.black,
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: config.getsizeaproxhight(24),
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              height: config.getsizeaproxhight(60),
              //color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "$label",
                        style: TextStyle(
                            fontSize: config.getsizeaproxhight(14),
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700),
                      )),
                  Container(
                    child: Expanded(
                      child: Container(
                        child: Container(
                          height: config.getsizeaproxhight(40),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: (inx != 3)
                                      ? TextField(
                                          //focusNode: _focus[inx],
                                          keyboardType: (inx == 2 || inx > 3)
                                              ? TextInputType.number
                                              : TextInputType.text,
                                          style: TextStyle(
                                            fontSize:
                                                config.getsizeaproxhight(15),
                                          ),
                                          controller: listcontroler[inx],
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Escribe un mensaje',
                                          ),
                                        )
                                      : FutureBuilder<List<Categoria>>(
                                          future: restiptrab!.getlist({}),
                                          builder: (context, snapshot) {
                                            //validadores del estado------------------------
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Align(
                                                  alignment: Alignment.center,
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    "Error al cargar las categorias"),
                                              );
                                            }
                                            //--------------------------------------------------
                                            var list =
                                                snapshot.data?.length ?? 0;
                                            //###################################################
                                            int index = 0;
                                            List<Categoria> cat = [
                                              Categoria.fromJson({
                                                "id_categ": 1,
                                                "nom_categ": "Default"
                                              })
                                            ];
                                            if (list != 0) {
                                              for (var i = 0; i < list; i++) {
                                                var prod = snapshot.data?[i];
                                                // inicializar el contador
                                                if (CategoriaMe.getidcar != 0) {
                                                  print(
                                                      "${CategoriaMe.getidcar} == ${prod?.getidcar}");
                                                  if (CategoriaMe.getidcar ==
                                                      prod?.getidcar) {
                                                    index = i + 1;
                                                    this.tipotrab =
                                                        prod as Categoria;
                                                  }
                                                } else {
                                                  index = 0;
                                                }

                                                // -----------------------------
                                                // agrega la categoria a la lista
                                                cat.add(Categoria.fromJson({
                                                  "id_categ": prod?.getidcar,
                                                  "nom_categ": prod?.getname
                                                }));
                                              }

                                              print("${index} ------- index");
                                              print(
                                                  "${list} ------- cantidad lista");
                                              // print(
                                              //     "${_tipotrab.getidtrab} - ${_tipotrab.getnomtip} -> comprobante - result");

                                              this.tipotrab =
                                                  buildDropdownMenuItems(
                                                          cat)[index]
                                                      .value as Categoria;
                                              //----- return widget
                                              return DropdownButton(
                                                isExpanded: true,
                                                isDense: true,
                                                value: this.tipotrab,
                                                items:
                                                    buildDropdownMenuItems(cat),
                                                onChanged: (value) {
                                                  Categoria aux =
                                                      value as Categoria;
                                                  print(aux.getidcar);
                                                  this.tipotrab = aux;
                                                  CategoriaMe = aux;
                                                  state(() {});
                                                },
                                              );
                                            } else {
                                              return Container(
                                                child: Text(
                                                    "No presenta categorias"),
                                              );
                                            }
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
                              color: (listvalide[inx])
                                  ? Colors.red
                                  : Color(0xff707070).withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      flex: 8,
                    ),
                  ),
                ],
              ),
            ),
            flex: 6,
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class contentserbody extends State<inserproductoview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
