import 'package:flutter/material.dart';
import 'package:grocery_pos/database/product_database_helper.dart';

import '../models/product.dart';

class ProductController with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _tmpProducts = [];
  DatabaseHelper db = DatabaseHelper();

  Future<List<Product>> fetchAndSetProducts() async {
    try {
      var extractedData = await db.getProductList();
      List<Product> loadedData = [];
      extractedData.forEach((product) {
        loadedData.add(
          Product(
            pName: product.pName,
            pDesc: product.pDesc,
            pBrand: product.pBrand,
            pBuyingPrice: product.pBuyingPrice,
            pSalePrice: product.pSalePrice,
            pQuantity: product.pQuantity,
            pImgUrl: product.pImgUrl,
            pSupplier: product.pSupplier,
          ),
        );
      });
      _products = loadedData;
      notifyListeners();
    } catch (e) {
      throw e;
    }
    return _products;
  }

  List<Product> getProducts() {
    return _products;
  }

  List<Product> getTmpProducts() {
    return _tmpProducts;
  }

// add a new product
  Future<int> addProduct(Product product) async {
    int result;
    try {
      result = await db.addProduct(product);
      this._products.add(product);
      notifyListeners();
      return result;
    } catch (e) {
      throw e;
    }
  }

// remove a product
  void removeProduct(String pName) {
    this._products.removeWhere((element) => element.pName == pName);
  }

// add a new temporary product
  void addTmpProduct(Product product) {
    Product p = Product(
        pName: product.pName,
        pSalePrice: product.pSalePrice,
        pDesc: product.pDesc,
        pBuyingPrice: product.pBuyingPrice,
        pImgUrl: product.pImgUrl,
        pQuantity: 0);
    _tmpProducts.add(p);
    notifyListeners();
  }

// increase quantity of a single product from temporary list
  void addQtyTmp(String pName) {
    int? q = this
        ._tmpProducts
        .firstWhere((element) => element.pName == pName)
        .pQuantity;
    q = q! + 1;
    this
        ._tmpProducts
        .firstWhere((element) => element.pName == pName)
        .pQuantity = q;
    notifyListeners();
  }

  // decrease quantity of a single product from temporary list
  void minusQtyTmp(String pName) {
    int? q = this
        ._tmpProducts
        .firstWhere((element) => element.pName == pName)
        .pQuantity;
    q = q! - 1;
    this
        ._tmpProducts
        .firstWhere((element) => element.pName == pName)
        .pQuantity = q;
    notifyListeners();
  }

// increase quantity of a single product from products list
  void addQtyP(Product p) async {
    int? q = this
        ._products
        .firstWhere((element) => element.pName == p.pName)
        .pQuantity;
    q = q! + 1;
    this._products.firstWhere((element) => element.pName == p.pName).pQuantity =
        q;
    await db.updateProduct(
        _products.firstWhere((element) => element.pName == p.pName));
    notifyListeners();
  }

// add more quantity with others
  void addMoreQtyP(int Q, Product p) async {
    int? q = this
        ._products
        .firstWhere((element) => element.pName == p.pName)
        .pQuantity;
    q = q! + Q;
    this._products.firstWhere((element) => element.pName == p.pName).pQuantity =
        q;
    await db.updateProduct(
        _products.firstWhere((element) => element.pName == p.pName));
    notifyListeners();
  }

// decrease quantity of a single product from products list
  void minusQtyP(Product p) async {
    try {
      int? q = this
          ._products
          .firstWhere((element) => element.pName == p.pName)
          .pQuantity;
      q = q! - 1;
      this
          ._products
          .firstWhere((element) => element.pName == p.pName)
          .pQuantity = q;
      await db.updateProduct(
          _products.firstWhere((element) => element.pName == p.pName));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  // get quantity of a single product from products list
  int? getQtyP(String pName) {
    int? q = this
        ._products
        .firstWhere((element) => element.pName == pName)
        .pQuantity;
    return q!;
  }

  // get quantity of a single product from temporary list
  int? getQtyTmp(String pName) {
    int? q = this
        ._tmpProducts
        .firstWhere((element) => element.pName == pName)
        .pQuantity;
    return q!;
  }

  // get total amount from temporary list
  int? getTotalAmount() {
    int totalAmount = 0;
    for (int i = 0; i < _tmpProducts.length; i++) {
      for (int j = 1; j <= _tmpProducts[i].pQuantity!; j++) {
        // this loop is for count quntity amount
        totalAmount = totalAmount + _tmpProducts[i].pSalePrice!;
      }
    }
    return totalAmount;
  }

  // empty temporary list
  void emptyTmpProducts() {
    this._tmpProducts = [];
    notifyListeners();
  }

  // remove single product from temporary list
  void removeSingleProductTemp(String pName) {
    this._tmpProducts.removeWhere((element) => element.pName == pName);
    notifyListeners();
  }
}
