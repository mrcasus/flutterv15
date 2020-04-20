import 'package:flutter/material.dart';
import 'package:flutterappv14/screens/exportToExcel.dart';
import 'package:flutterappv14/screens/note_list.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 8,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset(
          'assets/loading.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
     loaderColor: Colors.red,
    );
  }
}

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  
  int  _selectedPage = 0;
 final _pageOptions = [
  // NoteDetail(appBarTitle: "sadasd",), // Burada herhangi bir değer vermediğiniz için hata veriyor.
   NoteList(),
   ExportToExcel(),
 ];
  
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      
      home: Scaffold(
       // appBar: AppBar(title: Text('sdfsfdds'),
      
        //),
        
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.amber,
          //selectedItemColor: Colors.black,
          //unselectedItemColor: Colors.green[800],
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),
              title: Text('home')
              ),
           /* BottomNavigationBarItem(icon: Icon(Icons.work),
              title: Text('work')
              ),*/
            BottomNavigationBarItem(icon: Icon(Icons.info),
              title: Text('Excel')
              ),
          ],
        ),
      //floatingActionButton: Visibility(
       // visible: _selectedPage == 0,
        //child: FloatingActionButton.extended(
          //               shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(30),
                //             bottomRight:Radius.circular(30),
                  //            ),
            //             ),
              //           icon: Icon(Icons.save),
                //         label: Text('Kaydet'),
                  //       onPressed: () {},
                         //backgroundColor: randowColor,
                    //     ),
                      //   ),
                         ),
      );
   
  }
}


