import 'package:flutter/material.dart';
import 'package:grocery_pos/controller/productController.dart';
import 'package:grocery_pos/models/product.dart';
import 'package:provider/provider.dart';

import '../../../controller/salesController.dart';
import '../widgets/components_mobile.dart';

class ProductsGridViewMobile extends StatefulWidget {
  ProductsGridViewMobile({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  State<ProductsGridViewMobile> createState() => _ProductsGridViewMobileState();
}

class _ProductsGridViewMobileState extends State<ProductsGridViewMobile> {
  bool _isLoaded = true;
  bool _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSalesData();
  }

  void fetchSalesData() async {
    await SalesController().getAllSeles();
  }

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

  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    _products = Provider.of<ProductController>(context).getProducts();
    return Expanded(
      flex: 11,
      child: Container(
        padding: EdgeInsets.all(7.0),
        color: Color.fromARGB(255, 234, 234, 254),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, GroceryPOS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              "A total pos solution",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 50,
              child: Row(
                children: [
                  vSearchFieldMobile(
                      "Search products", widget.searchController),
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
            SizedBox(height: 10.0),
            Expanded(
              child: _isLoaded
                  ? GridView.builder(
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, i) {
                        return ProductCardGridMobile(product: _products[i]);
                      })
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
