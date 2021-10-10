import 'package:flutter/material.dart';
import 'package:ecomersbaic/views/comentview/view/comentview.dart';

// ignore: camel_case_types
class maincomentview extends StatelessWidget {
  // This widget is the root of your application.
  int id_product;

  maincomentview(this.id_product);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: comentview(this.id_product),
    );
  }
}
