import 'package:ecomersbaic/controllers/Analitic.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@immutable
// ignore: camel_case_types, must_be_immutable
class analiticlineview extends StatefulWidget {
  late List<Analitic> list;
  analiticlineview(this.list);

  @override
  analiticlinebody createState() => analiticlinebody();
}

// ignore: camel_case_types
class analiticlinebody extends State<analiticlineview> {
  analiticlinebody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return SfCartesianChart(
      // Initialize category axis
        primaryXAxis: CategoryAxis(),

        series: <LineSeries<Analitic, String>>[
          LineSeries<Analitic, String>(
            // Bind data source
              dataSource:  widget.list,
              xValueMapper: (Analitic sales, _) => sales.getfecha,
              yValueMapper: (Analitic sales, _) => sales.getganan,
              dataLabelSettings: DataLabelSettings(isVisible: true)
          )
        ]
    );
    //***********************************************/;
  }
}
