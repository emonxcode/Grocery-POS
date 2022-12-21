import 'dart:io';
import 'package:grocery_pos/models/sale.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class SalesDatabaseHelper {
  static SalesDatabaseHelper? databaseHelper;
  static Database? _database;

  String saleTable = "sale_table";
  String saleId = "saleId";
  String saleProductList = "saleProductList";
  String salePTotalPrice = "salePTotalPrice";
  String saleNoOfitems = "saleNoOfitems";
  String saleDate = "saleDate";

  SalesDatabaseHelper.createInstance();

  factory SalesDatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = SalesDatabaseHelper.createInstance();
    }
    return databaseHelper!;
  }

  void createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $saleTable($saleId INTEGER PRIMARY KEY AUTOINCREMENT, $saleProductList TEXT, $salePTotalPrice INTEGER, $saleNoOfitems INTEGER, $saleDate TEXT)');
  }

  Future<Database> initializeDatabase() async {
    Directory? directory = await getExternalStorageDirectory();
    String path = directory!.path + "sales.db";

    var saleDatabase = await openDatabase(path, version: 1, onCreate: createDB);
    return saleDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  // Fetch notes
  Future<List<Map<String, dynamic>>> _getSalesMapList() async {
    Database db = await this.database;

    var result = db.query(saleTable);
    return result;
  }

  Future<List<Sale>> getSalesList() async {
    var getSaleMapList = await _getSalesMapList();
    List<Sale> sales = [];
    int count = getSaleMapList.length;

    for (int i = 0; i < count; i++) {
      sales.add(Sale.fromMap(getSaleMapList[i]));
    }

    return sales;
  }


  // add Sales
  Future<int> addSale(Sale newSale) async {
    Database db = await this.database;
 

    var result = db.insert(saleTable, newSale.toMap());
    return result;
  }

  // Update Sale
  // Future<int> updateSale(Sale sale) async {
  //   Database db = await this.database;

  //   var result = db.update(saleTable, sale.toMap(),
  //       where: '$saleId = ?', whereArgs: [sale.saleId]);
  //   return result;
  // }

  // Delete sale
  // Future<int> removeSale(int id) async {
  //   Database db = await this.database;
  //   var result = db.delete(saleTable, where: '$saleId = $id');
  //   return result;
  // }
}
