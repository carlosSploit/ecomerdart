import '../../../config/configinterface.dart';
import '../../../controllers/cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../views/usuariosview/components/usuarioitenview.dart';
import '../../../negocio/cliente_negocio.dart';

// ignore: camel_case_types
class usuarioview extends StatefulWidget {
  @override
  usuariobody createState() => usuariobody();
}

// ignore: camel_case_types
class usuariobody extends State<usuarioview> {
  String _selexidestado = "C";
  late configinterface config;

  void actualic(String index) {
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
    var pedres = ClienteNegocio();
    config = configinterface(context);

    return new Column(
      //controller: _scrollController,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: size.width,
          height: config.getsizeaproxhight(50),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: config.getsizeaproxhight(Size.fromHeight(105.0).height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            size: config.getsizeaproxhight(25),
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
                            style: TextStyle(
                                fontSize: config.getsizeaproxhight(14)),
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
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
                height: config.getsizeaproxhight(60),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildChip("C", "Cliente", Color(0xff707070)),
                    _buildChip("T", "Trabajador", Color(0xff707070)),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Contenedor de los productos
        FutureBuilder<List<Cliente>>(
          future: pedres.getlist({
            "tipous": _selexidestado,
            "name": textEditingController.text
            // "estado": _selexidestado,
            // "idpedi": textEditingController.text
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
                usuariositenview(
                    catg?.getidusua,
                    config.getsizeaproxhight(300).toInt(),
                    catg?.getnombre,
                    catg?.getfoto,
                    _selexidestado,
                    actualizar),
              );
            }

            conte = (list * (80 + 10));

            return (list != 0)
                ? Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: conte.toDouble(),
                    color: Colors.white,
                    child: Column(
                      children: cat,
                    ),
                  )
                : Container(
                    //color: Colors.amber,
                    height: size.height - 300,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_off_outlined,
                            size: 70,
                            color: Color(0xff707070),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("No hay clientes registrados"),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  void actualizar(int a) {
    actualic(_selexidestado);
  }

  // cart de cada categoria, el cual actualizara el estado
  Widget _buildChip(String idexcat, String label, Color color) {
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
                  fontSize: config.getsizeaproxhight(15),
                  color:
                      (this._selexidestado == idexcat) ? color : Colors.white),
            ),
          ),
          label: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: config.getsizeaproxhight(15),
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
