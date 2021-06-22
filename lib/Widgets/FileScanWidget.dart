import 'package:first_app/Models/VolatilityResponse.dart';
import 'package:first_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileScanWidget extends StatefulWidget {

  VolatilityResponse fileScanResponse;

  FileScanWidget({@required this.fileScanResponse});

  @override
  _FileScanWidgetState createState() => _FileScanWidgetState(this.fileScanResponse);
}

class _FileScanWidgetState extends State<FileScanWidget> {

  VolatilityResponse fileScanResponse;

  _FileScanWidgetState(this.fileScanResponse);



  @override
  Widget build(BuildContext context) {
    if(!fileScanResponse.isEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Lista dei file aperti: (${fileScanResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
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
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text("Name", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15,)),
                          tooltip: "Nome del file"
                        ),
                        DataColumn(
                          label: Text("Size", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 15)),
                          tooltip: "Grandezza del file"
                        )
                      ],
                      rows: buildFilescanRows(fileScanResponse),
                    ),
                  )
                ),
              )
            ),
          ),
        ],
      );
    } else if (fileScanResponse.isEmpty && !fileScanResponse.isUnsupported){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Lista dei file aperti: (${fileScanResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Non sono stati trovati riscontri con le keyword inserite", style: TextStyle(color: fromHex("#949494"), fontSize: 15)),
          ),
        ],
      );
    } else if (fileScanResponse.isUnsupported){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0, left: 10),
            child: Text("Lista dei file aperti: (${fileScanResponse.datas.length})", style: TextStyle(color: fromHex("#00A4CE"), fontSize: 20,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Filescan non è compatibile con il sistema operativo sceltoe", style: TextStyle(color: fromHex("#949494"), fontSize: 15)),
          ),
        ],
      );
    }
  }
}

List<DataRow> buildFilescanRows(VolatilityResponse fileScanResponse) {
  List<DataRow> items = [];

    fileScanResponse.datas.forEach((key, value) {

      items.add(
        DataRow(
          cells: [
            DataCell(Text(value["Name"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15), overflow: TextOverflow.clip,)),
            DataCell(Text(value["Size"].toString() ?? "null", style: TextStyle(color: fromHex("#949494"), fontSize: 15))),
          ],
        )
      );
    });

    return items;
}