import 'package:flutter/material.dart';
import 'package:grocery_pos/views/invoice_view/print_invoice.dart';

import '../../../models/product.dart';
import '../widgets/components_mobile.dart';
import 'package:grocery_pos/controller/productController.dart';
import 'package:provider/provider.dart';
import '../../../services/invoice_service.dart';

class OrdersListViewMobile extends StatefulWidget {
  OrdersListViewMobile({super.key});

  @override
  State<OrdersListViewMobile> createState() => _OrdersListViewMobileState();
}

class _OrdersListViewMobileState extends State<OrdersListViewMobile> {
  String dropdownvalue = 'Cash';

  var items = [
    'Cash',
    'Bkash',
    'Rocket',
    'Debit/Credit card',
  ];

  var searchController = TextEditingController();
  List<Product> _tmpProducts = [];
  //  _tmpProducts = _salesController.getTmpProducts;

  final PdfInvoiceService service = PdfInvoiceService();
  int number = 0;

  bool c = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (c) {
      _tmpProducts = Provider.of<SalesController>(context).getTmpProducts();
      c = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 11,
      child: Container(
        padding: EdgeInsets.all(7),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5),
              width: double.infinity,
              height: 60,
              //color: Color.fromARGB(255, 230, 230, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CUSTOMER ORDERS",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    "Place products to customer",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2),
            Expanded(
              flex: 18,
              child: ListView.builder(
                itemCount: _tmpProducts.length,
                itemBuilder: ((context, index) {
                  return vProductCardListMobile(_tmpProducts[index], context);
                }),
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              padding: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 206, 218, 255),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<SalesController>(
                    builder: (context, value, child) {
                      return Text(
                        "TOTAL AMOUNT : ${value.getTotalAmount()!.toString()} TK",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     //Text("PAYMENT:   "),
                  //     // DropdownButton(
                  //     //   value: dropdownvalue,
                  //     //   icon: Icon(Icons.keyboard_arrow_down),
                  //     //   items: items.map((String items) {
                  //     //     return DropdownMenuItem(
                  //     //       value: items,
                  //     //       child: Text(items),
                  //     //     );
                  //     //   }).toList(),
                  //     //   onChanged: (String? newValue) {
                  //     //     setState(() {
                  //     //       dropdownvalue = newValue!;
                  //     //     });
                  //     //   },
                  //     // ),
                  //   ],
                  // ),

                  TextButton(
                    onPressed: () async {
                      final data = await service.createInvoice(
                        _tmpProducts,
                        Provider.of<SalesController>(context, listen: false)
                            .getTotalAmount()!,
                        context,
                      );
                      service.savePdfFile("invoice_$number", data, context);
                      number++;

                      setState(() {
                        Provider.of<SalesController>(context, listen: false)
                            .emptyTmpProducts();
                        _tmpProducts = [];
                      });
                    },
                    child: Text("Preview Invoice"),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Color.fromARGB(255, 232, 226, 255)),
                  ),

                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    PrintPage(products: _tmpProducts)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.print),
                          SizedBox(width: 5),
                          Text(
                            "Print Invoice",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
