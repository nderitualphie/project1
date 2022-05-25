import 'package:app2/views/commerce/homepage.dart';
import 'package:flutter/material.dart';

class CartSingleProduct extends StatefulWidget {
  final String? name;
  final String? image;
  int quantity;
  final int? price;
  
  CartSingleProduct(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      required this.quantity,
     })
      : super(key: key);

  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
   

    return Container(
      height: 180,
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.image!),
                      ),
                    )),
                Container(
                    height: 140,
                    width: 150,
                    child: ListTile(
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name!),
                            Text(
                              "ksh ${widget.price.toString()}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width:  100 ,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child:
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (widget.quantity > 1) {
                                            widget.quantity--;
                                          }
                                        });
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text(
                                    widget.quantity.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.quantity++;
                                          // productProvider.getCountData(
                                          //     count = widget.quantity);
                                        });
                                      },
                                      child: const Icon(Icons.add)),
                                ]
                                )          
                      
                      )],
              
                    ),
            
            ),
            )],
            ),
          ],
        ),
      ),
    );
  }
}
