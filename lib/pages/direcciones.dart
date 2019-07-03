import 'package:flutter/material.dart';
import 'package:qrreaderapp/bloc/scans_bloc.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:qrreaderapp/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scanBloc = ScansBloc();
  @override
  Widget build(BuildContext context) {
    scanBloc.getScans();
    return StreamBuilder(
      stream: scanBloc.scanStreamHttp,
      builder:
          (BuildContext context, AsyncSnapshot<List<ScanResponse>> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        final scans = snapshot.data;

        if (scans.length == 0)
          return Center(child: Text('No hay informacion para mostrar'));

        return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) => Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.redAccent,),
                  onDismissed: (direccion) => scanBloc.deleteScan(scans[i].id),
                  child: ListTile(
                    leading: Icon(
                      Icons.cloud,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(scans[i].valor),
                    subtitle: Text('ID: ${scans[i].id}'),
                    trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                    onTap: () => utils.launchURL(context, scans[i]) 
                    ,
                  ),
                ));
      },
    );
  }
}
