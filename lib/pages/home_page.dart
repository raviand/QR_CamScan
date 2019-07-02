import 'package:flutter/material.dart';
import 'package:qrreaderapp/pages/direcciones.dart';
import 'package:qrreaderapp/pages/mapas_page.dart';
import 'package:qrcode_reader/qrcode_reader.dart';



class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scarQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scarQR() async {
    //https://www.infobae.com/
    //geo:-34.550219825632145,-58.490196189657502
    String futureString = 'https://www.infobae.com/';
    //String futureString = 'geo:-34.550219825632145,-58.490196189657502';

  //   try{
  //     futureString = await QRCodeReader().scan();
  //   }catch(e){
  //     futureString = e.toString();
  //   }
  //   print('FutureString: $futureString');
  //   if(futureString == null){
  //     print('future String Null');
  //   }

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