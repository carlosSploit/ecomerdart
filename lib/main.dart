import '../../controllers/datosuser.dart';
import 'package:flutter/material.dart';
import '../../views/view/insideview.dart';
import '../../views/view/loginview.dart';
import 'config/Cache.dart';

void main() async {
  runApp(MyApp(0));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  // sirve para el index, para poder inizializar el indice del conetendor
  int _selectedIndex = 0;
  //---------------------------------------------------------------------
  MyApp(this._selectedIndex);

  @override
  Myappbody createState() => Myappbody();
}

// ignore: camel_case_types
class Myappbody extends State<MyApp> {
  cache controller = cache();
  Future<Datosuser>? _datoscontroller;

  @override
  void initState() {
    _datoscontroller = controller.extracvar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Datosuser>(
      future: _datoscontroller, // envia parametros
      builder: (context, snapshot) {
        //validadores del estado------------------------

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
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
        print((list.getiduser != 0)
            ? "Inicio secion ${list.getiduser}"
            : "no presenta secion");
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              //visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: (list.getiduser == 0)
                ? loginView()
                : insideView(
                    _datoscontroller!.catchError((controller) =>
                        (_datoscontroller = controller.extracvar())),
                    widget._selectedIndex));
      },
    );
  }
}
