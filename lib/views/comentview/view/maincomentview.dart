// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../views/comentview/view/comentview.dart';

// ignore: camel_case_types
class maincomentview extends StatelessWidget {
  // This widget is the root of your application.
  int idproduct;

  maincomentview(this.idproduct);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: comentview(this.idproduct),
    );
  }
}
