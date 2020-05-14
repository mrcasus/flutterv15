import 'package:flutter/material.dart';

class Tablex extends StatefulWidget {
  @override
  _TablexState createState() => _TablexState();
}

class _TablexState extends State<Tablex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.redAccent,
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SingleChildScrollView(
            child: DataTable(
              sortAscending: true,
              sortColumnIndex: 0,
              columns: [
                DataColumn(
                    label: Text(
                      "USN",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w900),
                    ),
                    tooltip: "Student USN Number"),
                DataColumn(
                    label: Text(
                  "Name",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w900),
                )),
                DataColumn(
                    label: Text(
                      "Marks",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w900),
                    ),
                    numeric: true),
                DataColumn(
                    label: Text(
                      "Percentage",
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w900),
                    ),
                    numeric: true),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text("1"), showEditIcon: true),
                    DataCell(Text("Pavan")),
                    DataCell(Text("99")),
                    DataCell(Text("99%")),
                  ],
                  selected: true,
                ),
                DataRow(cells: [
                  DataCell(Text("2")),
                  DataCell(Text("Suraj"), showEditIcon: true),
                  DataCell(Text("85")),
                  DataCell(Text("87%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("3")),
                  DataCell(Text("Rajat")),
                  DataCell(Text("Fill Marks"), placeholder: true),
                  DataCell(Text("89%")),
                ]),
                DataRow(cells: [
                  DataCell(Text("4")),
                  DataCell(Text("Sanjay")),
                  DataCell(Text("75")),
                  DataCell(Text("80%")),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}