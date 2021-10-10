import 'package:ecomersbaic/controllers/Analitic.dart';
import 'package:ecomersbaic/main.dart';
import 'package:ecomersbaic/negocio/analitic_negocio.dart';
import 'package:ecomersbaic/views/analiticview/components/cuadroline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ecomersbaic/views/analiticview/components/productanaliticview.dart';

// ignore: camel_case_types
class analiticview extends StatefulWidget {
  int idproducto;
  analiticview(this.idproducto);

  @override
  analiticbody createState() => analiticbody();
}

// ignore: camel_case_types
class analiticbody extends State<analiticview> {
  late TooltipBehavior _tooltipBehavior= TooltipBehavior(enable: true);
  late AnaliticNegocio anali = AnaliticNegocio();
  analiticbody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Color(0xff707070).withOpacity(0.6),
          ),
          onTap: () async{
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyApp()),
            );
          },
        ),
        backgroundColor: Colors.white,
        title: Container(
          width: 200,
          child: Text(
            "Analiticas",
            style: TextStyle(
              color: Color(0xff707070),
              fontSize: 25,
            ),
          ),
        ),
      ),
      body:Container(
        color: Colors.white,
        child: Expanded(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //trabajo
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset:
                            Offset(0, 3), // changes position of shadow
                          ),
                        ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Ganancias del dia", style: TextStyle(
                                        color: Color(0xff707070),
                                      fontSize: 20
                                      ),
                                    ),
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                ),
                                Container(
                                  height: 200,
                                  child: FutureBuilder<List<Analitic>>(
                                    future: anali.getlist({
                                      "tipo": 1,
                                    }),
                                    builder: (context, snapshot) {
                                      //validadores del estado------------------------
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Align(
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              "Error: ${snapshot.error} "),
                                        );
                                      }
                                      //------------------------------------------------
                                      //capturar las categorias
                                      var list = snapshot.data as List<Analitic>;
                                      for(Analitic e in  list ){
                                        print("${e.getganan} - ${e.getfecha}");
                                      }
                                      // inicializar las categorias
                                      return analiticlineview(list);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //analisis 2
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset:
                            Offset(0, 3), // changes position of shadow
                          ),
                        ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Productos mas pedidos", style: TextStyle(
                                        color: Color(0xff707070),
                                        fontSize: 20
                                    ),
                                    ),
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                ),
                                  FutureBuilder<List<Analitic>>(
                                    future: anali.getlist({
                                      "tipo": 3,
                                    }),
                                    builder: (context, snapshot) {
                                      //validadores del estado------------------------
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          height: 200,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: CircularProgressIndicator()),
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              "Error: ${snapshot.error} "),
                                        );
                                      }
                                      //------------------------------------------------
                                      //capturar las categorias
                                      var list = snapshot.data as List<Analitic>;
                                      list = list.reversed.toList();
                                      List<Widget> producif = [];
                                      producif.add(Container(
                                        height: 200,
                                        child: SfCircularChart(
                                          legend:
                                          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                                          tooltipBehavior: _tooltipBehavior,
                                          series: <CircularSeries>[
                                            RadialBarSeries<Analitic, String>(
                                                dataSource: list,
                                                xValueMapper: (Analitic data, _) => ("id : "+ data.getdatosex.getidpro.toString() + " -  Cantidad : " + data.getdatosex.getstock.toString()),
                                                yValueMapper: (Analitic data, _) => data.getdatosex.getstock,
                                                cornerStyle: CornerStyle.bothFlat,
                                                dataLabelSettings: DataLabelSettings(isVisible: true),
                                                enableTooltip: true,
                                                maximumValue: 10)
                                          ],
                                        ),
                                      ),);

                                      for(Analitic e in  list ){
                                        producif.add(productanaliticview(e.getdatosex.getidpro, 200,  e.getdatosex.getname, e.getdatosex.getfoto,
                                            e.getdatosex.getstock,e.getganan, (a){}));
                                      }

                                      // inicializar las categorias
                                      return Column(
                                        children: producif,
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //analisis 3
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                          Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Productos con mas ganacias", style: TextStyle(
                                        color: Color(0xff707070),
                                        fontSize: 20
                                    ),
                                    ),
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                ),
                                FutureBuilder<List<Analitic>>(
                                  future: anali.getlist({
                                    "tipo": 2,
                                  }),
                                  builder: (context, snapshot) {
                                    //validadores del estado------------------------
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        height: 200,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                            "Error: ${snapshot.error} "),
                                      );
                                    }
                                    //------------------------------------------------
                                    //capturar las categorias
                                    var list = snapshot.data as List<Analitic>;
                                    list = list.reversed.toList();
                                    List<Widget> producif = [];
                                    producif.add(Container(
                                      height: 200,
                                      child: SfCircularChart(
                                        legend:
                                        Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                                        tooltipBehavior: _tooltipBehavior,
                                        series: <CircularSeries>[
                                          RadialBarSeries<Analitic, String>(
                                              dataSource: list,
                                              xValueMapper: (Analitic data, _) => ("id : "+ data.getdatosex.getidpro.toString() + " -  ganacia : " + data.getganan.toString()),
                                              yValueMapper: (Analitic data, _) => data.getganan,
                                              cornerStyle: CornerStyle.bothFlat,
                                              dataLabelSettings: DataLabelSettings(isVisible: true),
                                              //enableTooltip: true,
                                              maximumValue: 10)
                                        ],
                                      ),
                                    ),);

                                    for(Analitic e in  list ){
                                      producif.add(productanaliticview(e.getdatosex.getidpro, 200,  e.getdatosex.getname, e.getdatosex.getfoto,
                                          e.getdatosex.getstock,e.getganan, (a){}));
                                    }

                                    // inicializar las categorias
                                    return Column(
                                      children: producif,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        )
      ),
    );
  }

}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
