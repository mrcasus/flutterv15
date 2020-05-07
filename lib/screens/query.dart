import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Query extends StatefulWidget {
  @override
  _QueryState createState() => _QueryState();
}

class _QueryState extends State<Query> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //   appBar: AppBar(
       //     title: Text('Barcode Scanner - googleflutter.com'),
        //  ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("Capture Image",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10),
                ),
                Text(
  'This is Google Fonts',
  style: GoogleFonts.balooThambi(),
),
              ],
            ),
          )
    );
  }
}