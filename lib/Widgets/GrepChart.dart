import 'package:first_app/Models/GrepMatch.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:first_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GrepChart extends StatefulWidget {

  List<charts.Series<GrepMatch, String>> _seriesPieData;
  String title;

  GrepChart(this._seriesPieData, this.title);

  @override
  _GrepChartState createState() => _GrepChartState(this._seriesPieData, this.title);
}

class _GrepChartState extends State<GrepChart> {

  List<charts.Series<GrepMatch, String>> _seriesPieData;
  String title;

  _GrepChartState(this._seriesPieData, this.title);

  @override
  Widget build(BuildContext context) {
    if(_seriesPieData.isNotEmpty){
      return Container(
        padding: EdgeInsets.all(25),
        child: Card(
          elevation: 10.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(title, style:TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
              ),
              Expanded(
                child: charts.PieChart(
                  _seriesPieData,
                  animate: true,
                  animationDuration: Duration(seconds: 2),
                  behaviors: [
                    charts.DatumLegend(
                      outsideJustification: charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 3,
                      cellPadding: EdgeInsets.only(right: 4, bottom:4, top: 5),
                      entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.blue.shadeDefault,
                        fontSize: 11
                      )
                    )
                  ],
                  defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 200,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.outside
                      )
                    ]
                  ),
                ),
              ),
            ],
          ),
        )
      );
    } else {
      return Container(
        padding: EdgeInsets.all(25),
        child: Card(
          elevation: 10.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(title, style:TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
              ),
              Expanded(
                child: Text("Non sono stati trovati riscontri con le keyword inserite", style: TextStyle(color: fromHex("#949494"), fontSize: 15)),
              ),
            ],
          ),
        )
      );
    }
  }
}