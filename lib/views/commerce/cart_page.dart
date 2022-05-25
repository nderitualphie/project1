import 'package:app2/views/commerce/checkout_page.dart';
import 'package:provider/provider.dart';

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

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        bottomNavigationBar: Container(
          height: 55,
          width: 80,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CheckoutPage()));
            },
            child: const Text(
              'Continue',
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
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ))
          ],
          title: const Text(
            'Cart Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(
          itemCount: productProvider.getCartModelListlength,
          itemBuilder: (context, index) => CartSingleProduct(
            isCount: false,
            image: productProvider.getCartModelList[index].image,
            price: productProvider.getCartModelList[index].price,
            name: productProvider.getCartModelList[index].name,
            quantity: productProvider.getCartModelList[index].quantity!,
          ),
        ));
  }
}
