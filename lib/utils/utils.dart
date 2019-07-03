import 'package:flutter/widgets.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';


launchURL(BuildContext context, ScanResponse scan ) async {

  if (scan.tipo == 'http'){
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  }else{
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }

  
}