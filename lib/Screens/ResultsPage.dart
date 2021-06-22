import 'package:first_app/Models/BulkExtractorResponse.dart';
import 'package:first_app/Models/GrepResponse.dart';
import 'package:first_app/Models/VolatilityResponse.dart';
import 'package:first_app/Widgets/FileScanWidget.dart';
import 'package:first_app/Widgets/PslistWidget.dart';
import 'package:first_app/Widgets/NetScanWidget.dart';
import 'package:first_app/Widgets/TimelinerWidget.dart';
import 'package:first_app/Widgets/CustomGridView.dart';
import 'package:first_app/Widgets/ShadowContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}


class _ResultsPageState extends State<ResultsPage> {

Map<String,dynamic> allResponses;
Map<String,VolatilityResponse> parsedVolatilityResponses;
BulkExtractorResponse beResponse;
GrepResponse memdumpGrepResponse;
GrepResponse pagefileGrepResponse;


@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      allResponses = ModalRoute.of(context).settings.arguments;
      parsedVolatilityResponses = allResponses["volatility"];
      beResponse = allResponses["bulk"];
      memdumpGrepResponse = allResponses["memdumpGrep"];
      pagefileGrepResponse = allResponses["pagefileGrep"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/BackgroundHomeAlt.png"),
                fit:BoxFit.fill
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
                child: ShadowContainer(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: fromHex("#666666"),
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PslistWidget(pslistResponse: parsedVolatilityResponses["pslist"]),
                          NetScanWidget(netscanResponse: parsedVolatilityResponses["netscan"]),
                          FileScanWidget(fileScanResponse: parsedVolatilityResponses["filescan"]),
                          TimelinerWidget(timelinerResponse: parsedVolatilityResponses["timeliner"]),
                          CustomGridView(beResponse: beResponse, memdumpGrepResponse: memdumpGrepResponse, pagefileGrepResponse: pagefileGrepResponse,)
                        ]
                      ),
                  )
                )
              ),
            )
          )
        ]
      )
    );
  }
}