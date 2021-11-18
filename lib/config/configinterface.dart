import 'package:flutter/cupertino.dart';

// se substrae un tamaño teniendo en cuenta un tamaño predeterminado
// tambien se encara de botar un color predeterminado
// ignore: camel_case_types
class configinterface {
  BuildContext context;

  double hightstandart = 683.4285714285714;

  configinterface(this.context);
  //contexto
  BuildContext get getcontext => this.context;

  double getsizeaproxhightsize(double tamao, Size size) {
    return (size.height * (((tamao * 100) / hightstandart) / 100));
  }

  double getsizeaproxhight(double tamao) {
    Size size = MediaQuery.of(getcontext).size;
    return (size.height * (((tamao * 100) / hightstandart) / 100));
  }

  double getsizeaproxwigth(double tamao) {
    Size size = MediaQuery.of(getcontext).size;
    return (size.height * (((tamao * 100) / hightstandart) / 100));
  }
}
