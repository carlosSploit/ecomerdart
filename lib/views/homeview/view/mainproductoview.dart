import 'package:flutter/material.dart';
import 'productointerfview.dart';

// ignore: camel_case_types, must_be_immutable
class mainproductoview extends StatelessWidget {
  // This widget is the root of your application.
  int idproducto;

  mainproductoview(this.idproducto);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: productointerfview(this.idproducto),
    );
  }
}
