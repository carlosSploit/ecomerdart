import 'package:flutter/material.dart';
import '../../config/configinterface.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:another_flushbar/flushbar.dart' show Flushbar, FlushbarPosition;

// ignore: camel_case_types, must_be_immutable
class mensajealert extends StatefulWidget {
  @override
  contentserbody createState() => contentserbody();

  void customShapeSnackBar(BuildContext context, String mensaje, String tipo) {
    contentserbody().customShapeSnackBar(context, mensaje, tipo);
  }
}

// ignore: camel_case_types
class contentserbody extends State<mensajealert>
    with SingleTickerProviderStateMixin {
  configinterface? config;
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }

  void customShapeSnackBar(BuildContext context, String mensaje, String tipo) {
    config = configinterface(context);
    Flushbar(
      maxWidth: (mensaje.length * 8.0) + config!.getsizeaproxwigth(30),
      icon: Container(
        height: config!.getsizeaproxhight(30),
        width: config!.getsizeaproxwigth(30),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            (tipo == "T")
                ? Icons.check_circle_outlined
                : Icons.error_outline_outlined,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (tipo == "T") ? Colors.green : Colors.red,
        ),
      ),
      messageText: Container(
        child: Row(
          children: [
            Container(
              child: Text(
                "$mensaje",
                style: TextStyle(
                  fontSize: config!.getsizeaproxhight(15),
                  color: (tipo == "T") ? Colors.green : Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(25.0),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
