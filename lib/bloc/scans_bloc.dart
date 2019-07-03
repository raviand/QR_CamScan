


import 'dart:async';

import 'package:qrreaderapp/bloc/validator.dart';
import 'package:qrreaderapp/providers/db_provider.dart';

class ScansBloc with Validators {

  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    getScans();
  }

  final _scansStreamController = StreamController<List<ScanResponse>>.broadcast();

  Stream<List<ScanResponse>> get scanStream => _scansStreamController.stream.transform(validarGeo);
  Stream<List<ScanResponse>> get scanStreamHttp => _scansStreamController.stream.transform(validarHttp);

  dispose(){
    _scansStreamController?.close();
  }

  addScan(ScanResponse scan) async {
    await DBProvider.db.nuevoScan(scan);
    getScans();
  }

  getScans() async {
    _scansStreamController.sink.add( await DBProvider.db.getScans() );
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScan();
    _scansStreamController.sink.add([]);
  }
  //xubio
}