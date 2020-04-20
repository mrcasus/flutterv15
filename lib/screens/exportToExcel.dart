import 'package:flutter/material.dart';
import 'package:flutterappv14/utils/database_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportToExcel extends StatefulWidget {
  @override
  _ExportToExcelState createState() => _ExportToExcelState();
}

class _ExportToExcelState extends State<ExportToExcel> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  getPermission() async {
    await Permission.storage.request().then((value) {
      if (value == PermissionStatus.denied) {
        requestPermission();
      }
    });
  }

  requestPermission() async {
    await Permission.storage.request();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: RaisedButton(
          onPressed: () {
            DatabaseHelper().exportAll().then((path) {
              DatabaseHelper().showSnackBar(path.toString(), scaffoldKey);
            });
          },
          child: Text("Excel'e Aktar"),
        ),
      ),
    );
  }
}
