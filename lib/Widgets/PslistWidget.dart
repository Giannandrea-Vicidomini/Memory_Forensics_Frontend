import 'package:first_app/Models/VolatilityResponse.dart';
import 'package:first_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PslistWidget extends StatefulWidget {

  VolatilityResponse pslistResponse;

  PslistWidget({@required this.pslistResponse});

  @override
  _PslistWidgetState createState() => _PslistWidgetState(this.pslistResponse);
}

class _PslistWidgetState extends State<PslistWidget> {

  VolatilityResponse pslistResponse;

  _PslistWidgetState(this.pslistResponse);

  @override
  Widget build(BuildContext context) {
    if(!pslistResponse.isEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text("Lista dei processi individuata: (${pslistResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            //pslist
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.only(top:10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 10,
                  height: 300,
                  child: SingleChildScrollView(
                    child: 
                    DataTable(
                      columns: [
                        DataColumn(
                          label: Text("Name", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15,)),
                          tooltip: "Rappresente il nome del processo"
                        ),
                        DataColumn(
                          label: Text("PID", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                          tooltip: "Process ID"
                        ),
                        DataColumn(
                          label: Text("PPID", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                          tooltip: "Process ID del processo padre"
                        ),
                        DataColumn(
                          label: Text("Thds", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                          tooltip: "Numero di threads dedicati al processo"
                        ),
                        DataColumn(
                          label: Text("CreateTime", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                          tooltip: "Data di creazione del processo"
                        ),
                        DataColumn(
                          label: Text("ExitTime", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                          tooltip: "Data di fine del processo"
                        ),
                        DataColumn(
                          label: Text("SessionID", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                          tooltip: "ID di sessione dell'utente"
                        ),
                      ],
                      rows: buildPslistRows(pslistResponse),
                    ),
                  ),
                ),
              ),
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
            child: Text("Lista dei processi individuata: (${pslistResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
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

List<DataRow> buildPslistRows(VolatilityResponse pslistResponse) {
  List<DataRow> items = [];

    pslistResponse.datas.forEach((key, value) {
      String createTime = value["CreateTime"];
      List<String> createTimeList;
      String exitTime = value["ExitTime"];
      List<String> exitTimeList;
      
      if (createTime != null){
        createTimeList = createTime.toString().split("T");
      }

      if (exitTime != null){
        exitTimeList = exitTime.toString().split("T");
      }
      items.add(
        DataRow(
          cells: [
            DataCell(Text(value["ImageFileName"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
            DataCell(Text(value["PID"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
            DataCell(Text(value["PPID"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
            DataCell(Text(value["Threads"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
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
                    (exitTimeList != null) ? exitTimeList[0] : "null",
                    style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  ),
                  Text(
                    (exitTimeList != null) ? exitTimeList[1] : "",
                    style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  ),
                ],
              ),
            ),
            DataCell(Text(value["SessionId"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
          ],
        )
      );
    });

    return items;
}