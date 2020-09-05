import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tvyamel/modelos/sucursal.dart';
export 'package:tvyamel/modelos/sucursal.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory dd = await getApplicationDocumentsDirectory();
    final path = join(dd.path, 'yamel.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE sucursales('
          'id STRING,'
          'nombre STRING,'
          'subtitulo STRING,'
          'lat REAL,'
          'lng REAL'
          ')');
    });
  }

  agregarSucursal(Sucursal nuevo) async {
    final db = await database;
    final resp = db.insert('sucursales', nuevo.toJson());
    return resp;
  }

  Future<Sucursal> getSucursalId(String id) async {
    final db = await database;
    final resp =
        await db.query('sucursales', where: 'id = ? ', whereArgs: [id]);
    return resp.isNotEmpty ? Sucursal.fromJson(resp.first) : null;
  }

  Future<List<Sucursal>> getSucursales() async {
    final db = await database;
    final resp = await db.query('sucursales');
    List<Sucursal> lista =
        resp.isNotEmpty ? resp.map((s) => Sucursal.fromJson(s)).toList() : [];
    return lista;
  }

  Future<int> actSucursal(Sucursal suc) async {
    final db = await database;
    final resp = await db
        .update('sucursales', suc.toJson(), where: 'id=?', whereArgs: [suc.id]);
    return resp;
  }

  Future<int> borrarSucursal(String id) async {
    final db = await database;
    final resp = await db.delete('sucursales', where: 'id=?', whereArgs: [id]);
    return resp;
  }

  Future<int> borrarSucursales() async {
    final db = await database;
    final resp = await db.delete('sucursales');
    return resp;
  }
}
