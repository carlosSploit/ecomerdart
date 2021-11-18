import 'package:flutter/material.dart';
import '../../config/configinterface.dart';

class iteninfoview extends StatefulWidget {
  BuildContext? conte;
  IconData? icon;
  String? label;
  int? lengthcarac;
  String? tipo;
  TextEditingController? textcontrol;
  late configinterface config;

  iteninfoview(conte, icon, label, lengthcarac, tipo, textcontrol);

  //iteninfoview(conte, icon, label, lengthcarac, tipo, textcontrol);

  @override
  iteninfobody createState() => iteninfobody();
}

class iteninfobody extends State<iteninfoview> {
  iteninfobody();
  @override
  Widget build(BuildContext context) {
    widget.config = configinterface(context);
    // reinicializar datos no ingresados
    // if (widget.conte == null) widget.conte = context;
    // if (widget.icon == null) widget.icon = Icons.person;
    // if (widget.label == null) widget.label = "";
    // if (widget.lengthcarac == null) widget.lengthcarac = 0;
    // if (widget.tipo == null) widget.tipo = "";
    // if (widget.textcontrol == null)
    //   widget.textcontrol = TextEditingController();
    //--------------------------------------
    // return iteninfo(
    //     widget.conte as BuildContext,
    //     widget.icon as IconData,
    //     widget.label as String,
    //     widget.lengthcarac as int,
    //     widget.tipo as String,
    //     widget.textcontrol as TextEditingController);
    return Container();
  }
}
