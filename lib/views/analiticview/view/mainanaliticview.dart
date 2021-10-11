// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../views/analiticview/view/analiticview.dart';


// ignore: camel_case_types
class mainanaliticview extends StatelessWidget {
  // This widget is the root of your application.
  int idproduct;

  mainanaliticview(this.idproduct);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: analiticview(this.idproduct),
    );
  }
}
