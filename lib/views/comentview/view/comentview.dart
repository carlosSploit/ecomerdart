import 'package:ecomersbaic/Cache.dart';
import 'package:ecomersbaic/controllers/ComentarioProd.dart';
import 'package:ecomersbaic/controllers/datosuser.dart';
import 'package:ecomersbaic/main.dart';
import 'package:ecomersbaic/negocio/comentpro_negocio.dart';
import 'package:ecomersbaic/views/components/mensajealert.dart';
import 'package:ecomersbaic/views/homeview/view/mainproductoview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ecomersbaic/views/comentview/components/comentarioitenview.dart';

// ignore: camel_case_types
class comentview extends StatefulWidget {
  int idproducto;
  comentview(this.idproducto);

  @override
  comentbody createState() => comentbody();
}

// ignore: camel_case_types
class comentbody extends State<comentview> {
  ComentarioProdNegocio pedres = ComentarioProdNegocio();
  Future<List<ComentarioProd>>? comentarios;
  TextEditingController tec = TextEditingController(text: "");
  cache memori = cache();
  BuildContext? _context;
  comentbody();

  @override
  void initState() {
    cargardatos();
    super.initState();
  }

  void cargardatos() {
    comentarios = pedres.getlist({"id_pro": widget.idproducto});
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          onTap: () async{
            Datosuser dat = await memori.extracvar();
            if(dat.gettiouse == "C"){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => mainproductoview(widget.idproducto)),
              );
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp()),
              );
            }
          },
        ),
        backgroundColor: Colors.white,
        title: Container(
          width: 200,
          child: Text(
            "Comentarios",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<ComentarioProd>>(
              future: pedres.getlist({"id_pro": widget.idproducto}),
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
                  var catg = snapshot.data?[i] ?? ComentarioProd.fromJson({});
                  print("${catg.getmeg}");
                  cat.add(
                    comentarioitenview(
                        true,
                        catg.getclien.getnombre,
                        catg.getmeg,
                        catg.getfechmess,
                        (catg.getclien.getfoto as String).replaceAll(
                            "localhost:9000", memori.getdomain.toString())),
                  );
                }

                print("${cat.length}");

                return (cat.length != 0)
                    ? Expanded(
                        flex: 10,
                        child: Container(
                          color: Colors.white,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: cat,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("No hay comentarios en bandeja"),
                          ),
                        ),
                      );
              },
            ),
            Container(
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    //imagen del usuario
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        //height: double.maxFinite,
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          //image de contenido
                          child: Center(
                            child: Container(
                                width: 37.0,
                                height: 37.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: new Border.all(
                                        color: Colors.white, width: 2),
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            "https://i.imgur.com/BoN9kdC.png")))),
                          ),
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextField(
                          controller: tec,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Please enter a search term'),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: Text(
                          "Publicar",
                          style: TextStyle(color: Color(0xff707070)),
                        ),
                      ),
                      onTap: () {
                        insercat();
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insercat() async {
    //print(controller.getidusser);
    Datosuser dat = await memori.extracvar();
    List<Object> stado = await pedres.agregarcategoria(ComentarioProd.fromJson({
      "id_pro": widget.idproducto,
      "id_clie": dat.getidclient,
      "messe": tec.text
    }));
    switch ((stado[0] as int)) {
      case 200:
        mensajealert().customShapeSnackBar(this._context as BuildContext,
            "Se a insertado la categoria correctamente", "T");
        tec.text = "";
        setState(() {});
        break;
      default:
        tec.text = "";
        setState(() {
          mensajealert().customShapeSnackBar(this._context as BuildContext,
              "Parece que hay una advertencia", "R");
        });
    }
  }
}
