import 'package:flutter/material.dart';
import 'package:grocery_pos/controller/productController.dart';
import 'package:grocery_pos/models/product.dart';
import 'package:provider/provider.dart';

Widget vSearchField(String hintTxt, TextEditingController controller) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintTxt,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  );
}

Widget vProductCardList(Product product, BuildContext ctx) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Card(
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.pName!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text("Price : ${product.pSalePrice!.toString()} TK"),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<ProductController>(
                  builder: (ctx, value, child) {
                    var q = value.getQtyTmp(product.pName!);
                    return Text(
                      "${q!.toString()} item/s",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    );
                  },
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<ProductController>(ctx, listen: false)
                              .minusQtyTmp(product.pName!);
                          Provider.of<ProductController>(ctx, listen: false)
                              .addQtyP(product);
                        },
                        icon: Icon(Icons.remove_circle_outline_rounded)),
                    SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          Provider.of<ProductController>(ctx, listen: false)
                              .addQtyTmp(product.pName!);
                          Provider.of<ProductController>(ctx, listen: false)
                              .minusQtyP(product);
                        },
                        icon: Icon(Icons.add_circle_outline_rounded)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget vProductCardGrid(Product product, BuildContext ctx) {
  return InkWell(
    onTap: () {
      Provider.of<ProductController>(ctx, listen: false).addTmpProduct(product);
      // Provider.of<SalesController>(ctx, listen: false)
      //     .minusQtyP(product.pName!);
    },
    child: Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Card(
        color: Color.fromRGBO(255, 255, 255, 1),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 200,
                  height: 95,
                  child: ClipRRect(
                    child: Image.asset(product.pImgUrl!, fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  child: Icon(Icons.add_circle),
                  top: 5,
                  right: 5,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                  product.pName!.length > 21
                      ? "${product.pName!.substring(0, 18)}..."
                      : product.pName!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price: ${product.pSalePrice!.toString()}"),
                  Consumer<ProductController>(
                    builder: (context, value, child) {
                      // var q = value.getQtyP(product.pName!);
                      return Text("Stock: ${product.pQuantity!.toString()}");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
