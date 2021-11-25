import 'package:flutter/material.dart';

class Buttonstade extends StatefulWidget {
  String title = "";
  bool presstade = true;
  ValueChanged<int> stadechang;
  Buttonstade(this.title, this.stadechang);

  @override
  _ButtonstadeState createState() => _ButtonstadeState();
}

class _ButtonstadeState extends State<Buttonstade> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.stadechang(0);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
        child: Text(
          "${widget.title}",
          style: TextStyle(
              color: (widget.presstade) ? Colors.white : Color(0xff707070),
              fontSize: 16),
        ),
        decoration: BoxDecoration(
          color: (widget.presstade) ? Color(0xff707070) : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
