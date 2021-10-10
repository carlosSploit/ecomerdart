import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: camel_case_types, must_be_immutable
class imageperfilus extends StatefulWidget {
  int weight = 40;
  bool active = true;
  Alignment pos = Alignment.center;
  int espesorbor = 3;
  String url = "";

  imageperfilus(this.weight, this.active, this.pos, this.espesorbor, this.url);

  @override
  imageperbody createState() => imageperbody();
}

// ignore: camel_case_types
class imageperbody extends State<imageperfilus> {
  imageperbody();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.pos,
      child: Container(
        //height: double.maxFinite,
        child: Container(
          width: widget.weight.toDouble(),
          height: widget.weight.toDouble(),
          //image de contenido
          child: Center(
            child: Container(
                width: (widget.weight.toDouble() - widget.espesorbor),
                height: (widget.weight.toDouble() - widget.espesorbor),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(color: Colors.white, width: 2),
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new Image.network("${widget.url}").image))),
          ),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
