import 'package:app2/views/commerce/cart_page.dart';
import 'package:app2/views/commerce/cartsingle_product.dart';
import 'package:app2/views/commerce/notifications.dart';
import 'package:app2/views/commerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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

  int count = 1;

  @override
  Widget build(BuildContext context) {
    int subtotal = 0;
    int shipping = 100;
    int total;
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach(
      (element) {
        subtotal += element.price! * element.quantity!;
      },
    );
    total = subtotal + shipping;
    return Scaffold(
        bottomNavigationBar: Container(
          height: 55,
          width: 80,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => car))
            },
            child: const Text(
              'Procced to pay',
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
          height: 500,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListView.builder(
              //physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: productProvider.getCheckOutModelListLength,
              itemBuilder: (context, index) {
                return CartSingleProduct(
                    name: productProvider.getCheckOutModelList[index].name,
                    image: productProvider.getCheckOutModelList[index].image,
                    price: productProvider.getCheckOutModelList[index].price,
                    quantity:
                        productProvider.getCheckOutModelList[index].quantity!);
              },
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
