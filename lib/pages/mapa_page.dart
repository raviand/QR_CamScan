import 'package:flutter/material.dart';
import 'package:qrreaderapp/models/scan_model.dart';

class MapaPage extends StatefulWidget {


  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {


  @override
  Widget build(BuildContext context) {
    final ScanResponse scan = ModalRoute.of(context).settings.arguments;

    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('Coordenadas QR'),
           actions: <Widget>[
             IconButton(
               icon: Icon(Icons.my_location),
               onPressed: (){
                 
               },
             )
           ],
         ),
         body: Center(
           child: Text('Mapas Page'),
         ),
       ),
    );
  }
}