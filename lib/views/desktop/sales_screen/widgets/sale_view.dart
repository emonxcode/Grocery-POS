import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/productController.dart';
import '../../../../models/product.dart';
import '../../../../services/invoice_service.dart';
import '../../navigations/widgets/components.dart';

class SaleView extends StatefulWidget {
  const SaleView({super.key});

  @override
  State<SaleView> createState() => _SaleViewState();
}

class _SaleViewState extends State<SaleView> {
  List<Product> _tmpProducts = [];

  final PdfInvoiceService service = PdfInvoiceService();
  int number = 0;

  @override
  Widget build(BuildContext context) {
    _tmpProducts = Provider.of<ProductController>(context).getTmpProducts();

    return Expanded(
      flex: 4,
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5),
              width: double.infinity,
              height: 60,
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
            SizedBox(height: 10),
            Expanded(
              flex: 18,
              child: ListView.builder(
                itemCount: _tmpProducts.length,
                itemBuilder: ((context, index) {
                  return vProductCardList(_tmpProducts[index], context);
                }),
              ),
            ),
            Spacer(),
            Container(
              height: 120,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<ProductController>(
                    builder: (context, value, child) {
                      return Text(
                        "TOTAL AMOUNT : ${value.getTotalAmount()!.toString()} TK",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("PAYMENT:   "),
                  //     DropdownButton(
                  //       value: dropdownvalue,
                  //       icon: Icon(Icons.keyboard_arrow_down),
                  //       items: items.map((String items) {
                  //         return DropdownMenuItem(
                  //           value: items,
                  //           child: Text(items),
                  //         );
                  //       }).toList(),
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           dropdownvalue = newValue!;
                  //         });
                  //       },
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final data = await service.createInvoice(
                          _tmpProducts,
                          Provider.of<ProductController>(context, listen: false)
                              .getTotalAmount()!,
                          context,
                        );
                        service.savePdfFile("invoice_$number", data, context);
                        number++;
                      },
                      child: Text(
                        "PRINT RECEIPT",
                        style: TextStyle(fontSize: 20),
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
