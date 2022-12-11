import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/productController.dart';
import '../../../../models/product.dart';
import 'package:grocery_pos/models/product.dart';
import '../../navigations/widgets/components.dart';

class StoreView extends StatefulWidget {
  StoreView({
    this.searchController,
  });

  TextEditingController? searchController;

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  List<Product> _products = [
    Product(pName: "Pepsi 1 ltr", pBuyingPrice: 37, pSalePrice: 45, pDesc: "no description", pImgUrl: "assets/images/pepsi.png", pQuantity: 15),
    Product(pName: "Potato(kg)", pBuyingPrice: 15, pSalePrice: 25, pDesc: "no description", pImgUrl: "assets/images/potato.png", pQuantity: 10),
    Product(pName: "Cooking Oil 5ltr", pBuyingPrice: 750, pSalePrice: 800, pDesc: "no description", pImgUrl: "assets/images/oil.png", pQuantity: 20),
    Product(pName: "Desi Onion (kg)", pBuyingPrice: 35, pSalePrice: 60, pDesc: "no description", pImgUrl: "assets/images/onion.png", pQuantity: 20),
    Product(pName: "Oreo", pBuyingPrice: 37, pSalePrice: 45, pDesc: "no description", pImgUrl: "assets/images/oreo.png", pQuantity: 20),
    Product(pName: "Chini-gura rice 25kg", pBuyingPrice: 1650, pSalePrice: 1800, pDesc: "no description", pImgUrl: "assets/images/rice.png", pQuantity: 20),
    Product(pName: "Moshla 1pk", pBuyingPrice: 37, pSalePrice: 45, pDesc: "no description", pImgUrl: "assets/images/moshla.png", pQuantity: 20),
  ];


  // bool _isLoaded = true;
  // bool _isInit = true;
  // @override
  // void didChangeDependencies() { 
  //   super.didChangeDependencies();
  //   if (_isInit) {
  //     setState(() {
  //       _isLoaded = false;
  //     });
  //     Provider.of<SalesController>(context).fetchAndSetProducts().then((_) {
  //       setState(() {
  //         _isLoaded = true;
  //       });
  //     });
  //   }
  //   _isInit = false;
  // }

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
                      "Welcome, GroceryPOS",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      "A total pos solution",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      vSearchField("Search products", widget.searchController!),
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