import 'dart:io';

import 'package:path/path.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
export 'package:qrreaderapp/models/scan_model.dart';


class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if(_database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentDirectory.path, 'scannerDB.db' );


    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
      }
    );
  }

  // Crear registro de datos
  nuevoScanRaw(ScanResponse nuevoScan) async {
    final db = await database;
    final res = await db.rawInsert("insert into Scans ( id, tipo, valor ) values ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' )");
    return res;
  }

  nuevoScan(ScanResponse nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  // select - Obtener Informacion
  Future<ScanResponse> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanResponse.fromJson(res.first) : null;
  }

  Future<List<ScanResponse>> getScans() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanResponse> resultados = res.isNotEmpty ? res.map( (scan) => ScanResponse.fromJson(scan) ).toList() : [];
    return resultados;
  }

  Future<List<ScanResponse>> getScansbyType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?' , whereArgs: [type]);
    List<ScanResponse> resultados = res.isNotEmpty ? res.map( (scan) => ScanResponse.fromJson(scan) ).toList() : [];
    return resultados;
  }

  // select - Obtener Informacion
  Future<int> updateScan(ScanResponse nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson() , where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans',  where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }


}