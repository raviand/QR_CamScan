import 'dart:async';

import 'package:qrreaderapp/providers/db_provider.dart';

class Validators{

  final validarGeo = StreamTransformer<List<ScanResponse>,List<ScanResponse>>.fromHandlers(
    handleData: (List<ScanResponse> scans, sink ){
      final geoScan = scans.where( (s) => s.tipo == 'geo').toList();
      sink.add(geoScan);
    }
  );

  final validarHttp = StreamTransformer<List<ScanResponse>,List<ScanResponse>>.fromHandlers(
    handleData: (List<ScanResponse> scans, sink ){
      final httpScan = scans.where( (s) => s.tipo == 'http').toList();
      sink.add(httpScan);
    }
  );

}