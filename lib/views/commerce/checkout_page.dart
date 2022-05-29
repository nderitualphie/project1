import 'package:app2/views/commerce/cart_page.dart';
import 'package:app2/views/commerce/cartsingle_product.dart';
import 'package:app2/views/commerce/notifications.dart';
import 'package:app2/views/commerce/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

// @override
// void initState() {
//   productProvider = Provider.of<ProductProvider>(context, listen: false);
//   myList = productProvider.checkOutModelList;
//   super.initState();
// }
class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ProductProvider productProvider;
  Widget _buildBottomDetails(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(startName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(endName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
      ],
    );
  }

  late int total;
  late int index;
  late User user;
//   Widget _buildButton() {
//     return Column(
//         children: productProvider.userModelList.map((e) {
//       return Container(
//         // height: 55,
//         // width: 70,
//         child: ElevatedButton(
//           child: const Text(
//             'Procced to pay',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
//           ),
//           onPressed: () {
// //             if(productProvider.checkOutModelList.isNotEmpty){
// // FirebaseFirestore.instance.collection("orders").doc(user.uid).set({
// //               "product":productProvider.checkOutModelList.map((c){
// // "productName" :c.name
// //               "productPrice":
// //                   c.price;
// //                   "productQuantity":
// //                   c.quantity;
// //               }).toList(),

// //               "Total Price": total,

// //               "userName": e.userName,
// //               "email": e.email,
// //               "address": e.address,
// //               "userId": user.uid,
// //               "phoneNo": e.phoneNo,
// //             });
// //             productProvider.clearCheckoutProduct();
// //           }

// //         }),
// //       );
// //     }).toList()
// );
//             }

//   }

  int count = 1;

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser!;
    int subtotal = 0;
    int shipping = 100;

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach(
      (element) {
        subtotal += element.price! * element.quantity!;
      },
    );
    total = subtotal + shipping;

    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Container(
          height: 55,
          width: 70,
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            child: Text("proceed to pay"),
            onPressed: () {},
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [
            NotificationButton(),
          ],
          title: const Text(
            'Checkout Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          //padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 400,
              child: ListView.builder(
                itemCount: productProvider.getCheckOutModelListLength,
                //shrinkWrap: true,
                itemBuilder: (context, myIndex) {
                  print(productProvider.getCheckOutModelListLength);
                  index = myIndex;
                  return CartSingleProduct(
                      isCount: true,
                      index: myIndex,
                      name: productProvider.getCheckOutModelList[myIndex].name,
                      image:
                          productProvider.getCheckOutModelList[myIndex].image,
                      price:
                          productProvider.getCheckOutModelList[myIndex].price,
                      quantity: productProvider
                          .getCheckOutModelList[myIndex].quantity!);
                },
              ),
            ),
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomDetails(
                      startName: 'Sub Total',
                      endName: "ksh ${subtotal.toString()}"),
                  _buildBottomDetails(
                      startName: 'Shipping',
                      endName: "ksh ${shipping.toString()}"),
                  _buildBottomDetails(
                      startName: 'Total', endName: "ksh ${total.toString()}"),
                ],
              ),
            ),
          ]),
        ));
  }
}
