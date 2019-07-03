import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/bloc/scans_bloc.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:qrreaderapp/pages/direcciones.dart';
import 'package:qrreaderapp/pages/mapas_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/utils/utils.dart' as utils;



class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final scansBloc = ScansBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans,
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    //https://www.infobae.com/
    //geo:-34.550219825632145,-58.490196189657502
    String futureString ;
    //String futureString = 'geo:-34.550219825632145,-58.490196189657502';

    try{
      futureString = await QRCodeReader().scan();
    }catch(e){
      futureString = e.toString();
    }
    print('FutureString: $futureString');
    if(futureString != null){
      ScanResponse nuevoScan = ScanResponse( valor: futureString );
      //nuevoScan.id = nuevoScan.hashCode;
      scansBloc.addScan(nuevoScan);

      Platform.isIOS 
        ? Future.delayed(Duration(milliseconds: 750), () => utils.launchURL(context, nuevoScan)) 
        : utils.launchURL(context, nuevoScan);



    }
    // if(futureString != null){
    //   ScanResponse nuevoScan = ScanResponse( valor: 'geo:-34.550219825632145,-58.490196189657502' );
    //   //nuevoScan.id = nuevoScan.hashCode;
    //   scansBloc.addScan(nuevoScan);

    // }

  }

  Widget _callPage( int paginaActual ){
    switch(paginaActual){
      case 0:return MapasPage();
      case 1:return DireccionesPage();
      default: return MapasPage();
    }
  }

  Widget _crearBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
         currentIndex = index; 
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Map')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ],
    );
  }
}