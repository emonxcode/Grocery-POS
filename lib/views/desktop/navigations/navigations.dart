import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_pos/controller/productController.dart';
import 'package:grocery_pos/views/desktop/navigations/widgets/components.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../services/invoice_service.dart';
import '../report/report_view.dart';
import '../sales_screen/store_sales.dart';
import '../stock/stock_view.dart';

class NavigationsDesktop extends StatefulWidget {
  const NavigationsDesktop({super.key});

  @override
  State<NavigationsDesktop> createState() => _NavigationsDesktopState();
}

class _NavigationsDesktopState extends State<NavigationsDesktop> {
  String dropdownvalue = 'Cash';

  var items = [
    'Cash',
    'Bkash',
    'Rocket',
    'Debit/Credit card',
  ];

  List<Product> _products = [];
  List<Product> _tmpProducts = [];

  bool _isLoaded = true;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoaded = false;
      });
      Provider.of<ProductController>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoaded = true;
        });
      });
    }
    _isInit = false;
  }

  String? window = "sales_store";

  @override
  Widget build(BuildContext context) {
    print("--------------  Web versin loaded --------------");
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Color.fromARGB(255, 33, 33, 33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        setState(() {
                          window = "sales_store";
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/cart.svg',
                              color: window == "sales_store"
                                  ? Colors.white
                                  : Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 6),
                          Text(
                            "STORE",
                            style: TextStyle(
                                color: window == "sales_store"
                                    ? Colors.white
                                    : Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
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
                    SizedBox(height: 60),
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
                    SizedBox(height: 60),
                    InkWell(
                      onTap: () {
                        setState(() {
                          window = "settings";
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/settings.svg',
                              color: window == "settings"
                                  ? Colors.white
                                  : Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 6),
                          Text(
                            "SETTINGS",
                            style: TextStyle(
                                color: window == "settings"
                                    ? Colors.white
                                    : Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          window = "info";
                        });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/info.svg',
                              color: window == "info"
                                  ? Colors.white
                                  : Color.fromARGB(255, 133, 133, 133),
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain),
                          SizedBox(height: 6),
                          Text(
                            "INFO",
                            style: TextStyle(
                                color: window == "info"
                                    ? Colors.white
                                    : Color.fromARGB(255, 133, 133, 133),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            if (window == "sales_store")
              StoreAndSales()
            else if (window == "stock")
              StockView()
            else if (window == "report")
              ReportView()
            // else if (window == "settings")
          ],
        ),
      ),
    );
  }
}
