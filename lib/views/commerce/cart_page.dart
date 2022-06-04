import 'package:app2/views/commerce/checkout_page.dart';
import 'package:app2/views/commerce/notifications.dart';
import 'package:provider/provider.dart';

import '../../model/cartmodel.dart';
import 'cartsingle_product.dart';
import 'homepage.dart';
import 'provider/product_provider.dart';

import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

late ProductProvider productProvider;
late List<CartModel> myList;
late int index;

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.getCartModelList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        bottomNavigationBar: Container(
          height: 55,
          width: 80,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.all(10),
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onPressed: () {
              productProvider.addNotification("Notification");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CheckoutPage()));
              setState(() {
                myList.clear();
              });
            },
            child: const Text(
              'Proceed to Checkout',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const DefaultPage(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [NotificationButton()],
          title: const Text(
            'Cart Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, myIndex) {
            index = myIndex;
            return CartSingleProduct(
              isCount: false,
              index: myIndex,
              image: myList[myIndex].image,
              price: myList[myIndex].price,
              name: myList[myIndex].name,
              quantity: myList[myIndex].quantity!,
            );
          },
        ));
  }
}
