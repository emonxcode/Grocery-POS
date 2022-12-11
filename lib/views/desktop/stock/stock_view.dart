import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/productController.dart';
import '../../../models/product.dart';
import '../navigations/widgets/components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../database/product_database_helper.dart';

class StockView extends StatefulWidget {
  const StockView({super.key});

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 14,
      child: Row(
        children: [
          StockGridView(),
          ModifyOrAddProduct(),
        ],
      ),
    );
  }
}

class StockGridView extends StatefulWidget {
  const StockGridView({super.key});

  @override
  State<StockGridView> createState() => _StockGridViewState();
}

class _StockGridViewState extends State<StockGridView> {
  TextEditingController? searchController = TextEditingController();

  List<Product> _products = [];

  bool _isLoaded = true;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoaded = false;
      });
      Provider.of<SalesController>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoaded = true;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Container(
        padding: EdgeInsets.all(12.0),
        color: Color.fromARGB(255, 234, 234, 254),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inventory Management",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      "All stock products",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      vSearchField("Search products", searchController!),
                      SizedBox(width: 6),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 40,
                          ))
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: GridView.builder(
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    crossAxisCount: 6,
                  ),
                  itemBuilder: (context, i) {
                    return vProductCardGrid(_products[i], context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ModifyOrAddProduct extends StatefulWidget {
  const ModifyOrAddProduct({super.key});

  @override
  State<ModifyOrAddProduct> createState() => _ModifyOrAddProductState();
}

class _ModifyOrAddProductState extends State<ModifyOrAddProduct> {

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
    return Expanded(
      flex: 4,
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Color.fromARGB(255, 255, 255, 255),
        child: SingleChildScrollView(
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
           _image != null? Container(
              width: double.infinity,
              height: 200,
              child: Image.file(File(_image!.path)),
            ) : Container(),
            SizedBox(height: 10),

    TextButton(
              onPressed: () async {
                Product newProduct = Product(
                    pName: pNameController.text,
                    pDesc: pDescController.text,
                    pBuyingPrice: int.parse(pBuyingPriceController.text),
                    pSalePrice: int.parse(pSellingPriceController.text),
                    pQuantity: int.parse(pQuantityController.text),
                    pImgUrl: "_image!=null? _image!.path : null",
                    pBrand: pBrandController.text,
                    pSupplier: pSupplierController.text);
              await Provider.of<SalesController>(context, listen: false).addProduct(newProduct);

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
              child: Text("Add", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),


          ]),
        ),
      ),
      ),
    );
  }
}
