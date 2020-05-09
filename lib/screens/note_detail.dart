
import 'package:flutter/material.dart';
import 'package:flutterappv14/models/note.dart';
import 'package:flutterappv14/utils/database_helper.dart';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


class NoteDetail extends StatefulWidget {

	final String appBarTitle;
	final Note note;

	NoteDetail({this.note, this.appBarTitle}); // Bu şekilde süslü parantezli kullanırsanız parametreler optional olur yani isteğe bağlı

	@override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {

	static var _priorities = ['High', 'Low'];

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	Note note;
  

	NoteDetailState(this.note, this.appBarTitle);

  List<String> sube=['AKÇAABAT','TANJANT','MEYDAN','CUMHURİYET','D.DERE','KAŞÜSTÜ İRTİBAT','ARSİN','OF','KAÇKAR','RİZE','ÇAYKENT','ÇAYELİ','ARDEŞEN','HOPA','ARTVİN','GÜMÜŞHANE','BAYBURT','VAKFIKEBİR','GİRESUN','BULANCAK','DURUGÖL','ORDU','BOZTEPE','ÇUKURÇAYIR',];
  String _sube='AKÇAABAT';

  void pilihSube(String value){
    setState(() {
      _sube=value;
    });
  }

  List<String> ana=['MOBİLYA VE MEFRUŞATLAR','DEMİRBAŞLAR','BİLGİSAYAR VE YAZICILAR','ELEKTRİK/ELEKTRONİK MALZEME'];
  String _ana='MOBİLYA VE MEFRUŞATLAR';

  void pilihAna(String value){
    setState(() {
      _ana=value;
    });
  }

 
  List<String> alt=['AKILLI TELEFON','ALARM','BANKO','BARKOD PRINTER','CRADLE','DOLAP','KAMERA','DVR','ECZA DOLABI','EL ARABASI','EL TERMİNALİ','ETEJER','HESAP MAKİNESİ','IP TELEFON','ISITICI','JENERATÖR','KABİNET','KANTAR','KART OKUYUCU','KESON','KLAVYE','KLİMA','KOLTUK','MASA','MODEM','MONİTÖR','PANO','PC','PORTMANTO','PORTRE','RAF','ROUTER','SANDALYE','SEHPA','SEHPA','SWITCH','TABELA','UPS','YANGIN TÜPÜ','YAZICI'];
  String _alt='AKILLI TELEFON';

  void pilihAlt(String value){
    setState(() {
      _alt=value;
    });
  }

  List<String> demalt=['AKILLI TELEFON','ALARM','BANKO','BARKOD PRINTER','CRADLE','DOLAP','KAMERA','DVR','ECZA DOLABI','EL ARABASI','EL TERMİNALİ','ETEJER','HESAP MAKİNESİ','IP TELEFON','ISITICI','JENERATÖR','KABİNET','KANTAR','KART OKUYUCU','KESON','KLAVYE','KLİMA','KOLTUK','MASA','MODEM','MONİTÖR','PANO','PC','PORTMANTO','PORTRE','RAF','ROUTER','SANDALYE','SEHPA','SEHPA','SWITCH','TABELA','UPS','YANGIN TÜPÜ','YAZICI'];
  String _demalt='AKILLI TELEFON';

  void pilihDemalt(String value){
    setState(() {
      _demalt=value;
    });
  }
 
 String barcode = "";

Future scan() async {
 try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
               this.barcode = 'Kamera yetkisi verin!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'Lütfen barkod okutunuz!');
    } catch (e) {
     setState(() => this.barcode = 'Unknown error: $e');
    }
  }



	@override
  Widget build(BuildContext context) {

	//	TextStyle textStyle = Theme.of(context).textTheme.title;

  //_ana = widget.note.anakat;
  //_alt = widget.note.altkat;
  //_demalt = widget.note.demalt;
 // _sube = widget.note.subeadi;

    return WillPopScope(

	    onWillPop: () {
	    	// Write some code to control things, when user press Back navigation button in device navigationBar
		    moveToLastScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    // Write some code to control things, when user press back button in AppBar
		    	    moveToLastScreen();
				    }
		    ),
	    ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        
        // First element
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Tip :      ',style: TextStyle(fontSize: 18.0,color: Colors.red),),
              Expanded(
                child: DropdownButton(
                 // value: 'hahaha',
                  items: _priorities.map((String dropDownStringItem) {
							    	return DropdownMenuItem<String> (
                     
									    value: dropDownStringItem,
									    child: Text(dropDownStringItem),
								    );
							    }).toList(),
                  

                  onChanged: (valueSelectedByUser) {
                    setState(() {
							    	  debugPrint('User selected $valueSelectedByUser');
							    	  updatePriorityAsInt(valueSelectedByUser);
							    	});
                  }
                  ),
                  ),
            ],
         ),

         //sube 
         Row(
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
               Text('Şube adı :  ',style: TextStyle(fontSize: 18.0,color: Colors.red),),
               Expanded(
                 child: DropdownButton<String>(
                   isExpanded: true,
                   onChanged: (String value){
                            pilihSube(value);
                            updateTitle();
                          },
                          value: _sube,
                         items: sube.map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                ),
                            );
                          }).toList(),
                 ))
             ],
          ),


                
          // Ana Kategori
          Row(
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
               Text('Ana Kategori :  ',style: TextStyle(fontSize: 18.0,color: Colors.red),),
               Expanded(
                 child: DropdownButton<String>(
                   isExpanded: true,
                   onChanged: (String value){
                            pilihAna(value);
                            updateDescription();
                          },
                          value: _ana,
                         items: ana.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                ),
                            );
                          }).toList(),
                 ))
             ],
          ),

        // Alt kategori
          Row(
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
               Text('Alt Kategori :  ',style: TextStyle(fontSize: 18.0,color: Colors.red),),
               Expanded(
                 child: DropdownButton<String>(
                   isExpanded: true,
                   onChanged: (String value){
                            pilihAlt(value);
                            updateAltkat();
                          },
                          value: _alt,
                         items: alt.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                ),
                            );
                          }).toList(),
                 ))
             ],
          ),

          
// demirbas kategori
          Row(
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
               Text('Demirbaş Kategori :  ',style: TextStyle(fontSize: 18.0,color: Colors.red),),
               Expanded(
                 child: DropdownButton<String>(
                   isExpanded: true,
                   onChanged: (String value){
                             pilihDemalt(value);
                            updateDemalt();
                          },
                          value: _demalt,
                         items: demalt.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                ),
                            );
                          }).toList(),
                 ))
             ],
          ),
          //barkod
          Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                      Text('Barkod:',
                      style: TextStyle(fontSize: 18.0,color: Colors.red),
                      ),
                      Text(barcode,
                      style: TextStyle(fontSize: 18.0,color: Colors.black),
                      ),
                     IconButton(
                    icon: Icon(Icons.camera),
                    iconSize: 30,
                    onPressed: scan,
                    //scan,
                    )
            ],
                     ),
            
            
            //save
            Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  _save();
									    	});
									    },
								    ),
							    ),
                ],
              ),
              ),
              
          ],
        ) ,
      ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

	// Convert the String priority in the form of integer before saving it to Database
	void updatePriorityAsInt(String value) {
		switch (value) {
			case 'High':
				note.priority = 1;
				break;
			case 'Low':
				note.priority = 2;
				break;
		}
	}

	// Convert int priority to String priority and display it to user in DropDown
	String getPriorityAsString(int value) {
		String priority;
		switch (value) {
			case 1:
				priority = _priorities[0];  // 'High'
				break;
			case 2:
				priority = _priorities[1];  // 'Low'
				break;
		}
		return priority;
	}

	// Update the title of Note object
  void updateTitle(){
    {      
    note.subeadi = _sube;
    }
  }

	// Update the description of Note object
	void updateDescription() {
    {
    note.anakat = _ana;
    }
	}

  // Update the altkat of Note object
  void updateAltkat(){ 
    {
    note.altkat = _alt;
  }

  }

  // Update the demalt of Note object
  void updateDemalt(){
    {
          note.demalt = _demalt;
    }
  }

  // Update the barkod of Note object
  void updateBarkod(){
     {
          note.barkod = barcode; 
    }
  }

	// Save data to database
	void _save() async {

		moveToLastScreen();

		note.date = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (note.id != null) {  // Case 1: Update operation
			result = await helper.updateNote(note);
		} else { // Case 2: Insert Operation
			result = await helper.insertNote(note);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'Note Saved Successfully');
		} else {  // Failure
			_showAlertDialog('Status', 'Problem Saving Note');
		}

	}

//	void _delete() async {

//		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
//		if (note.id == null) {
//			_showAlertDialog('Status', 'No Note was deleted');
//			return;
	//	}

		// Case 2: User is trying to delete the old note that already has a valid ID.
//		int result = await helper.deleteNote(note.id);
//		if (result != 0) {
//			_showAlertDialog('Status', 'Note Deleted Successfully');
//		} else {
//			_showAlertDialog('Status', 'Error Occured while Deleting Note');
	//	}
	//}

	void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
			context: context,
		builder: (_) => alertDialog
		);
	}

}
