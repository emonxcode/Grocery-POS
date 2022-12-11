//  import 'package:flutter/material.dart';

// import '../../../../controller/salesController.dart';
// import '../../../../models/product.dart';

// Widget stockProductCardMobile(Product product, BuildContext context, SalesController controller){
//     return InkWell(
//       onTap: (){
//         showDialog(context: context, builder: (ctx){
//                   return AlertDialog(
//                     title: Text("Buy more from supplier"),
//                     content: SingleChildScrollView(
//                       child: Column(children: [

//                         TextField(
//                           controller: pQController,
//                           decoration: InputDecoration(
//                             hintText: "Enter quantity.",
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                       ),
//                     ),
//                     actions: [
//                       TextButton(onPressed: (){
//                         controller.addMoreQtyP(int.parse(pQController.text), product.pName!);
//                         pQController.text = "";
//                         Navigator.pop(context);
//                       }, child: Text("UPDATE")),
//                        SizedBox(width: 7),
//                       TextButton(onPressed: (){
//                         Navigator.pop(context);
//                       }, child: Text("CANCEL")),
//                     ],
//                   );
//                 });
//       },
//       child: Container(
//         height: 130,
//         padding: EdgeInsets.all(5),
//         child: Card(
//           elevation: 5,
//           child: Row(
//             children: [
//               Container(
//                 width: 120,
//                 child: Image.network(product.pImgUrl!, fit: BoxFit.contain),
//               ),
              
//               Container(
//                 padding: EdgeInsets.only(left: 3, top: 8, right: 3, bottom: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(product.pName!.length>21? "${product.pName!.substring(0, 20)}..." : product.pName!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                     Text(product.pDesc!),
//                     Spacer(),
//                     Text("Buying Price: ${product.pBuyingPrice!.toString()} TK", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
//                     Text("Selling Price: ${product.pSalePrice!.toString()} Tk", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
//                     Text("Quantity: ${product.pQuantity!.toString()} Pcs", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
//                   ],
//                 ),
//               )
//             ],
//           )
//         ),
//       ),
//     );
//   }