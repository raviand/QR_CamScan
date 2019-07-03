import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:qrreaderapp/models/scan_model.dart';

class MapaPage extends StatefulWidget {


  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final MapController mapController = MapController();
  String tipoMapa = 'streets';
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
                 //setState(() {
                   
                   mapController.move(scan.getLatLng(), 100);
                 //});
               },
             )
           ],
         ),
         body: _crearFlutterMap(scan, mapController),
         //floatingActionButton: _crearBotonFlotante(context)
       ),
    );
  }

  Widget _crearFlutterMap(ScanResponse scan, MapController mapController) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        
        center: scan.getLatLng(),
        zoom: 10
        
      ),
      layers: [
        _crearMapa(),
        _marcadores(scan),
      ],
    );
  }

  LayerOptions _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'id' : 'mapbox.street', //street - dark - light - satellite
        'accessToken': 'pk.eyJ1IjoicmF2aWFuZCIsImEiOiJjanhuNWxreWIwN3BrM2NwOWI2OXlibGl2In0.hmGdK2yfNb6myfJC35rkrA'
      }
    );
  }

  _marcadores(ScanResponse scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0, 
          height: 100.0, 
          point: scan.getLatLng(), 
          builder: ( context ) => Container(child: Icon(Icons.location_on, size: 45.0, color: Theme.of(context).primaryColor,),)
        )
      ]
    );
  }

  // Widget _crearBotonFlotante(BuildContext context){
  //   return FloatingActionButton(
  //     child: Icon(Icons.repeat, color: Theme.of(context).primaryColor),
  //     onPressed: (){
  //       //street - dark - light - satellite
        
          
  //         switch(tipoMapa){
  //           case 'street':
  //             tipoMapa = 'dark';
  //             break;
  //           case 'dark':
  //             tipoMapa = 'light';
  //             break;
  //           case 'light':
  //             tipoMapa = 'outdoors';
  //             break;
  //           case 'outdoors':
  //             tipoMapa = 'satellite';
  //             break;
  //           case 'satellite':
  //             tipoMapa = 'street';
  //             break;
  //           default:
  //             tipoMapa = 'street';
  //         }
          
  //       setState(() {});
  //     },
  //   );
  // }
}