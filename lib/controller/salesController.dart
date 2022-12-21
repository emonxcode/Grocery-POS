import 'package:flutter/cupertino.dart';
import 'package:grocery_pos/database/sales_database_helper.dart';

import '../models/sale.dart';

class SalesController {
  List<Sale> _sales = [];
  int? totalAmount;

  SalesDatabaseHelper db = SalesDatabaseHelper();

  getAllSeles() async {
    _sales = await db.getSalesList();
    
  }

  Future<int> addSales(Sale newSale) async {
    int result = await db.addSale(newSale);

    print(newSale);
    return result;
  }

  Future<int> getTotalSaleAmountToday() async {
    await getAllSeles();
    for (int i = 0; i < _sales.length; i++) {
      print("------");
      totalAmount = totalAmount! + _sales[i].saleTotalAmount!;
    }
    print(totalAmount);
    return totalAmount!;
  }

  getTotalProfitAmountToday() {}
}
