import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_pos/controller/productController.dart';
import 'package:grocery_pos/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../database/product_database_helper.dart';

class ModifyProduct extends StatefulWidget {
  ModifyProduct({
    super.key,
    this.title,
  });

  String? title;

  @override
  State<ModifyProduct> createState() => _ModifyProductState();
}

class _ModifyProductState extends State<ModifyProduct> {
  var pNameController = TextEditingController();
  var pBuyingPriceController = TextEditingController();
  var pSellingPriceController = TextEditingController();
  var pQuantityController = TextEditingController();
  var pBrandController = TextEditingController();
  var pSupplierController = TextEditingController();
  var pDescController = TextEditingController();

  ImagePicker? _picker = ImagePicker();
  XFile? _image;

  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 254),
      appBar: AppBar(
        title: Text(
          widget.title!,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 234, 234, 254),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        actions: [
          TextButton(
              onPressed: () async {
                Product newProduct = Product(
                    pName: pNameController.text,
                    pDesc: pDescController.text,
                    pBuyingPrice: int.parse(pBuyingPriceController.text),
                    pSalePrice: int.parse(pSellingPriceController.text),
                    pQuantity: int.parse(pQuantityController.text),
                    pImgUrl: _image != null ? _image!.path : null,
                    pBrand: pBrandController.text,
                    pSupplier: pSupplierController.text);
                int result;
                result =
                    await Provider.of<SalesController>(context, listen: false)
                        .addProduct(newProduct);
                print(result);
                if (result > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added Successfully!")));
                }

                //  .then((value) {
                //   return value > 0? showDialog(
                //       context: context,
                //       builder: (ctx) {
                //         return AlertDialog(
                //           title: Text("Succesfully product added :)"),
                //           actions: [
                //             TextButton(
                //                 onPressed: () {
                //                   Navigator.pop(context);
                //                 },
                //                 child: Text("Ok")),
                //           ],
                //         );
                //       }) : null;
                //  });

                id++;
              },
              child: Text("Add",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(height: 10),
            TextField(
              controller: pNameController,
              decoration: InputDecoration(
                hintText: "Product name.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pBuyingPriceController,
              decoration: InputDecoration(
                hintText: "Product buying price.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pSellingPriceController,
              decoration: InputDecoration(
                hintText: "Product selling price.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pQuantityController,
              decoration: InputDecoration(
                hintText: "Product quantity.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pBrandController,
              decoration: InputDecoration(
                hintText: "Product brand name.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pSupplierController,
              decoration: InputDecoration(
                hintText: "Product supplier.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pDescController,
              decoration: InputDecoration(
                hintText: "Product description.",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: () async {
                  _image =
                      await _picker!.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: Text("Pick Image")),
            _image != null
                ? Container(
                    width: double.infinity,
                    height: 200,
                    child: Image.file(File(_image!.path)),
                  )
                : Container(),
            SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }
}
