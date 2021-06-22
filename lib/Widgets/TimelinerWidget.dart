import 'package:first_app/Models/VolatilityResponse.dart';
import 'package:first_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimelinerWidget extends StatefulWidget {

  VolatilityResponse timelinerResponse;

  TimelinerWidget({@required this.timelinerResponse});

  @override
  _TimelinerWidgetState createState() => _TimelinerWidgetState(this.timelinerResponse);
}

class _TimelinerWidgetState extends State<TimelinerWidget> {

  VolatilityResponse timelinerResponse;

  _TimelinerWidgetState(this.timelinerResponse);



  @override
  Widget build(BuildContext context) {

    if(!timelinerResponse.isEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Timeline dei processi e delle connessioni di rete: (${timelinerResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              margin: EdgeInsets.only(top:10),
              elevation: 5.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 10,
                  height: 300,
                  child:SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text("Data di creazione", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15,)),
                            tooltip: "Data di creazione"
                          ),
                          DataColumn(
                            label: Text("Ultima modifica", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "Data relativa all'ultima modifica"
                          ),
                          DataColumn(
                            label: Text("Descrizione", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "Descrizione"
                          )
                        ],
                        rows: buildTimelinerRows(timelinerResponse),
                      ),
                    )
                ),
              )
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Timeline dei processi e delle connessioni di rete: (${timelinerResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Non sono stati trovati riscontri con le keyword inserite", style: TextStyle(color: fromHex("#949494"), fontSize: 15)),
          ),
        ],
      );
    }
  }
}

List<DataRow> buildTimelinerRows(VolatilityResponse timelinerResponse) {
  List<DataRow> items = [];

    timelinerResponse.datas.forEach((key, value) {
      String createTime = value["Created Date"];
      List<String> createTimeList;
      
      if (createTime != null){
        createTimeList = createTime.toString().split("T");
      }

      String modifiedTime = value["Modified Date"];
      List<String> modifiedTimeList;
      
      if (modifiedTime != null){
        modifiedTimeList = modifiedTime.toString().split("T");
      }

      items.add(
        DataRow(
          cells: [
            DataCell(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (createTimeList != null) ? createTimeList[0] : "null",
                    style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  ),
                  Text(
                    (createTimeList != null) ? createTimeList[1] : "",
                    style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  ),
                ],
              )
            ),
            DataCell(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (modifiedTimeList != null) ? modifiedTimeList[0] : "null",
                    style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  ),
                  Text(
                    (modifiedTimeList != null) ? modifiedTimeList[1] : "",
                    style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  ),
                ],
              )
            ),
            DataCell(Text(value["Description"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
          ],
        )
      );
    });

    return items;
}