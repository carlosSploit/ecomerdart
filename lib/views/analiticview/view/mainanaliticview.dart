import 'package:flutter/material.dart';
import 'package:ecomersbaic/views/analiticview/view/analiticview.dart';


// ignore: camel_case_types
class mainanaliticview extends StatelessWidget {
  // This widget is the root of your application.
  int id_product;

  mainanaliticview(this.id_product);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: analiticview(this.id_product),
    );
  }
}
