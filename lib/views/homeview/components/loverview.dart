import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../negocio/califipro_negocio.dart';

// ignore: camel_case_types, must_be_immutable
class loverview extends StatefulWidget {
  int idusuario = 0;
  int idproduct = 0;

  int estado = 0;
  int size = 0;
  ValueChanged<int> accionrecarga;

  loverview(this.size, this.idusuario, this.idproduct, this.estado,
      this.accionrecarga);

  @override
  loverbody createState() => loverbody();
}

// ignore: camel_case_types
class loverbody extends State<loverview> {
  loverbody();

  CalifiproNegocio cont = CalifiproNegocio();

  actualizar() {
    if (widget.estado == 1) {
      widget.estado = 0;
      cont.deletcalificarpro(
          {"idpro": widget.idproduct, "idcli": widget.idusuario});
    } else {
      widget.estado = 1;
      cont.calificarpro({"idpro": widget.idproduct, "idcli": widget.idusuario});
    }

    widget.accionrecarga(0);
    // print("${widget.estado} -> estado");
    // print("${widget.id_product} -> id_producto");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    widget.estado = widget.estado;
    return InkWell(
      child: Container(
        width: widget.size * 1.0,
        height: widget.size * 1.0,
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: widget.size * 0.51,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size / 2),
          color: (widget.estado == 0)
              ? Color(0xff707070).withOpacity(0.6)
              : Colors.red.withOpacity(0.6),
        ),
      ),
      onTap: () {
        actualizar();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => mainpublicview()),
        // );
      },
    );
    //***********************************************/;
  }
}
