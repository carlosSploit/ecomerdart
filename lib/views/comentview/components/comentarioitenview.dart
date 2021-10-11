import '../../../config/configinterface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'imageperfilus.dart';

// ignore: camel_case_types, must_be_immutable
class comentarioitenview extends StatefulWidget {
  bool band = false;
  String nombrusuario = "";
  String mensag = "";
  String fecha = "";
  String urlimg = "";

  comentarioitenview(
      this.band, this.nombrusuario, this.mensag, this.fecha, this.urlimg);

  @override
  comentarioitenbody createState() => comentarioitenbody();
}

// ignore: camel_case_types
class comentarioitenbody extends State<comentarioitenview> {
  //int _Aindeximg = 0;
  late configinterface config;
  comentarioitenbody(); //key para el carrosal

  @override
  Widget build(BuildContext context) {
    config = configinterface(context);
    //************* Inten ***************/
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //los comentario de la publicacion
        if (widget.band)
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(15, 10, 5, 0),
            child: Stack(
              children: <Widget>[
                // -------- imagen de interaccion --------------
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      imageperfilus(
                          config.getsizeaproxhight(40).toInt(), true, Alignment.topLeft, 3, widget.urlimg),
                      //---------------- lovers---------------------
                      //------------------------------------------
                    ],
                  ),
                ),
                //----------------------------------------------
                //------------ Mensaje de coment ---------------
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.grey.withOpacity(0.4),
                        width: 0.6,
                      ),
                    ),
                  ),
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    margin: EdgeInsets.fromLTRB(60, 0, 40, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: RichText(
                            textWidthBasis: TextWidthBasis.longestLine,
                            text: new TextSpan(
                              text: '${widget.nombrusuario}',
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: TextStyle(
                                  fontSize: config.getsizeaproxhight(14),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: ' ${widget.mensag}',
                                    style: TextStyle(
                                        fontSize: config.getsizeaproxhight(14),
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                          width: double.infinity,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 3, 10, 3),
                              child: Text(
                                "${widget.fecha}",
                                style: TextStyle(
                                    fontSize: config.getsizeaproxhight(14),
                                    color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //--------------------------------------------------------
              ],
            ),
          ),
      ],
    );
    //***********************************************/;
  }
}
