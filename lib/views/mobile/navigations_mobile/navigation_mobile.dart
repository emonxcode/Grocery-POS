import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_pos/controller/productController.dart';
import 'package:grocery_pos/views/mobile/reports/reports_screen.dart';
import 'package:grocery_pos/views/mobile/sales/sales_screen_mobile.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../services/invoice_service.dart';
import '../stock/stock_view_mobile.dart';
import '../store/store_view_mobile.dart';

class NavigationsMobile extends StatefulWidget {
  const NavigationsMobile({super.key});

  @override
  State<NavigationsMobile> createState() => _NavigationsMobileState();
}

class _NavigationsMobileState extends State<NavigationsMobile>
    with SingleTickerProviderStateMixin {
  String dropdownvalue = 'Cash';

  var items = [
    'Cash',
    'Bkash',
    'Rocket',
    'Debit/Credit card',
  ];

  var searchController = TextEditingController();

  List<Product> _products = [];
  List<Product> _tmpProducts = [];

  final PdfInvoiceService service = PdfInvoiceService();
  int number = 0;
  String? window = "store";
  


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
    child: Container(
      height: mediaQuery.height,
      width: mediaQuery.width,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Color.fromARGB(255, 33, 33, 33),
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        setState(() {
                          window = "store";
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/sale.svg',
                              color: window == "store"
                                  ? Colors.white
                                  : Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          //Image.asset('assets/images/oil.png', width: 50, height: 50,),
                          SizedBox(height: 6),
                          Text(
                            "STORE",
                            style: TextStyle(
                                color: window == "store"
                                    ? Colors.white
                                    : Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                    InkWell(
                      onTap: () {
                        setState(() {
                          window = "sale";
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/cart.svg',
                              color: window == "sale"
                                  ? Colors.white
                                  : Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 6),
                          Text(
                            "SALE",
                            style: TextStyle(
                                color: window == "sale"
                                    ? Colors.white
                                    : Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                    InkWell(
                      onTap: () {
                        setState(() {
                          window = "stock";
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/stock.svg',
                              color: window == "stock"
                                  ? Colors.white
                                  : Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 6),
                          Text(
                            "STOCK",
                            style: TextStyle(
                                color: window == "stock"
                                    ? Colors.white
                                    : Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                    InkWell(
                      onTap: () {
                        setState(() {
                          window = "report";
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/report.svg',
                              color: window == "report"
                                  ? Colors.white
                                  : Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 6),
                          Text(
                            "REPORT",
                            style: TextStyle(
                                color: window == "report"
                                    ? Colors.white
                                    : Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 45),
                    InkWell(
                      onTap: () {
                        window = "settings";
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/settings.svg',
                              color: Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 6),
                          Text(
                            "SETTINGS",
                            style: TextStyle(
                                color: Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                    InkWell(
                      onTap: () {
                        window = "info";
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/info.svg',
                              color: Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 5),
                          Text(
                            "ABOUT",
                            style: TextStyle(
                                color: Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (window == "store")
            ProductsGridViewMobile(searchController: searchController)
          else if (window == "sale")
            OrdersListViewMobile()
          else if (window == "stock")
            StockViewMobile()
          else if(window == "report")
            Reports()
        ],
      ),
    ),
      ),
    );
  }
}
