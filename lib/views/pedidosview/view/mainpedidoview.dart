import 'package:flutter/material.dart';
import 'pedidointerfview.dart';

// ignore: camel_case_types, must_be_immutable
class mainpedidoview extends StatelessWidget {
  // This widget is the root of your application.
  int idpedido;
  int idcarrito;
  String tipointe;

  mainpedidoview(this.idcarrito, this.idpedido, this.tipointe);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: pedidointerfview(this.idcarrito, this.idpedido, this.tipointe),
    );
  }
}
