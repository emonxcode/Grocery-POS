import 'package:flutter/material.dart';
import 'package:grocery_pos/views/desktop/sales_screen/widgets/sale_view.dart';
import 'package:grocery_pos/views/desktop/sales_screen/widgets/store_view.dart';

class StoreAndSales extends StatefulWidget {
  const StoreAndSales({super.key});

  @override
  State<StoreAndSales> createState() => _StoreAndSalesState();
}

class _StoreAndSalesState extends State<StoreAndSales> {
   var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
                flex: 14,
                child: Row(
                  children: [
                    StoreView(searchController: searchController),
                    SaleView()
                  ],
                ),
              );
  }
}
