import 'package:app2/views/commerce/homepage.dart';
import 'package:app2/views/commerce/notifications.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:mpesa/mpesa.dart';

import 'package:provider/provider.dart';
import '../../model/cartmodel.dart';
import '../../provider/product_provider.dart';
import 'checkoutsingleproduct.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Mpesa mpesa = Mpesa(
    clientKey: "2TC5Ah3BZdh7wP6o5SHjbuKID3EXC9ZA",
    clientSecret: "DTaCzkpNimoDCAmq",
    passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
    environment: "sandbox",
  );
  myMethod() {
    mpesa
        .lipaNaMpesa(
      transactionDescription: "Payment of Goods",
      transactionType: "CustomerPayBillOnline",
      phoneNumber: "254791784445",
      accountReference: "Agrocommerce LTD",
      amount: total!,
      businessShortCode: "174379",
      callbackUrl: "https://6319-154-122-136-25.in.ngrok.io/payment",
    )
        .then((result) {
      FirebaseFirestore.instance.collection("CheckoutResults").add({
        "MerchantRequestID": result.MerchantRequestID,
        "CheckoutRequestID": result.CheckoutRequestID,
        "ResponseCode": result.ResponseCode,
        "ResponseDescription": result.ResponseDescription,
        "CustomerMessage": result.CustomerMessage,
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

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

  double? total;
  late int index;
  late User user;
  late List<CartModel> myList;
  int count = 1;
  Widget _buildButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        child: const Text(
          'Lipa na Mpesa',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
        onPressed: () {
          FirebaseFirestore.instance.collection("Order").add({
            "ProductDetails": productProvider.getCheckOutModelList
                .map((e) => {
                      "ProductName": e.name,
                      "ProductPrice": e.price,
                      "ProductQuantity": e.quantity,
                    })
                .toList(),
            "UserDetails": productProvider.getUserModelList
                .map((e) => {
                      "userAddress": e.address,
                      "userPhone": e.phoneNo,
                      "Useremail": e.email,
                      "TotalAmount": total ?? "",
                      "userId": user.uid
                    })
                .toList(),
          });
          setState(() {
            myList.clear();
          });
          myMethod();
        });
  }

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(this.context, listen: false);
    myList = productProvider.checkOutModelList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser!;
    double subtotal = 0;
    double shipping = 10;
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getUserdata();
    productProvider.getCheckOutModelList.forEach(
      (element) {
        subtotal += element.price! * element.quantity!;
      },
    );
    total = subtotal + shipping;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        bottomNavigationBar: Container(
            height: 55,
            width: 150,
            margin: EdgeInsets.all(10),
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
              height: 80,
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
