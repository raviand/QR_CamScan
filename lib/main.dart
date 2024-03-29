import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:qrreaderapp/pages/home_page.dart';
import 'package:qrreaderapp/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'mapa' : (BuildContext context) => MapaPage()
      }, 
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 10.0, highlightElevation: 10.0)
      ),
    );
  }
}