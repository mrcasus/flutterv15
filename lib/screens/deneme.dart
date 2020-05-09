import 'package:flutter/material.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

final subeadi = <Person>[Person('AKÇAABAT'), Person('TANJANT'), Person('MEYDAN'), Person('CUMHURİYET'), Person('DEGİRMENDERE'), Person('ÇUKURÇAYIR'), Person('KAŞÜSTÜ'), Person('ARSİN'), Person('OF'), Person('KAÇKAR'), Person('RİZE'), Person('ÇAYKENT'), Person('CAYELİ'), Person('ARDEŞEN'), Person('HOPA'), Person('ARTVİN'), Person('GÜMÜŞHANE'), Person('BAYBURT')];
final anakat = <Person1>[Person1('adadad'), Person1('dsdsdfsd')];
final letters = 'abcdefghijklmnopqrstuvwxyz'.split('');

class _MyHomePageState extends State<MyHomePage> {
  String selectedLetter;
  Person selectedPerson;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;

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
            SizedBox(height: 16.0),
            Text('Selected person: "$selectedPerson"'),
            Text('Selected letter: "$selectedLetter"'),
            SizedBox(height: 16.0),                   
            // subeadi
            SimpleAutocompleteFormField<Person>(
              decoration: InputDecoration(
                  labelText: 'Subeadi',
                  // border: OutlineInputBorder(),
                  fillColor: Colors.white,
              hoverColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1)),
                  ),
              suggestionsHeight: 80.0,
              itemBuilder: (context, person) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                         // Text(person.address)
                        ]),
                  ),
              onSearch: (search) async => subeadi
                  .where((person) =>
                      person.name
                          .toLowerCase()
                          .contains(search.toLowerCase()) )
                  .toList(),
              itemFromString: (string) => subeadi.singleWhere(
                  (person) => person.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedPerson = value),
              onSaved: (value) => setState(() => selectedPerson = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),
            SizedBox(height: 16.0),

            // subeadi
            SimpleAutocompleteFormField<Person1>(
              decoration: InputDecoration(
                  labelText: 'Subeadi', border: OutlineInputBorder()),
              suggestionsHeight: 80.0,
              itemBuilder: (context, person1) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(person1.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                         // Text(person.address)
                        ]),
                  ),
              onSearch: (search) async => anakat
                  .where((person1) =>
                      person1.name
                          .toLowerCase()
                          .contains(search.toLowerCase()) )
                  .toList(),
              itemFromString: (string) => anakat.singleWhere(
                  (person1) => person1.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
            //  onChanged: (value) => setState(() => selectedPerson = value),
            //  onSaved: (value) => setState(() => selectedPerson = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),
            SimpleAutocompleteFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Letter', border: OutlineInputBorder()),
              // suggestionsHeight: 200.0,
              maxSuggestions: 10,
              itemBuilder: (context, item) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(item),
                  ),
              onSearch: (String search) async => search.isEmpty
                  ? letters
                  : letters
                      .where((letter) => search.toLowerCase().contains(letter))
                      .toList(),
              itemFromString: (string) => letters.singleWhere(
                  (letter) => letter == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedLetter = value),
              onSaved: (value) => setState(() => selectedLetter = value),
              validator: (letter) => letter == null ? 'Invalid letter.' : null,
            ),
            SizedBox(height: 16.0),
            RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    scaffoldKey.currentState
                        .showSnackBar(SnackBar(content: Text('Fields valid!')));
                  } else {
                    scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text('Fix errors to continue.')));
                    setState(() => autovalidate = true);
                  }
                })
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


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}