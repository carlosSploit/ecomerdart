import '../../../config/configinterface.dart';
import '../../../config/Cache.dart';
import '../../../controllers/Categoria.dart';
import '../../../controllers/Producto.dart';
import '../../../negocio/Categoria_negocio.dart';
import '../../../views/components/mensajealert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../negocio/producto_negocio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

Categoria _tipotrab = Categoria(0, "");
bool stadimage = true; // comprueba si sea insetado a actualizado una imagem
String path = ""; // capruta el patch de la imagen insertada

// ignore: camel_case_types, must_be_immutable
class contentserview extends StatefulWidget {
  bool toquenedit1 = false;
  bool toquenedit2 = false;
  ValueChanged<int> accionrecarga;

  // memoria cache de los itens de cliente y trabajador
  // ignore: non_constant_identifier_names
  Producto Productocache = Producto.fromJson({});
  //---------------------------------------------------
  var state;
  ProductoNegocio pedres = ProductoNegocio();
  CategoriaNegocio restiptrab = CategoriaNegocio();
  int idedittext = -1;
  int idproducto = 0;
  String tipo = "";
  bool stadevalue = false;
  late configinterface config;
  late BuildContext conte;

  contentserview(this.idproducto, this.accionrecarga);
  //lista de labels
  List<String> list = [
    "Nombre: ",
    "Descripccion: ",
    "Stock: ",
    "Precio de Compra: ",
    "Precio de venta: ",
    "Codigo: ",
    "Categorias: "
  ];
  // lista de controladores
  List<TextEditingController> listcontroler = [
    TextEditingController(text: ""), //nombre
    TextEditingController(text: ""), //descripccion
    TextEditingController(text: ""), //stock
    TextEditingController(text: ""), //precC
    TextEditingController(text: ""), //precV
    TextEditingController(text: ""), //codigo
    TextEditingController(text: ""), //id_categoria
  ];
  // tipo de trabajador
  Categoria tipotrab = Categoria.fromJson({});
  List<Categoria> memortiRecar = [];
  BuildContext? _context;

  //################### Action de tipo de trabajo ##################
  List<DropdownMenuItem<Categoria>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Categoria>> items = [];
    for (Categoria company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.getname),
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
    var size = MediaQuery.of(context).size;
    pedres = ProductoNegocio();
    restiptrab = CategoriaNegocio();
    config = configinterface(context);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        _context = context;
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
              content: (Productocache.getidpro == 0)
                  ? FutureBuilder<Producto>(
                      future: pedres
                          .read({"id_prod": this.idproducto, "id_clin": 0}),
                      builder: (context, snapshot) {
                        //validadores del estado------------------------
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // return (Productocache.getname == "")
                          //     ?
                          return Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator());
                          // : contenedorDate(size, context, Productocache);
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error al cargar las categorias"),
                          );
                        }
                        //------------------------------------------------
                        //capturar las categorias
                        var list = snapshot.data ?? Producto.fromJson({});
                        Productocache = list;
                        return contenedorDate(size, context, list);
                      },
                    )
                  : contenedorDate(size, context, Productocache),
            );
          },
        );
      },
    );
  }

  Widget contenedorDate(Size size, BuildContext context, Producto pro) {
    cache memori = cache();
    String imageperfil = pro.getfoto;
    imageperfil = (imageperfil == "")
        ? "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg"
        : imageperfil.replaceAll("localhost:9000", memori.getdomain.toString());
    return Stack(
      children: [
        Container(
          height: config.getsizeaproxhightsize(500, size),
          //height: 400,
          width: size.width - 10,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Imagen de perfil del usuario
                  Container(
                    //color: Colors.grey,
                    height: config.getsizeaproxhightsize(180, size),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Container(
                              width: config.getsizeaproxhightsize(140, size),
                              height: config.getsizeaproxhightsize(140, size),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: config.getsizeaproxhightsize(50, size),
                                  height:
                                      config.getsizeaproxhightsize(50, size),
                                  child: Align(
                                    alignment: Alignment.center,
                                    //subier una imagen al servidor
                                    child: InkWell(
                                      child: Icon(
                                        (stadimage)
                                            ? Icons.photo_camera
                                            : Icons.send,
                                        size: config.getsizeaproxhightsize(
                                            24, size),
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                      onTap: (stadimage)
                                          ? () async {
                                              final ImagePicker _picker =
                                                  ImagePicker();
                                              final XFile? image =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              try {
                                                path = image!.path;
                                                stadimage = false;
                                              } catch (e) {
                                                print("$e -> messeg error");
                                              }

                                              state(() {});
                                            }
                                          : () {
                                              //print("${this.path} -> image");
                                              actuproducto();
                                              state(() {});
                                            },
                                    ),
                                  ),
                                  // ###########################################
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.grey.withOpacity(0.9)),
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
                                _tipotrab = Categoria(0, "");
                                limpliesa();

                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  size: config.getsizeaproxhightsize(30, size),
                                  color: Colors.grey.withOpacity(0.9),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // ---------------------------------------------
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        color: Colors.white,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              // nombre del prodcuto
                              iteninfo(Icons.drive_file_rename_outline_rounded,
                                  this.list[0].toString(), pro.getname, 0),
                              // descripccion
                              iteninfo(Icons.arrow_upward,
                                  this.list[1].toString(), pro.getdesc, 1),
                              // stock
                              iteninfo(Icons.person, this.list[2].toString(),
                                  pro.getstock, 2),
                              //precio de compra
                              iteninfo(Icons.request_quote_rounded,
                                  this.list[3].toString(), pro.getprecC, 3),
                              //precio de venta
                              iteninfo(Icons.request_quote_rounded,
                                  this.list[4].toString(), pro.getprecV, 4),
                              // codigo
                              iteninfo(Icons.person, this.list[5].toString(),
                                  pro.getcodig, 5),
                              // id_categoria
                              iteninfo(Icons.person, this.list[6].toString(),
                                  pro.getcatego.getname, 6)
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  Stack(
                    children: [
                      Container(
                        height: config.getsizeaproxhightsize(50, size),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Text(
                              "Eliminar producto",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    title: const Text(
                                      'Eliminar Producto',
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: Color(0xff707070)),
                                    ),
                                    content: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: 25,
                                              bottom: 25,
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: const Text(
                                                'Estas seguro que deseas eliminar'),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              right: 15,
                                            ),
                                            color: Colors.grey.withOpacity(0.8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                    eliminarpro();
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
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
        (this.idedittext != -1)
            ? Container(
                height: config.getsizeaproxhightsize(500, size),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width,
                    height: config.getsizeaproxhightsize(80, size),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      //color: Colors.amber,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 5),
                                                  child: Text(
                                                    this
                                                        .list[this.idedittext]
                                                        .toString(), // titulo cambiante, teniendo en cuenta el eddit
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                flex: 8,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 15,
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 5),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                        onTap: () {
                                                          listcontroler[this
                                                                  .idedittext]
                                                              .text = "";
                                                          this.idedittext = -1;
                                                          _tipotrab =
                                                              Categoria(0, "");
                                                          stadevalue = false;
                                                          state(() {});
                                                        },
                                                      )),
                                                ),
                                                flex: 2,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Container(
                                                    height: config
                                                        .getsizeaproxhightsize(
                                                            40, size),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0),
                                                            child: (this.idedittext !=
                                                                    6)
                                                                ? TextField(
                                                                    keyboardType: (this.idedittext >
                                                                            1)
                                                                        ? TextInputType
                                                                            .number
                                                                        : TextInputType
                                                                            .text,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            config.getsizeaproxhight(15)),
                                                                    controller:
                                                                        listcontroler[
                                                                            this.idedittext],
                                                                    decoration: InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText:
                                                                            'Escribe un mensaje'),
                                                                  )
                                                                : FutureBuilder<
                                                                    List<
                                                                        Categoria>>(
                                                                    future: restiptrab
                                                                        .getlist(
                                                                            {}),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      //validadores del estado------------------------
                                                                      if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: CircularProgressIndicator());
                                                                      }
                                                                      if (snapshot
                                                                          .hasError) {
                                                                        return Center(
                                                                          child:
                                                                              Text("Error al cargar las categorias"),
                                                                        );
                                                                      }
                                                                      //--------------------------------------------------
                                                                      var list =
                                                                          snapshot.data?.length ??
                                                                              0;
                                                                      //###################################################
                                                                      int index =
                                                                          0;
                                                                      List<Categoria>
                                                                          cat =
                                                                          [];
                                                                      if (list !=
                                                                          0) {
                                                                        for (var i =
                                                                                0;
                                                                            i < list;
                                                                            i++) {
                                                                          var prod =
                                                                              snapshot.data?[i];

                                                                          ///inicializar el contador
                                                                          if (_tipotrab.getidcar !=
                                                                              0) {
                                                                            if (_tipotrab.getidcar ==
                                                                                prod?.getidcar) {
                                                                              index = i;
                                                                              this.tipotrab = prod as Categoria;
                                                                            }
                                                                          } else {
                                                                            if (pro.getcatego.getidcar ==
                                                                                prod?.getidcar) {
                                                                              index = i;
                                                                              this.tipotrab = prod as Categoria;
                                                                            }
                                                                          }

                                                                          // -----------------------------
                                                                          cat.add(
                                                                              Categoria.fromJson({
                                                                            "id_categ":
                                                                                prod?.getidcar,
                                                                            "nom_categ":
                                                                                prod?.getname
                                                                          }));
                                                                        }

                                                                        // print(
                                                                        //     "${_tipotrab.getidtrab} - ${_tipotrab.getnomtip} -> comprobante - result");

                                                                        this.tipotrab =
                                                                            buildDropdownMenuItems(cat)[index].value
                                                                                as Categoria;

                                                                        // print(
                                                                        //     "${tipotrab.getidtrab} - ${tipotrab.getnomtip} -> comprobante");

                                                                        memortiRecar =
                                                                            cat;

                                                                        return DropdownButton(
                                                                          value:
                                                                              this.tipotrab,
                                                                          items:
                                                                              buildDropdownMenuItems(cat),
                                                                          onChanged:
                                                                              (value) {
                                                                            Categoria
                                                                                aux =
                                                                                value as Categoria;
                                                                            this.tipotrab =
                                                                                aux;
                                                                            _tipotrab =
                                                                                aux;
                                                                            state(() {});
                                                                          },
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          child:
                                                                              Text("No presenta categorias"),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: (stadevalue)
                                                            ? Colors.red
                                                            : Color(0xff707070)
                                                                .withOpacity(
                                                                    0.4),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                flex: 8,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  child: Container(
                                                    height: config
                                                        .getsizeaproxhightsize(
                                                            40, size),
                                                    width: config
                                                        .getsizeaproxhightsize(
                                                            40, size),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.send,
                                                        size: config
                                                            .getsizeaproxhightsize(
                                                                24, size),
                                                        color: Colors.grey
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle),
                                                  ),
                                                  onTap: () {
                                                    print(listcontroler[
                                                            this.idedittext]
                                                        .text);
                                                    actualizarproduccache(
                                                        this.idedittext);
                                                    actuproducto();

                                                    state(() {});
                                                  },
                                                ),
                                                flex: 2,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    flex: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      //color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: config.getsizeaproxhightsize(500, size),
              ),
      ],
    );
  }

  // actualiza la memoria o la clase que hace de memoria, evitando la sobre recarga
  void actualizarproduccache(int index) {
    switch (index) {
      case 0:
        Productocache.setname = listcontroler[index].text;
        break;
      case 1:
        Productocache.setdesc = listcontroler[index].text;
        break;
      case 2:
        Productocache.setstock = int.parse(listcontroler[index].text);
        break;
      case 3:
        Productocache.setprecC = double.parse(listcontroler[index].text);
        break;
      case 4:
        Productocache.setprecV = double.parse(listcontroler[index].text);
        break;
      case 5:
        Productocache.setcodig = int.parse(listcontroler[index].text);
        break;
      case 6:
        Productocache.setcatego = _tipotrab;
        break;
      default:
    }
  }

  void actuproducto() async {
    //print(controller.getidusser);
    String messeg = "";
    List<Object> stado = await (pedres as ProductoNegocio).update(
        Producto.fromJson({
          "id_produc": this.idproducto,
          "nombre": listcontroler[0].text,
          "descripccion": listcontroler[1].text,
          "stock": int.parse(
              (listcontroler[2].text == "") ? "0" : listcontroler[2].text),
          "precC": double.parse(
              (listcontroler[3].text == "") ? "0.0" : listcontroler[3].text),
          "precV": double.parse(
              (listcontroler[4].text == "") ? "0.0" : listcontroler[4].text),
          "codigo": int.parse(
              (listcontroler[5].text == "") ? "0" : listcontroler[5].text),
          "foto": path,
          "id_categoria": (_tipotrab.getidcar == 0) ? 1 : _tipotrab.getidcar
        }),
        accionrecarga);
    print("El nuevo estado considerado es ${stadimage}");
    print("El nuevo estado considerado es ${stado[0]}");
    switch (stado[0] as int) {
      case 200:
        print("El nuevo estado considerado es ${stadimage}");
        limpliesa();
        // listcontroler[this.idedittext].text = "";
        // this.idedittext = -1;
        print("El nuevo estado considerado es ${stadimage}");
        messeg = "Se a actualizado un producto correctamente";
        break;
      default:
        valstado(stado[1] as List<bool>);
        state(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
        return;
    }
    mensajealert()
        .customShapeSnackBar(this._context as BuildContext, "$messeg", "T");
    state(() {});
  }

  void eliminarpro() async {
    String messeg = "";
    int stado = await (pedres as ProductoNegocio)
        .delect({'idproducto': this.idproducto});
    // segun la respta mando a emprimir una info
    switch (stado as int) {
      case 200:
        messeg = "Se a eliminado el producto correctamente";
        break;
      default:
        state(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
        return;
    }
    mensajealert()
        .customShapeSnackBar(this._context as BuildContext, "$messeg", "T");
    accionrecarga(0);
    state(() {});
  }

  void valstado(List<bool> est) {
    for (var i = 0; i < est.length; i++) {
      stadevalue = est[i];
    }
  }

  void limpliesa() {
    listcontroler[0].text = "";
    listcontroler[1].text = "";
    listcontroler[2].text = "";
    _tipotrab = Categoria.fromJson({});
    listcontroler[4].text = "";
    listcontroler[5].text = "";
    this.idedittext = -1;
    stadevalue = false;
    stadimage = true; // actualiza el estado de la imagen
  }

  Widget iteninfo(IconData icon, String label, var info, int inx) {
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
                  size: config.getsizeaproxhightsize(
                      24, MediaQuery.of(_context as BuildContext).size),
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              //color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                    "$label",
                    style: TextStyle(
                        color: Colors.grey[800], fontWeight: FontWeight.w700),
                  )),
                  Container(
                      child: Text(
                    "$info",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  )),
                ],
              ),
            ),
            flex: 6,
          ),
          Expanded(
            child: Container(
              child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Icon(
                      Icons.edit,
                      size: config.getsizeaproxhightsize(
                          24, MediaQuery.of(_context as BuildContext).size),
                      color: Colors.grey.withOpacity(0.8),
                    ),
                    onTap: () {
                      this.idedittext = inx; // cambia el index de la interface
                      listcontroler[this.idedittext].text = info.toString();
                      state(() {});
                    },
                  )),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class contentserbody extends State<contentserview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
