import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';

class DatabaseHelper {
  static DatabaseHelper? databaseHelper;
  static Database? _database;

  String productTable = "product_table";
  String pId = "pId";
  String pName = "pName";
  String pDesc = "pDesc";
  String pImgUrl = "pImgUrl";
  String pSalePrice = "pSalePrice";
  String pBuyingPrice = "pBuyingPrice";
  String pQuantity = "pQuantity";
  String pBrand = "pBrand";
  String pSupplier = "pSupplier";

  DatabaseHelper.createInstance();

  factory DatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseHelper.createInstance();
    }
    return databaseHelper!;
  }

  void createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $productTable($pId INTEGER PRIMARY KEY AUTOINCREMENT, $pName TEXT, $pDesc TEXT, $pImgUrl TEXT, $pSalePrice INTEGER, $pBuyingPrice INTEGER, $pQuantity INTEGER, $pBrand TEXT, $pSupplier TEXT)');
  }

  Future<Database> initializeDatabase() async {
    Directory? directory = await getExternalStorageDirectory();
    String path = directory!.path + "products.db";

    var productDatabase = await openDatabase(path, version: 1, onCreate: createDB);
    return productDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  // Fetch notes
  Future<List<Map<String, dynamic>>> _getProductMapList() async {
    Database db = await this.database;

    var result = db.query(productTable);
    return result;
  }

  Future<List<Product>> getProductList() async {
    var getProductMapList = await _getProductMapList();
    List<Product> products = [];
    int count = getProductMapList.length;

    for (int i = 0; i<count; i++) {
      products.add(Product.fromMap(getProductMapList[i]));
    }

    return products;
  }

  // add product
  Future<int> addProduct(Product product) async {
    Database db = await this.database;
    
    var result = db.insert(productTable, product.toMap());
    return result;
  }

  // Update product
   updateProduct(Product product) async {
   Database db = await this.database;

    var result = db.update(productTable, product.toMap(),
        where: '$pName = ?', whereArgs: [product.pName]);
  }


  // Delete product
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = db.delete(productTable, where: '$pId = $id');
    return result;
  }

}