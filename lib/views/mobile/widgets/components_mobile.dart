import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_pos/controller/productController.dart';
import 'package:grocery_pos/models/product.dart';
import 'package:provider/provider.dart';

Widget vSearchFieldMobile(String hintTxt, TextEditingController controller) {
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

Widget vProductCardListMobile(Product product, BuildContext ctx) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Card(
      color: Color.fromARGB(255, 240, 240, 253),
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.pName!.length > 17
                      ? "${product.pName!.substring(0, 17)}..."
                      : product.pName!,
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

class ProductCardGridMobile extends StatefulWidget {
  Product? product;
  ProductCardGridMobile({super.key, this.product});

  @override
  State<ProductCardGridMobile> createState() => _ProductCardGridMobileState();
}

class _ProductCardGridMobileState extends State<ProductCardGridMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (!isSelected) {
            isSelected = true;
            Provider.of<ProductController>(context, listen: false)
                .addTmpProduct(widget.product!);
          } else {
            isSelected = false;
            Provider.of<ProductController>(context, listen: false)
                .removeSingleProductTemp(widget.product!.pName!);
          }
        });
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Card(
          color: !isSelected
              ? Color.fromRGBO(255, 255, 255, 1)
              : Color.fromARGB(255, 219, 212, 255),
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
                      child: Image.file(File(widget.product!.pImgUrl!),
                          fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    child: Icon(
                        isSelected ? Icons.done_rounded : Icons.add_circle),
                    top: 5,
                    right: 5,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                    widget.product!.pName!.length > 21
                        ? "${widget.product!.pName!.substring(0, 18)}..."
                        : widget.product!.pName!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price: ${widget.product!.pSalePrice!.toString()}"),
                    Consumer<ProductController>(
                      builder: (context, value, child) {
                        var q = value.getQtyP(widget.product!.pName!);
                        return Text("Stock: ${q!.toString()}");
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
}
