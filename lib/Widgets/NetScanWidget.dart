import 'package:first_app/Models/VolatilityResponse.dart';
import 'package:first_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetScanWidget extends StatefulWidget {

  VolatilityResponse netscanResponse;

  NetScanWidget({@required this.netscanResponse});

  @override
  _NetScanWidgetState createState() => _NetScanWidgetState(this.netscanResponse);
}

class _NetScanWidgetState extends State<NetScanWidget> {

  VolatilityResponse netscanResponse;

  _NetScanWidgetState(this.netscanResponse);



  @override
  Widget build(BuildContext context) {

    if(!netscanResponse.isEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Lista delle connessioni di rete: (${netscanResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.only(top:10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 10,
                  height: 300,
                  child:SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text("IP esterno", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15,)),
                            tooltip: "Foregin address"
                          ),
                          DataColumn(
                            label: Text("IP locale", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "Local address"
                          ),
                          DataColumn(
                            label: Text("Protocollo", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "Protocollo di trasferimento dati"
                          ),
                          DataColumn(
                            label: Text("Owner", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "Processo proprietario"
                          ),
                          DataColumn(
                            label: Text("PID", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "PID dell'owner"
                          ),
                          DataColumn(
                            label: Text("Stato", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "Stato della connessione"
                          ),
                          DataColumn(
                            label: Text("Created", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                            tooltip: "Data di creazione della connessione"
                          ),
                        ],
                        rows: buildNetscanRows(netscanResponse),
                      ),
                    )
                ),
              )
            ),
          ),
        ],
      );
    } else if(netscanResponse.isEmpty && !netscanResponse.isUnsupported){
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Lista delle connessioni di rete: (${netscanResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Non sono stati trovati riscontri con le keyword inserite", style: TextStyle(color: fromHex("#949494"), fontSize: 15)),
          ),
        ],
      );
    } else if (netscanResponse.isUnsupported){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Lista delle connessioni di rete: (${netscanResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Netscan non è compatibile con il sistema operativo scelto", style: TextStyle(color: fromHex("#949494"), fontSize: 15)),
          ),
        ],
      );
    }
  }
}

List<DataRow> buildNetscanRows(VolatilityResponse netscanResponse) {
  List<DataRow> items = [];

    netscanResponse.datas.forEach((key, value) {
      String createTime = value["Created"];
      List<String> createTimeList;
      
      if (createTime != null){
        createTimeList = createTime.toString().split("T");
      }

      items.add(
        DataRow(
          cells: [
            DataCell(
              RichText(
                text: TextSpan(text: value["ForeignAddr"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                children: [
                  TextSpan(
                    text: ":"+ value["ForeignPort"].toString() ?? "", style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  )
                ]
                )
              )
            ),
            DataCell(
              RichText(
                text: TextSpan(text: value["LocalAddr"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                children: [
                  TextSpan(
                    text: ":"+ value["LocalPort"].toString() ?? "", style: TextStyle(color: fromHex("#949494"), fontSize: 15),
                  )
                ]
                )
              )
            ),
            DataCell(Text(value["Proto"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
            DataCell(Text(value["Owner"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
            DataCell(Text(value["PID"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
            DataCell(Text(value["State"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
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
          ],
        )
      );
    });

    return items;
}