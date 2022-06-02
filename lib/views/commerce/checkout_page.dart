import 'package:app2/views/commerce/homepage.dart';
import 'package:app2/views/commerce/notifications.dart';
import 'package:app2/views/commerce/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/cartmodel.dart';
import 'checkoutsingleproduct.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

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
  late List<CartModel> myList;
  int count = 1;
  Widget _buildButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          padding: EdgeInsets.all(10),
        ),
        onPressed: () {
          productProvider.userModelList.map((e) => {
                if (productProvider.getCheckOutModelList.isNotEmpty)
                  {
                    FirebaseFirestore.instance.collection("Order").add({
                      "Product": productProvider.getCheckOutModelList
                          .map((c) => {
                                "ProductName": c.name,
                                "ProductPrice": c.price,
                                "ProductQuantity": c.quantity,
                                "ProductImage": c.image,
                              })
                          .toList(),
                      "TotalPrice": total,
                      "UserName": e.userName,
                      "UserEmail": e.email,
                      "UserNumber": e.phoneNo,
                      "UserAddress": e.address,
                      "UserId": user.uid,
                    })
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("No Item Added"),
                      ),
                    )
                  }
              }.toList());
        },
        child: const Text(
          'Proceed to pay',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ));
  }

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser!;
    int subtotal = 0;
    int shipping = 100;
    int total;
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.userModelList;
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
            width: 150,
            margin: const EdgeInsets.all(10),
            child: _buildButton()),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DefaultPage()));
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
              height: 450,
              child: ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, myIndex) {
                  print(myList.length);
                  index = myIndex;
                  return CheckOutSingleProduct(
                    index: myIndex,
                    name: myList[myIndex].name!,
                    image: myList[myIndex].image!,
                    price: myList[myIndex].price!,
                    quantity: myList[myIndex].quantity!,
                  );
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
