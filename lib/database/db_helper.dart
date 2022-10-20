//dbhelper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete
        
        
import 'package:flutter_crud_uts_lagi/model/orderan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
        
class DbHelper {
    static final DbHelper _instance = DbHelper._internal();
    static Database? _database;
        
    //inisialisasi beberapa variabel yang dibutuhkan
    final String tableName = 'tableOrderan';
    final String columnId = 'id';
    final String columnNama = 'nama';
    final String columnJenis = 'jenis';
    final String columnBerat = 'berat';
    final String columnPembayaran = 'pembayaran';
    final String columnTanggalAmbil = 'tanggalambil';
        
    DbHelper._internal();
    factory DbHelper() => _instance;
        
    //cek apakah database ada
    Future<Database?> get _db  async {
        if (_database != null) {
            return _database;
        }
        _database = await _initDb();
        return _database;
    }
        
    Future<Database?> _initDb() async {
        String databasePath = await getDatabasesPath();
        String path = join(databasePath, 'orderan.db');
        
        return await openDatabase(path, version: 1, onCreate: _onCreate);
    }
        
    //membuat tabel dan field-fieldnya
    Future<void> _onCreate(Database db, int version) async {
        var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
            "$columnNama TEXT,"
            "$columnJenis TEXT,"
            "$columnBerat TEXT,"
            "$columnPembayaran TEXT,"
            "$columnTanggalAmbil TEXT)";
             await db.execute(sql);
    }
        
    //insert ke database
    Future<int?> saveOrderan(Orderan orderan) async {
        var dbClient = await _db;
        return await dbClient!.insert(tableName, orderan.toMap());
    }
        
    //read database
    Future<List?> getAllOrderan() async {
        var dbClient = await _db;
        var result = await dbClient!.query(tableName, columns: [
            columnId,
            columnNama,
            columnJenis,
            columnBerat,
            columnPembayaran,
            columnTanggalAmbil
        ]);
        
        return result.toList();
    }
        
    //update database
    Future<int?> updateOrderan(Orderan orderan) async {
        var dbClient = await _db;
        return await dbClient!.update(tableName, orderan.toMap(), where: '$columnId = ?', whereArgs: [orderan.id]);
    }
        
    //hapus database
    Future<int?> deleteOrderan(int id) async {
        var dbClient = await _db;
        return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
    }
}