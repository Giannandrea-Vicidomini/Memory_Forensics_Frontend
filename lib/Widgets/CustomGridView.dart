import 'package:first_app/Models/BulkExtractorMatch.dart';
import 'package:first_app/Models/BulkExtractorResponse.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:first_app/Models/GrepMatch.dart';
import 'package:first_app/Models/GrepResponse.dart';
import 'package:first_app/Widgets/BeChart.dart';
import 'package:first_app/Widgets/GrepChart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatefulWidget {

  BulkExtractorResponse beResponse;
  GrepResponse memdumpGrepResponse;
  GrepResponse pagefileGrepResponse;

  CustomGridView({@required this.beResponse, @required this.memdumpGrepResponse, @required this.pagefileGrepResponse});
  
  @override
  _CustomGridViewState createState() => _CustomGridViewState(this.beResponse, this.memdumpGrepResponse, this.pagefileGrepResponse);
}

class _CustomGridViewState extends State<CustomGridView> {

  BulkExtractorResponse beResponse;
  List<charts.Series<BulkExtractorMatch, String>> _domainsSeriesPieData;
  List<charts.Series<BulkExtractorMatch, String>> _emailsSeriesPieData;
  List<charts.Series<BulkExtractorMatch, String>> _headersSeriesPieData;
  List<charts.Series<BulkExtractorMatch, String>> _ipAddressesSeriesPieData;
  List<charts.Series<BulkExtractorMatch, String>> _urlsSeriesPieData;

  GrepResponse memdumpGrepResponse;
  List<charts.Series<GrepMatch, String>> _memdumpSeriesPieData;

  GrepResponse pagefileGrepResponse;
  List<charts.Series<GrepMatch, String>> _pagefileSeriesPieData;

  _CustomGridViewState(this.beResponse, this.memdumpGrepResponse, this.pagefileGrepResponse){
    _domainsSeriesPieData = _generateBePieData(beResponse.domains);
    _emailsSeriesPieData = _generateBePieData(beResponse.emails);
    _headersSeriesPieData = _generateBePieData(beResponse.headers);
    _ipAddressesSeriesPieData = _generateBePieData(beResponse.ipAddresses, constructor: "ip");
    _urlsSeriesPieData = _generateBePieData(beResponse.urls);

    _memdumpSeriesPieData = _generateGrepPieData(memdumpGrepResponse.matches);
    _pagefileSeriesPieData = _generateGrepPieData(pagefileGrepResponse.matches);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: 80,
          maxHeight: double.infinity,
      ),
      child: Container(
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(30),
          crossAxisCount: 2,
          children: [
            BeChart(_domainsSeriesPieData, "Grafico relativo ai domini:"),
            BeChart(_emailsSeriesPieData, "Grafico relativo alle email:"),
            BeChart(_headersSeriesPieData, "Grafico relativo agli headers:"),
            BeChart(_ipAddressesSeriesPieData, "Grafico relativo agli indirizzi ip:"),
            BeChart(_urlsSeriesPieData, "Grafico relativo agli url:"),
            GrepChart(_memdumpSeriesPieData, "Grafico di grep eseguito sul memdump:"),
            GrepChart(_pagefileSeriesPieData, "Grafico di grep eseguito sul pagefile:")
          ]
        ),
      ),
    );
  }
}

List<charts.Series<BulkExtractorMatch, String>> _generateBePieData(Map<String, BulkExtractorMatch> matches, {constructor="standard"}) {
  List<BulkExtractorMatch> pieData = [];
  List<charts.Series<BulkExtractorMatch, String>> _seriesPieData = [];
  if(matches.isNotEmpty){

    matches.forEach((key, value) { 
      if(constructor == "ip") {
        value.matches.forEach((match, occurrences) { 
          BulkExtractorMatch bulk_match = BulkExtractorMatch(match);
          bulk_match.occurrences = occurrences;
          pieData.add(bulk_match);
        });
      } else {
        if(value.occurrences > 0)
         pieData.add(value);
      }
    });
    
    if(pieData.isNotEmpty)
      _seriesPieData.add(
        charts.Series(
          data: pieData,
          domainFn: (BulkExtractorMatch match, _) => match.keyword,
          measureFn: (BulkExtractorMatch match, _) => match.occurrences,
          id: "Grafico",
          labelAccessorFn: (BulkExtractorMatch match, _) => '${match.occurrences}'
        )
      );
  }

  return _seriesPieData;
}

List<charts.Series<GrepMatch, String>> _generateGrepPieData(Map<String, GrepMatch> matches) {
  List<GrepMatch> pieData = [];
  List<charts.Series<GrepMatch, String>> _seriesPieData = [];
  if(matches.isNotEmpty){

    matches.forEach((key, value) { 
      if(value.occurrences >0)
        pieData.add(value);
    });
    
    if(pieData.isNotEmpty)
      _seriesPieData.add(
        charts.Series(
          data: pieData,
          domainFn: (GrepMatch match, _) => match.keyword,
          measureFn: (GrepMatch match, _) => match.occurrences,
          id: "Grafico",
          labelAccessorFn: (GrepMatch match, _) => '${match.occurrences}'
        )
      );
  }

  return _seriesPieData;
}