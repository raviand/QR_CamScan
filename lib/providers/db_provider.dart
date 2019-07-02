import 'dart:io';

import 'package:path/path.dart';
import 'package:qrreaderapp/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



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

    final path = join( documentDirectory.path, 'scansDB.db' );

    final createDatabase = ' CREATE TABLE scan ('
    ' id Integer prumary key,  '
    ' tipo TEXT '
    ' valor TEXT  )';

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version ) async {
        await db.execute(createDatabase);
      }
    );
  }

  // Crear registro de datos
  nuevoScanRaw(ScanResponse nuevoScan) async {

    final db = await database;

    final res = await db.rawInsert("insert into scan ( id, tipo, valor ) values ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' )");

    return res;
  }

  nuevoScan(ScanResponse nuevoScan) async {
    final db = await database;

    final res = await db.insert('scan', nuevoScan.toJson());

    return res;
  }

  // select - Obtener Informacion
  Future<ScanResponse> getScanId(int id) async {
    final db = await database;
    final res = await db.query('scan', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanResponse.fromJson(res.first) : null;

  }

  Future<List<ScanResponse>> getScans(int id) async {
    final db = await database;
    final res = await db.query('scan');
    List<ScanResponse> resultados = res.isNotEmpty ? res.map( (scan) => ScanResponse.fromJson(scan) ).toList() : [];
    return resultados;

  }

  Future<List<ScanResponse>> getScansbyType(String type) async {
    final db = await database;
    final res = await db.query('scan', where: 'tipo = ?' , whereArgs: [type]);
    List<ScanResponse> resultados = res.isNotEmpty ? res.map( (scan) => ScanResponse.fromJson(scan) ).toList() : [];
    return resultados;
  }


}