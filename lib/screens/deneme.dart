import 'package:flutter/material.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


final subeAdiList = <Person>[Person('AKÇAABAT'), Person('TANJANT'), Person('MEYDAN'), Person('CUMHURİYET'), Person('D.DERE'), Person('KAŞÜSTÜ İRTİBAT'), Person('ARSİN'), Person('OF'), Person('KAÇKAR'), Person('RİZE'), Person('ÇAYKENT'), Person('ÇAYELİ'), Person('ARDEŞEN'), Person('HOPA'), Person('ARTVİN'), Person('GÜMÜŞHANE'), Person('BAYBURT'), Person('VAKFIKEBİR'), Person('ÇUKURÇAYIR')];
final anaKategoriList = <Person1>[Person1('MOBİLYA VE MEFRUŞATLAR'), Person1('DEMİRBAŞLAR'), Person1('BİLGİSAYAR VE YAZICILAR'), Person1('ELEKTRİK/ELEKTRONİK MALZEME')];
final altKategoriList = <Person2>[Person2('AKILLI TELEFON'), Person2('ALARM'), Person2('BANKO'), Person2('BARKOD PRINTER'),  Person2('KANTAR'), Person2('CRADLE'), Person2('KART OKUYUCU'), Person2('KESON'), Person2('PC'), Person2('KLAVYE'), Person2('PORTMANTO'), Person2('PORTRE'), Person2('DOLAP'), Person2('RAF'), Person2('KOLTUK'), Person2('KAMERA'), Person2('PC'), Person2('MONİTÖR'), Person2('KLİMA'), Person2('PANO'), Person2('MODEM'), Person2('MASA'), Person2('ROUTER'), Person2('SANDALYE'), Person2('TABELA'), Person2('UPS'), Person2('SWITCH'), Person2('SEHPA'), Person2('UPS'), Person2('YANGIN TÜPÜ'), Person2('YAZICI'), Person2('SEHPA'), Person2('DVR'), Person2('ECZA DOLABI'), Person2('EL ARABASI'), Person2('EL TERMİNALİ'), Person2('ETEJER'), Person2('HESAP MAKİNESİ'), Person2('IP TELEFON'), Person2('ISITICI'), Person2('JENERATÖR'), Person2('KABİNET')];
final demirbasKategoriList = <Person3>[Person3('AKILLI TELEFON'), Person3('ALARM'), Person3('BANKO'), Person3('BARKOD PRINTER'),  Person3('KANTAR'), Person3('CRADLE'), Person3('KART OKUYUCU'), Person3('KESON'), Person3('PC'), Person3('KLAVYE'), Person3('PORTMANTO'), Person3('PORTRE'), Person3('DOLAP'), Person3('RAF'), Person3('KOLTUK'), Person3('KAMERA'), Person3('PC'), Person3('MONİTÖR'), Person3('KLİMA'), Person3('PANO'), Person3('MODEM'), Person3('MASA'), Person3('ROUTER'), Person3('SANDALYE'), Person3('TABELA'), Person3('UPS'), Person3('SWITCH'), Person3('SEHPA'), Person3('UPS'), Person3('YANGIN TÜPÜ'), Person3('YAZICI'), Person3('SEHPA'), Person3('DVR'), Person3('ECZA DOLABI'), Person3('EL ARABASI'), Person3('EL TERMİNALİ'), Person3('ETEJER'), Person3('HESAP MAKİNESİ'), Person3('IP TELEFON'), Person3('ISITICI'), Person3('JENERATÖR'), Person3('KABİNET')];
final letters = 'abcdefghijklmnopqrstuvwxyz'.split('');

class _MyHomePageState extends State<MyHomePage> {
  String selectedLetter;
  Person selectedPerson;
  Person1 selectedPerson1;
  Person2 selectedPerson2;
  Person3 selectedPerson3;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;


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
  Widget build(BuildContext context) => Scaffold(
      key: scaffoldKey,
     // appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          autovalidate: autovalidate,
          child: ListView(children: <Widget>[
            SizedBox(height: 8.0),
           // Text('Selected person: "$selectedPerson"'),
          //  Text('Selected letter: "$selectedLetter"'),
            SizedBox(height: 8.0),
            
            //subeadı
            SimpleAutocompleteFormField<Person>(
              decoration: InputDecoration(
                  labelText: 'Şube Adı', border: OutlineInputBorder()),
              suggestionsHeight: 80.0,
              itemBuilder: (context, person) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          //Text(person.address)
                        ]),
                  ),
              onSearch: (search) async => subeAdiList
                  .where((person) =>
                      person.name
                          .toLowerCase()
                          .contains(search.toLowerCase()) 
                      )
                  .toList(),
              itemFromString: (string) => subeAdiList.singleWhere(
                  (person) => person.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedPerson = value),
              onSaved: (value) => setState(() => selectedPerson = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),
            SizedBox(height: 8.0),

            //ana kategori
            SimpleAutocompleteFormField<Person1>(
              decoration: InputDecoration(
                  labelText: 'Ana Kategori', border: OutlineInputBorder()),
              suggestionsHeight: 80.0,
              itemBuilder: (context, person) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          //Text(person.address)
                        ]),
                  ),
              onSearch: (search) async => anaKategoriList
                  .where((person) =>
                      person.name
                          .toLowerCase()
                          .contains(search.toLowerCase()) 
                      )
                  .toList(),
              itemFromString: (string) => anaKategoriList.singleWhere(
                  (person) => person.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedPerson1 = value),
              onSaved: (value) => setState(() => selectedPerson1 = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),
            SizedBox(height: 8.0),
           
           //alt kategori
            SimpleAutocompleteFormField<Person2>(
              decoration: InputDecoration(
                  labelText: 'Alt Kategori', border: OutlineInputBorder()),
              suggestionsHeight: 80.0,
              itemBuilder: (context, person) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          //Text(person.address)
                        ]),
                  ),
              onSearch: (search) async => altKategoriList
                  .where((person) =>
                      person.name
                          .toLowerCase()
                          .contains(search.toLowerCase()) 
                      )
                  .toList(),
              itemFromString: (string) => altKategoriList.singleWhere(
                  (person) => person.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedPerson2 = value),
              onSaved: (value) => setState(() => selectedPerson2 = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),
            SizedBox(height: 8.0),

            //demirbaş kategori
            SimpleAutocompleteFormField<Person3>(
              decoration: InputDecoration(
                  labelText: 'Demirbaş Kategori', border: OutlineInputBorder()),
              suggestionsHeight: 80.0,
              itemBuilder: (context, person) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          //Text(person.address)
                        ]),
                   
                  ),
              onSearch: (search) async => demirbasKategoriList
                  .where((person) =>
                      person.name
                          .toLowerCase()
                          .contains(search.toLowerCase()) 
                      )
                  .toList(),
              itemFromString: (string) => demirbasKategoriList.singleWhere(
                  (person) => person.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedPerson3 = value),
              onSaved: (value) => setState(() => selectedPerson3 = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),
            SizedBox(height: 8.0),
           
            Container(
                //color: Colors.orange,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Demirbaş Kategori', border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
                    suffix: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: scan,
                        ),
                  ),
                  
                ),
              ),
           
           SizedBox(height: 8.0),
           Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                      Text('Barkod:',
                      style: TextStyle(fontSize: 18.0,color: Colors.red),
                      ),
                      Text(barcode),
                     
              IconButton(
                icon: Icon(Icons.camera_alt),
                tooltip: 'Close',
                    iconSize: 30,
                    onPressed: scan, 
              )
            ],
           
                     ),
            
          ]),
        ),
      ));
}

class Person {
  Person(this.name);
  final String name;
  @override
  String toString() => name;
}

class Person1 {
  Person1(this.name);
  final String name;
  @override
  String toString() => name;
}

class Person2 {
  Person2(this.name);
  final String name;
  @override
  String toString() => name;
}

class Person3 {
  Person3(this.name);
  final String name;
  @override
  String toString() => name;
}

class Person4 {
  Person4(this.name);
  final String name;
  @override
  String toString() => name;
}
void main() => runApp(MyApp());
const title = 'simple_autocomplete_formfield example';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
     // title: title,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
