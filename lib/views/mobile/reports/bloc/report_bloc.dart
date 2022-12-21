import 'dart:async';

import 'package:grocery_pos/database/product_database_helper.dart';
import 'package:grocery_pos/database/sales_database_helper.dart';
import 'package:grocery_pos/models/sale.dart';

class ReportBloc{
  SalesDatabaseHelper _salesDatabaseHelper = SalesDatabaseHelper();
  List<Sale> salesList = [];
  var salesController = StreamController<List<Sale>>();
  Stream<List<Sale>> get salesStream => salesController.stream;
  StreamSink<List<Sale>> get salesSink => salesController.sink;

 
 int totalAmount = 0;
   var totalSalesController = StreamController<int>();
  Stream<int> get totalSalesStream => totalSalesController.stream;
  StreamSink<int> get totalSalesSink => totalSalesController.sink;

 Future<void> fetchSalesList() async {
   salesList = await  _salesDatabaseHelper.getSalesList();
   salesSink.add(salesList);
   salesList.forEach((element) {
    totalAmount += element.saleTotalAmount!;
   });
   totalSalesSink.add(totalAmount);
  }
  
}