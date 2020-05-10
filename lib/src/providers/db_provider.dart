import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import 'package:qr_scanner/src/models/scan_model.dart';
export 'package:qr_scanner/src/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
  // DBProvider();

  Future<Database> get getDatabase async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    // Directory directory = await getApplicationDocumentsDirectory();
    final path = join(databasesPath, 'ScanDB');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scan('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')');
    });
  }

  Future<int> crear(ScanModel model) async {
    final db = await getDatabase;
    final res = await db.insert('Scan', model.toJson());
    return res;
  }

  Future<ScanModel> leer(int id) async {
    final db = await getDatabase;
    final res = await db.query('Scan', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<int> actualizar(ScanModel model) async {
    final db = await getDatabase;
    final res = await db
        .update('Scan', model.toJson(), where: 'id = ?', whereArgs: [model.id]);
    return res;
  }

  Future<int> eliminar(int id) async {
    final db = await getDatabase;
    final res = await db.delete('Scan', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> eliminarRegistros() async {
    final db = await getDatabase;
    final res = await db.delete('Scan');
    return res;
  }

  Future<List<ScanModel>> listar() async {
    final db = await getDatabase;
    final res = await db.query('Scan');
    List<ScanModel> scans = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
    return scans;
  }
}
