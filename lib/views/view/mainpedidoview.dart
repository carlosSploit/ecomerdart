import 'package:flutter/material.dart';
import 'registrarview.dart';

// ignore: camel_case_types
class mainregistreview extends StatelessWidget {
  // This widget is the root of your application.

  mainregistreview();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: registrarview(),
    );
  }
}
